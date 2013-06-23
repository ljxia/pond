console.log "playground ready"


class LeapPlayground
  constructor: ->
    @name = "LeapMotion Playground"
    @canvas = document.getElementById("canvas")
    @renderer = new THREE.WebGLRenderer()
    @canvas.appendChild @renderer.domElement
    @camera = new LPCamera()
    @handleWindowResize()

    @scene = new THREE.Scene()
    @scene.fog = new THREE.Fog( 0x050505, 500, 6000 )

    light = new THREE.DirectionalLight(0x999999, 2)
    light.position.set(1, 0, 1).normalize()
    @scene.add light
    light = new THREE.DirectionalLight(0xffffff)
    light.position.set(-1, -8, -1).normalize()
    @scene.add light


    @layers =
      "grid": new LPGrid(@scene)

    ######



  play: ->
    @update()
    @render()

  update: ->
    # update states

    for key, object of @layers
      object.update()
    @camera.update()

  render: ->
    # draw stuff
    @renderer.render @scene, @camera.get()


  handleWindowResize: ->
    @renderer.setSize window.innerWidth, window.innerHeight
    @camera.handleWindowResize window.innerWidth, window.innerHeight

  handleMouseMove: (event) ->
    @camera.handleMouseMove event

$ ->
  playground = new LeapPlayground()

  jQuery(window).on 'resize', (event) ->
    playground.handleWindowResize event

  jQuery(window).on 'mousemove', (event) ->
    playground.handleMouseMove event

  animate = ->
    requestAnimationFrame animate
    playground.play()

  animate()