extends Area2D

@onready var warning_box = $WarningBox
@onready var fill_box = $FillBox
@onready var beam_box = $BeamBox
@onready var collision = $CollisionShape2D
func _ready():
	# 1. 초기 세팅
	fill_box.hide()
	beam_box.hide()
	collision.disabled = true
	setup_box(warning_box)
	setup_box(fill_box)
	setup_box(beam_box)
	
	# 2. 필 박스 준비 (세로 0에서 시작)
	fill_box.scale.y = 0
	fill_box.show()

	# 3. [연출 시작] 1.0초 동안 게이지 차오름
	var t = create_tween()
	t.tween_property(fill_box, "scale:y", 1.0, 1.0)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	# 4. [정적] 게이지가 다 차면 Warning/Fill을 모두 숨기고 0.1초 대기
	t.step_finished.connect(func(_idx): 
		warning_box.hide()
		fill_box.hide()
	)
	
	t.tween_interval(0.1) # 0.1초 동안 아무것도 안 보임 (정적)
	t.finished.connect(fire_laser)
func fire_laser():
	# 1. 빔 박스 보여주기
	beam_box.show()
	
	# 2. 충돌체 설정 강제 동기화 (가장 중요한 부분!)
	# 빔 박스가 -2500 위치에 있으므로 충돌체도 똑같이 맞춰야 합니다.
	if collision.shape:
		# RectangleShape2D의 경우 size를 직접 조정
		collision.shape.size = Vector2(5000, 40)
		collision.position = Vector2(0, 0) # Laser(Area2D)의 중앙 기준
	
	# 3. 충돌체 활성화
	collision.disabled = false
	
	# 4. [즉시 감지 로직] 활성화되자마자 이미 안에 들어와 있는 플레이어 체크
	# 물리 프레임이 한 번 돌아야 감지가 되므로 0.01초 정도 기다리거나 강제 체크합니다.
	await get_tree().create_timer(0.01).timeout

	
	# 5. 발사 연출 (두꺼워졌다가 가늘어지기)
	beam_box.scale.y = 1.5
	var t = create_tween()
	t.tween_property(beam_box, "scale:y", 1.0, 0.05)
	
	# 0.4초 유지 후 삭제
	t.tween_interval(0.4)
	t.finished.connect(queue_free)

func setup_box(box):
	# 박스들을 중앙 정렬하는 공통 함수
	box.size = Vector2(5000, 40)
	box.pivot_offset = Vector2(2500, 20)
	box.position = Vector2(-2500, -20)


func _on_body_entered(body):
	# 1. 부딪힌 대상이 'Player'인지 확인
	if body.name == "Player":
		# 2. 메인 씬의 점수 깎기 (부모 노드가 Main이라고 가정)
		print("hi")
		var main_node = get_tree().current_scene
		if main_node and "score" in main_node:
			main_node.score -= 500 # 레이저 한 번 맞으면 500점 감점!
			
		# 3. 타격감 연출: 화면 흔들림이나 플레이어 색상 변경
		# 플레이어에게 'hit' 함수가 있다면 호출 (나중에 만들 예정)
		if body.has_method("take_damage"):
			body.take_damage()
		
		# 4. 레이저는 관통하게 둘지, 사라지게 할지 결정
		# queue_free() # 가스터 블래스터처럼 관통하려면 이 줄은 주석 처리!
