extends Node2D

@export var speed: float = 220.0

const PLAYER_SIZE := Vector2(32.0, 32.0)
const PLAYER_COLOR := Color(0.2, 0.9, 0.6)

var start_position := Vector2(100.0, 100.0)
var player_position := Vector2(100.0, 100.0)

func _ready() -> void:
	player_position = start_position
	queue_redraw()

func _process(delta: float) -> void:
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction != Vector2.ZERO:
		player_position += direction * speed * delta

	if Input.is_action_just_pressed("reset_player"):
		player_position = start_position

	var viewport_size := get_viewport_rect().size
	player_position.x = clamp(player_position.x, 0.0, viewport_size.x - PLAYER_SIZE.x)
	player_position.y = clamp(player_position.y, 0.0, viewport_size.y - PLAYER_SIZE.y)

	queue_redraw()

func _draw() -> void:
	draw_rect(Rect2(player_position, PLAYER_SIZE), PLAYER_COLOR)
