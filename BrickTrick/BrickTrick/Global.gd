extends Node

const DIMENSION = Vector3(16, 64, 16)
const TEXTURE_ATLAS_SIZE = Vector2(4,4)

enum {
	TOP,
	BOTTOM,
	LEFT,
	RIGHT,
	FRONT,
	BACK,
	SOLID
}

enum {
	AIR,
	GRASS,
	DIRTY,
	SAND,
	STONE,
	ICE
}

const types = {
	AIR: {
		SOLID: false
	},
	GRASS: {
		TOP: Vector2(0, 0), BOTTOM: Vector2(2, 0),
		LEFT: Vector2(1, 0), RIGHT: Vector2(1, 0), FRONT: Vector2(1, 0), BACK: Vector2(1, 0),
		SOLID: true
	},
	DIRTY: {
		TOP: Vector2(2, 0), BOTTOM: Vector2(2, 0),
		LEFT: Vector2(2, 0), RIGHT: Vector2(2, 0), FRONT: Vector2(2, 0), BACK: Vector2(2, 0),
		SOLID: true
	},
	SAND: {
		TOP: Vector2(0, 1), BOTTOM: Vector2(0, 1),
		LEFT: Vector2(0, 1), RIGHT: Vector2(0, 1), FRONT: Vector2(0, 1), BACK: Vector2(0, 1),
		SOLID: true
	},
	STONE: {
		TOP: Vector2(1, 1), BOTTOM: Vector2(1, 1),
		LEFT: Vector2(1, 1), RIGHT: Vector2(1, 1), FRONT: Vector2(1, 1), BACK: Vector2(1, 1),
		SOLID: true
	},
	ICE: {
		TOP: Vector2(2, 1), BOTTOM: Vector2(2, 1),
		LEFT: Vector2(2, 1), RIGHT: Vector2(2, 1), FRONT: Vector2(2, 1), BACK: Vector2(2, 1),
		SOLID: true
	}
}
