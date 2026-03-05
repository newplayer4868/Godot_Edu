extends Node2D

# @onready를 붙이면, 씬이 로드된 후 딱 한 번만 자동으로 실행됩니다.
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

func _input(event):
	#클릭 받았으면
	if event.is_action_pressed("click"):
		print("click")
		# 현재 상태 머신의 상태를 확인합니다.
		var current_state = state_machine.get_current_node()
		
		#현재 상태가 어택이 아니면
		if current_state != "Attack":
			state_machine.travel("Attack")
			#어택 명령 수행해라
			
func _physics_process(delta):
	# 1. 공격 중이면 이동 로직을 아예 무시합니다.
	if state_machine.get_current_node() == "Attack":
		return

	var direction = Input.get_axis("ui_left", "ui_right")
	var current_state = state_machine.get_current_node()
	
	# 2. 이동/대기 전환 시: "지금 그 상태가 아닐 때만" 명령을 내립니다!
	if direction != 0:
		if current_state != "Move": # 이미 Move 중이면 명령하지 않음
			state_machine.travel("Move")
	else:
		if current_state != "Idle": # 이미 Idle 중이면 명령하지 않음
			state_machine.travel("Idle")
