define [
    "threejs"
  ], (
    THREE
  ) ->
    class LPGrid
      constructor: (@scene, @renderer) ->
        geometry = new THREE.CubeGeometry(150,150,150)
        material = new THREE.MeshLambertMaterial( { color: 0xFFffFF } )
        @cube = new THREE.Mesh( geometry, material )
        @scene.add( @cube )

        texture = THREE.ImageUtils.loadTexture(
              "images/mark.png"
            )

        texture.anisotropy = @renderer.getMaxAnisotropy();
        texture.wrapS = texture.wrapT = THREE.RepeatWrapping;
        texture.repeat.set( 512, 512 );

        material =
          new THREE.ParticleBasicMaterial({
            color: 0xffffff
            size: 80
            opacity: 0.6
            map: texture
            blending: THREE.AdditiveBlending
            transparent: true
            depthWrite: true
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
        grid.sortParticles = true
        @scene.add grid

      update: ->
        @cube.rotation.x += 0.1;
        @cube.rotation.y += 0.1;

    return LPGrid

