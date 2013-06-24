define [
    "jquery"
    "eventemitter2"
  ], (
    $,
    EventEmitter
  ) ->
    class LPFrameVisualizer extends EventEmitter
      constructor: (@scene, @renderer) ->
        @container = $("<div/>").attr("id", "frame-visualizer")
        $(@renderer.domElement).parent().append @container
        @history_length = 100
        @frames = []

        for f in [0..@history_length]
          @container.append $("<div/>").addClass("frame")

      handleLeapFrame: (frame) ->
        if @frames.length > @history_length
          @frames.shift()
        @frames.push frame

      update: ->
        @container.find(".frame").each (index, item) =>
          if index < @frames.length
            frame = @frames[index]

            if frame.hands.length > 0
              $(item).addClass "active"

            else
              $(item).removeClass "active"

    return LPFrameVisualizer