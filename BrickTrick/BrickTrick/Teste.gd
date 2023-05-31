@tool

extends MeshInstance3D


func _ready():
	if mesh == null:
		mesh = ArrayMesh.new()
	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	var a = Vector3(-1, -1, 0)
	var b = Vector3(-1, 1, 0)
	var c = Vector3(1, 1, 0)
	var d = Vector3(1, -1, 0)
	st.add_triangle_fan([a,b,c])
	st.add_triangle_fan([a,c,d])
	st.commit(mesh)


