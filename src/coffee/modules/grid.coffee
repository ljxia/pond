class LPGrid
  constructor: (@scene) ->
    geometry = new THREE.CubeGeometry(150,150,150)
    material = new THREE.MeshLambertMaterial( { color: 0xFFffFF } )
    @cube = new THREE.Mesh( geometry, material )
    @scene.add( @cube )

    material = new THREE.LineBasicMaterial
      color: 0x999999
      opacity: 0.3


    # fill a cube of 2000px long on each side
    length = 4
    distance = 300
    for x in [(-length)..length]
      for y in [(-length)..length]
        for z in [(-length)..length]
          # console.log x * 100,y * 100,z * 100

          geometry = new THREE.Geometry();
          geometry.vertices.push(new THREE.Vector3(x * distance, y * distance - 4, z * distance))
          geometry.vertices.push(new THREE.Vector3(x * distance, y * distance + 4, z * distance))
          line = new THREE.Line(geometry, material)
          @scene.add(line)

          geometry = new THREE.Geometry();
          geometry.vertices.push(new THREE.Vector3(x * distance - 4, y * distance, z * distance))
          geometry.vertices.push(new THREE.Vector3(x * distance + 4, y * distance, z * distance))
          line = new THREE.Line(geometry, material)
          @scene.add(line)

          # geometry = new THREE.Geometry();
          # geometry.vertices.push(new THREE.Vector3(x * distance, y * distance, z * distance - 4))
          # geometry.vertices.push(new THREE.Vector3(x * distance, y * distance, z * distance + 4))
          # line = new THREE.Line(geometry, material)
          # @scene.add(line)


  update: ->
    @cube.rotation.x += 0.1;
    @cube.rotation.y += 0.1;

