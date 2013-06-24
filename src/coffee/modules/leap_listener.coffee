define [
    "leapjs"
    "eventemitter2"
  ], (
    Leap,
    EventEmitter,
  ) ->
    class LeapListener extends EventEmitter
      constructor: ->
        @retry = 100
        @interval = 1000


        @init()


      init: ->
        @emit "connecting"

        @leapController = new Leap.Controller({
            enableGestures: true
          })

        @registerLeapEventHandlers()

        @leapController.connect()

      registerLeapEventHandlers: ->
        @leapController.on "connect", =>

        @leapController.on "disconnect", =>
          @emit "disconnected"
          if @retry > 0

            setTimeout =>
              @init()
            , @interval

            @interval = @interval * 2 if @interval < 64000
            @retry = @retry - 1

        @leapController.on "ready", =>
          @emit "connected"
          @retry = 100
          @interval = 1000

        @leapController.on 'frame', (frame) =>

          # @recordFrame frame

          return unless frame.valid
          @emit "frame", frame

          if frame.hands.length > 0
            hands = []
            for hand in frame.hands
              if hand.valid
                hands.push hand

            if hands.length > 0
              @emit "hands",
                frame: frame
                hands: hands
            else
              @emit "no-hand"

          if frame.gestures? and frame.gestures.length > 0
            @emit "gestures", frame.gestures

    return LeapListener

