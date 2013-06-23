class LPGrid
  constructor: (@scene) ->
    geometry = new THREE.CubeGeometry(150,150,150)
    material = new THREE.MeshLambertMaterial( { color: 0xFFffFF } )
    @cube = new THREE.Mesh( geometry, material )
    @scene.add( @cube );

  update: ->
    @cube.rotation.x += 0.1;
    @cube.rotation.y += 0.1;

