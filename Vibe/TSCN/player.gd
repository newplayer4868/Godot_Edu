extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D

@export var normal_speed = 400.0  # 기본 속도
@export var slow_speed = 150.0    # Shift 눌렀을 때 속도 (정밀 회피)
@export var acceleration = 2000.0 # 가속도 (즉각적인 반응을 위해 높게 설정)

func _physics_process(delta):
	# 1. 입력 방향 감지 (상하좌우 조합 가능)
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# 2. 속도 결정 (Shift 누르면 저속 이동)
	var current_speed = slow_speed if Input.is_action_pressed("ui_shift") else normal_speed
	if Input.is_action_pressed("ui_shift") :print("hi")
	# 3. 이동 로직 (가속도 적용으로 부드럽게)
	if input_dir != Vector2.ZERO:
		velocity = velocity.move_toward(input_dir * current_speed, acceleration * delta)
		update_animation(input_dir)
	else:
		# 입력 없을 때 감속
		velocity = velocity.move_toward(Vector2.ZERO, acceleration * delta)
		sprite.play("Idle")

	move_and_slide()

func update_animation(dir):
	# 애니메이션 반전 처리 (Left 하나로 좌우 해결)
	if dir.x > 0:
		sprite.play("Left")
		sprite.flip_h = true
	elif dir.x < 0:
		sprite.play("Left")
		sprite.flip_h = false
	elif dir.y > 0:
		sprite.play("Down")
	elif dir.y < 0:
		sprite.play("Up")
		
func take_damage():
	# 빨간색으로 깜빡이는 연출 (Tween 활용)
	var t = create_tween()
	modulate = Color.RED # 몸체를 빨갛게
	t.tween_property(self, "modulate", Color.WHITE, 0.2) # 0.2초 만에 원래대로
	
	# 여기서 아까 만든 'Hit' 애니메이션을 재생해도 좋습니다.
	if has_node("AnimationPlayer"):
		$AnimationPlayer.play("Hit")
