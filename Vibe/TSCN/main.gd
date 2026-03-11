extends Node2D

var laser_scene = preload("res://Vibe/TSCN/Laser.tscn")

@onready var player = $Player
# 노드 경로를 변수에 직접 담아두면 훨씬 안전합니다.
@onready var score_label = $Player/ScoreLabel 

var score: float = 0.0
var spawn_timer: float = 0.0

func _process(delta):
	# 1. 점수 계산 (정상 작동 중)
	score += delta * 10

	
	# 2. 화면 출력 (변수 'a'를 거치지 않고 직접 노드에 꽂기)
	if score_label:
		score_label.text = "SCORE: %d" % [int(score)]


	# 3. 레이저 소환 (기존 코드 유지)
	spawn_timer += delta
	if spawn_timer >= 2.0:
		spawn_laser()
		spawn_timer = 0

func spawn_laser():
	var laser = laser_scene.instantiate()
	laser.position = player.position
	laser.rotation = randf_range(0, TAU)
	add_child(laser)
