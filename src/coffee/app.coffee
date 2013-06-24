require.config
  paths:
    "threejs": "lib/three.min"
    "eventemitter2": "lib/eventemitter2"
    "leapjs": "lib/leap.min"
  shim:
    "threejs":
      exports: "THREE"
    "eventemitter2":
      exports: "EventEmitter"
    "leapjs":
      exports: "Leap"

define [
    "playground"
    "modules/grid"
  ], (
    LeapPlayground,
    LPGrid
  ) ->
    #
    playground = new LeapPlayground(
      "grid": LPGrid
    )

    window.addEventListener "resize", (event) ->
      playground.handleWindowResize event

    document.addEventListener "mousemove", (event) ->
      playground.handleMouseMove event

    animate = ->
      requestAnimationFrame animate
      playground.play()

    animate()