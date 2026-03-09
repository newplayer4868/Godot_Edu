extends Node2D

# [수정] 노드 이름이 소문자라면 경로도 소문자로 맞춰야 하네!
# 만약 씬 트리에서 이름이 'icon'이라면 $icon으로 적어야 하네.
@onready var icon = $Icon       # 자네의 실제 노드 이름 확인!
@onready var label = $Label     # 아이콘의 자식이 아니라면 바로 $label
@onready var anim_tree = $AnimationTree # 노드 이름 확인 필수

var active_tween: Tween

# [수정] 사용하지 않는 delta 앞에 _를 붙여 경고를 없애게나.
func _process(_delta):
	var playback = anim_tree.get("parameters/playback")
	if not playback: return
	
	var current_node = playback.get_current_node()
	
	# [에러 지점] label이 null이면 여기서 터지네. 위 @onready 경로가 중요하네!
	if label:
		label.text = "State: " + str(current_node)

	var input_vec = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	if input_vec != Vector2.ZERO:
		if current_node != "Move":
			playback.travel("Move")
		_play_move_juice(input_vec)
	else:
		if current_node != "Idle":
			playback.travel("Idle")

func _play_move_juice(vec: Vector2):
	if active_tween:
		active_tween.kill()
	
	active_tween = create_tween()
	active_tween.set_parallel(true)
	
	# 위치 이동
	active_tween.tween_property(icon, "position", icon.position + (vec * 100), 0.4)\
		.set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	
	# 스쿼시 (옆으로 찌그러짐)
	active_tween.tween_property(icon, "scale", Vector2(1.4, 0.6), 0.05)
	
	active_tween.set_parallel(false)
	# 스트레치 및 복구
	active_tween.chain().tween_property(icon, "scale", Vector2(0.8, 1.2), 0.1)
	active_tween.tween_property(icon, "scale", Vector2(1.0, 1.0), 0.2)\
		.set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
