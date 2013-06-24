define [
    "threejs"
    "modules/leap_listener"
    "modules/frame_visualizer"
    "modules/camera"
    "modules/grid"
  ], (
    THREE,
    LeapListener,
    LPFrameVisualizer,
    LPCamera,
    LPGrid
  ) ->

    class LeapPlayground
      constructor: (layers) ->
        @name = "LeapMotion Playground"
        @canvas = document.getElementById("canvas")
        @renderer = new THREE.WebGLRenderer()
        @canvas.appendChild @renderer.domElement
        @camera = new LPCamera()
        @handleWindowResize()

        @leap = new LeapListener()

        @scene = new THREE.Scene()
        @scene.fog = new THREE.Fog( 0x050505, 100, 8000 )

        light = new THREE.DirectionalLight(0x999999, 2)
        light.position.set(1, 0, 1).normalize()
        @scene.add light
        light = new THREE.DirectionalLight(0xffffff)
        light.position.set(-1, -8, -1).normalize()
        @scene.add light

        @layers = {}
        for name, layerFunc of layers
          @layers[name] = new layerFunc(@scene, @renderer)


        @leap.on "frame", (frame) =>
          for key, object of @layers
            object.handleLeapFrame frame if object.handleLeapFrame?

      play: ->
        @update()
        @render()

      update: ->
        # update states

        for key, object of @layers
          object.update() if object.update?
        @camera.update()

      render: ->
        # draw stuff
        @renderer.render @scene, @camera.get()


      handleWindowResize: ->
        @renderer.setSize window.innerWidth, window.innerHeight
        @camera.handleWindowResize window.innerWidth, window.innerHeight

      handleMouseMove: (event) ->
        @camera.handleMouseMove event

      handleKeyPress: (event) ->
        console.log "Pressed #{event.keyCode}"
        for key, object of @layers
          object.handleKeypress event if object.handleKeypress?

    return LeapPlayground

