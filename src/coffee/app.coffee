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
  ], (
    LeapPlayground
  ) ->
    #
    playground = new LeapPlayground()

    window.addEventListener "resize", (event) ->
      playground.handleWindowResize event

    document.addEventListener "mousemove", (event) ->
      playground.handleMouseMove event

    animate = ->
      requestAnimationFrame animate
      playground.play()

    animate()