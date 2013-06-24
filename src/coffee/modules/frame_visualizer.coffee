define [
    "jquery"
    "eventemitter2"
  ], (
    $,
    EventEmitter
  ) ->
    class LPFrameVisualizer extends EventEmitter
      constructor: (@scene, @renderer) ->
        @recording = true

        @container = $("<div/>").attr("id", "frame-visualizer")
        @frame_content = $("<pre/>").attr("id", "frame-detail").html("Recording ... Press SPACE to pause.")
        $(@renderer.domElement).parent().append @container
        $(@renderer.domElement).parent().append @frame_content
        @history_length = 100
        @frames = []

        for f in [0..@history_length]
          @container.append $("<div/>").addClass("frame").attr("data-frame", f)

        _this = @
        @container.on "mouseover", ".frame", ->
          index = parseInt($(this).attr("data-frame"))
          if index < _this.frames.length
            frame = _this.frames[index]

            console.log frame

            frame_data = JSON.stringify(frame, (key, value) ->
              if key is "frame"
                undefined
              else
                value
            , 4)#.replace("\r", "<br/>")

            console.log frame_data

            _this.frame_content.html( frame_data ).show()

      handleLeapFrame: (frame) ->
        return unless @recording
        # delete frame.controller
        # delete.frame.data
        if @frames.length > @history_length
          @frames.shift()
        @frames.push frame.data

      update: ->
        @container.find(".frame").each (index, item) =>
          if index < @frames.length
            frame = @frames[index]

            if frame.hands.length > 0
              $(item).addClass "active"
            else
              $(item).removeClass "active"

      handleKeypress: (e) ->
        if e.keyCode == 32
          e.preventDefault()
          @recording = !@recording
          if @recording
            @frame_content.html "Recording ... Press SPACE to pause."
          else
            @frame_content.html "Paused. Press SPACE to record."

    return LPFrameVisualizer