require.config
  paths:
    "jquery": "lib/jquery.min"
    "threejs": "lib/three.min"
    "eventemitter2": "lib/eventemitter2"
    "leapjs": "lib/leap.min"
    "underscore": "lib/underscore.min"
  shim:
    "threejs":
      exports: "THREE"
    "eventemitter2":
      exports: "EventEmitter"
    "leapjs":
      exports: "Leap"
    "underscore":
      exports: "_"

define [
    "playground"
    "modules/grid"
    "modules/frame_visualizer"
  ], (
    LeapPlayground,
    LPGrid,
    LPFrameVisualizer
  ) ->
    #
    playground = new LeapPlayground(
      "grid": LPGrid
      "frames": LPFrameVisualizer
    )

    window.addEventListener "resize", (event) ->
      playground.handleWindowResize event

    document.addEventListener "mousemove", (event) ->
      playground.handleMouseMove event

    document.addEventListener "keypress", (event) ->
      playground.handleKeyPress event

    animate = ->
      requestAnimationFrame animate
      playground.play()

    animate()