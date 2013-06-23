class LPCamera
  constructor: ->
    @camera = new THREE.PerspectiveCamera( 90, window.innerWidth / window.innerHeight, 1, 9000 )
    @camera.position.set( 0, 0, 1800 )

    @cameraTarget = new THREE.Vector3( 0, 0, 0 )

  get: ->
    return @camera

  update: ->
    # @camera.lookAt( 0, 0, 0 )
    @camera.position.x += 0.1 * (@cameraTarget.x * 500 - @camera.position.x)
    @camera.position.y += 0.1 * (@cameraTarget.y * 500 - @camera.position.y)
    @camera.updateProjectionMatrix()

    console.log @camera.position

  handleWindowResize: (width, height) ->
    @camera.aspect = width / height
    @camera.updateProjectionMatrix()

  handleMouseMove: (e) ->
    e.preventDefault()
    @cameraTarget.x = ( e.clientX / window.innerWidth ) * 2 - 1
    @cameraTarget.y = - ( e.clientY / window.innerHeight ) * 2 + 1