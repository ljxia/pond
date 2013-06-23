class LPGrid
  constructor: (@scene, @renderer) ->
    geometry = new THREE.CubeGeometry(150,150,150)
    material = new THREE.MeshLambertMaterial( { color: 0xFFffFF } )
    @cube = new THREE.Mesh( geometry, material )
    @scene.add( @cube )

    # material = new THREE.LineBasicMaterial
    #   color: 0x999999
    #   opacity: 0.3

    texture = THREE.ImageUtils.loadTexture(
          "images/mark.png"
        )

    texture.anisotropy = @renderer.getMaxAnisotropy();
    texture.wrapS = texture.wrapT = THREE.RepeatWrapping;
    texture.repeat.set( 512, 512 );

    material =
      new THREE.ParticleBasicMaterial({
        color: 0xFFFFFF
        size: 40
        opacity: 1.0
        map: texture
        blending: THREE.AdditiveBlending
        transparent: true
      });


    # fill a cube of 2000px long on each side
    length = 10
    distance = 500

    geometry = new THREE.Geometry()
    geometry.dynamic = false

    for x in [(-length)..length]
      for y in [(-length)..length]
        for z in [(-length)..length]
          geometry.vertices.push(new THREE.Vector3(x * distance, y * distance, z * distance))

    grid = new THREE.ParticleSystem(geometry, material)
    @scene.add grid

  update: ->
    @cube.rotation.x += 0.1;
    @cube.rotation.y += 0.1;

