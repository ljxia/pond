console.log "playground ready"


class LeapPlayground
  constructor: ->
    @canvas = document.getElementById("canvas")
    @renderer = new THREE.WebGLRenderer()
    @canvas.appendChild @renderer.domElement
    @camera = new LPCamera()

    @name = "playground"

  play: ->
    @update()
    @render()

  update: ->
    # update states

  render: ->
    # draw stuff


  handleWindowResize: ->
    @renderer.setSize window.innerWidth, window.innerHeight
    @camera.handleWindowResize window.innerWidth, window.innerHeight

$ ->
  playground = new LeapPlayground()

  jQuery(window).on 'resize', (event) ->
    playground.handleWindowResize event

  animate = ->
    requestAnimationFrame animate
    playground.play()

  animate()