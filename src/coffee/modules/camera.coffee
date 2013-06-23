class LPCamera
  constructor: ->
    console.log "new camera"
    @camera = new THREE.PerspectiveCamera( 90, window.innerWidth / window.innerHeight, 1, 9000 )
    @camera.position.set( 0, 900, 2400 )

  update: ->

  handleWindowResize: (width, height) ->
    @camera.aspect = width / height
    @camera.updateProjectionMatrix()