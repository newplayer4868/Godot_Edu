extends Node2D

# @onready를 붙이면, 씬이 로드된 후 딱 한 번만 자동으로 실행됩니다.
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

func _input(event):
	#클릭 받았으면
	if event.is_action_pressed("click"):
		print("click")
		# 현재 상태는 현재 상태머신 노드로 설
		var current_state = state_machine.get_current_node()
		
		#현재 상태가 어택이 아니면
		if current_state != "Attack":
			state_machine.travel("Attack")
			#어택 명령 수행해라
			
func _physics_process(delta):
	#지금 상태 어택이면 무시하고
	if state_machine.get_current_node() == "Attack":
		return

	var direction = Input.get_axis("ui_left", "ui_right")
	#방향키 입력 받고
	var current_state = state_machine.get_current_node()
	#현재 노드도 확인해
	# 2. 이동/대기 전환 시: "지금 그 상태가 아닐 때만" 명령을 내립니다!
	if direction != 0: #정지 상태가 아니면,
		if current_state != "Move": #그리고 지금 이동 중이 아니면
			state_machine.travel("Move") #이동해
	else:
		if current_state != "Idle": #정지 중이 아니면
			state_machine.travel("Idle")#정지해
