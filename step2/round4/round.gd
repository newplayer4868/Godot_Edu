extends Node2D

#대충 파일들 할당되는 객체들이고
#근데 아직도 onreadt 이해 못함
@onready var icon = $Icon      
@onready var label = $Label    
@onready var anim_tree = $AnimationTree 

var active_tween: Tween
#Tween 근데 이건 왜 이렇게 선언하지
#Lightweight object  가벼운 오브젝트라는데
#used for general-purpose animation via script, using Tweeners.
#애니메이션 실행하는 가벼운 객체인듯?

#Tweens are mostly useful for animations 애니 쓰는데 가장 유용하다는데?
#requiring a numerical property to be interpolated over a range of values. 
#누메릭은 무엇인가

#The name tween comes from in-betweening,
# an animation technique where you specify keyframes
# and the computer interpolates the frames that appear between them. 

#Animating something with a Tween is called tweening.
#tween으로 하는 애니메이팅을 트위닝이라고 한다




func _process(_delta):
	var playback = anim_tree.get("parameters/playback")
	if not playback: return
	
	var current_node = playback.get_current_node()
	
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
	#tween_property(
	#object: Object, 
	#property: NodePath, 
	#final_val: Variant, 
	#duration: float)
#아니 트윈 이거 명령어가 개많은데
	
	active_tween.tween_property(
		icon, 
		"position", 
		icon.position + (vec * 100), 
		0.4)\
		.set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	
	# 스쿼시 (옆으로 찌그러짐)
	active_tween.tween_property(icon, "scale", Vector2(1.4, 0.6), 0.05)
	
	active_tween.set_parallel(false)
	# 스트레치 및 복구
	active_tween.chain().tween_property(icon, "scale", Vector2(0.8, 1.2), 0.1)
	active_tween.tween_property(icon, "scale", Vector2(1.0, 1.0), 0.2)\
		.set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
