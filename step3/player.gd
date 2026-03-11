extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta: float) -> void:
	# 1. 중력 적용 (기본 제공 함수 사용)
	if not is_on_floor():
		velocity += get_gravity() * delta

	# 2. 점프
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# 3. 좌우 이동
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide() # 이 함수가 있어야 벽과 충돌합니다.
