extends WorldEnvironment

var chunk_scene = preload("res://Chunk.tscn")

var load_radius: int = 5
@onready
var chunks = $Chunks
@onready
var player = $Player

var load_thread = Thread.new()

func _ready():
	for i in range(0, load_radius):
		for j in range(0, load_radius):
			var chunk = chunk_scene.instantiate()
			chunk.chunk_position = Vector2(i, j)
			chunks.add_child(chunk)
			
	load_thread.start(_thread_process)
	
	player.connect("place_block", _on_player_place_block)
	player.connect("break_block", _on_player_break_block)
	
func _thread_process():
	while (true):
		for c in chunks.get_children():
			var cx = c.chunk_position.x
			var cz = c.chunk_position.y
			
			var px = floor(player.position.x / Global.DIMENSION.x)
			var pz = floor(player.position.z / Global.DIMENSION.z)
			
			var new_x = posmod(cx - px + load_radius / 2, load_radius) + px - load_radius / 2
			var new_z = posmod(cz - pz + load_radius / 2, load_radius) + pz - load_radius / 2
			
			if (new_x != cx or new_z != cz):
				c.chunk_position = Vector2(int(new_x), int(new_z))
				c.generate()
				c.update()

func get_chunk(chunk_pos):
	for c in chunks.get_children():
		if c.chunk_position == chunk_pos:
			return c
	return null

func _on_player_place_block(pos, t):
	var cx = int(floor(pos.x / Global.DIMENSION.x))
	var cz = int(floor(pos.z / Global.DIMENSION.z))
	
	var bx = posmod(floor(pos.x), int(Global.DIMENSION.x))
	var by = posmod(floor(pos.y), int(Global.DIMENSION.y))
	var bz = posmod(floor(pos.z), int(Global.DIMENSION.z))
	
	var c = get_chunk(Vector2(cx, cz))
	if c != null:
		c.blocks[bx][by][bz] = t
		c.update()

func _on_player_break_block(pos):
	_on_player_place_block(pos, Global.AIR)












