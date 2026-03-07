extends Node2D

@onready var anim_tree = $"AnimationTreeB"
@onready var anim_player = $"AnimationTreeB/AnimationPlayer" 

func _process(_delta):
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if input_vector != Vector2.ZERO:
		# 1. 애니트리에 입력 좌표 전달
		anim_tree.set("parameters/BlendSpace2D/blend_position", input_vector)
		
		# 2. 디버깅: 현재 재생 중인 실제 애니메이션 확인
		if anim_player:
			print("입력: ", input_vector, " | 재생 중: ", anim_player.current_animation)
