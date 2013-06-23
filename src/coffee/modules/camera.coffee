class LPCamera
  constructor: ->
    @camera = new THREE.PerspectiveCamera( 90, window.innerWidth / window.innerHeight, 1, 9000 )
    @camera.position.set( 0, 0, 600 )

  get: ->
    return @camera

  update: ->

  handleWindowResize: (width, height) ->
    @camera.aspect = width / height
    @camera.updateProjectionMatrix()