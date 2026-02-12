extends Node2D

@export var speed: float = 220.0

const PLAYER_SIZE := Vector2(32.0, 32.0)
const PLAYER_COLOR := Color(0.2, 0.9, 0.6)
const COLLECTIBLE_RADIUS := 10.0
const COLLECTIBLE_COLOR := Color(1.0, 0.8, 0.2)

var start_position := Vector2(100.0, 100.0)
var player_position := Vector2(100.0, 100.0)
var collectible_position := Vector2.ZERO
var score := 0
var rng := RandomNumberGenerator.new()

@onready var score_label: Label = $ScoreLabel

func _ready() -> void:
	rng.randomize()
	_reset_run()
	queue_redraw()

func _process(delta: float) -> void:
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction != Vector2.ZERO:
		player_position += direction * speed * delta

	if Input.is_action_just_pressed("reset_player"):
		_reset_run()

	var viewport_size := get_viewport_rect().size
	player_position.x = clamp(player_position.x, 0.0, viewport_size.x - PLAYER_SIZE.x)
	player_position.y = clamp(player_position.y, 0.0, viewport_size.y - PLAYER_SIZE.y)

	if _is_collectible_collected():
		score += 1
		_update_score_label()
		_spawn_collectible()

	queue_redraw()

func _draw() -> void:
	draw_rect(Rect2(player_position, PLAYER_SIZE), PLAYER_COLOR)
	draw_circle(collectible_position, COLLECTIBLE_RADIUS, COLLECTIBLE_COLOR)

func _reset_run() -> void:
	player_position = start_position
	score = 0
	_update_score_label()
	_spawn_collectible()

func _is_collectible_overlapping_player(candidate_pos: Vector2) -> bool:
	var player_rect := Rect2(player_position, PLAYER_SIZE)
	var closest_x := clamp(candidate_pos.x, player_rect.position.x, player_rect.end.x)
	var closest_y := clamp(candidate_pos.y, player_rect.position.y, player_rect.end.y)
	var closest_point := Vector2(closest_x, closest_y)
	return closest_point.distance_to(candidate_pos) <= COLLECTIBLE_RADIUS

func _spawn_collectible() -> void:
	var viewport_size := get_viewport_rect().size
	var candidate := Vector2.ZERO
	var max_attempts := 10
	for i in range(max_attempts):
		candidate = Vector2(
			rng.randf_range(COLLECTIBLE_RADIUS, viewport_size.x - COLLECTIBLE_RADIUS),
			rng.randf_range(COLLECTIBLE_RADIUS, viewport_size.y - COLLECTIBLE_RADIUS)
		)
		if not _is_collectible_overlapping_player(candidate):
			collectible_position = candidate
			return
	collectible_position = candidate

func _is_collectible_collected() -> bool:
	return _is_collectible_overlapping_player(collectible_position)

func _update_score_label() -> void:
	score_label.text = "Score: %d" % score
