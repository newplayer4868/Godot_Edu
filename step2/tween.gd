extends Node2D

@onready var anim_tree = $AnimationTree
@onready var anim_player = $AnimationTree/AnimationPlayer

var target_input = Vector2.ZERO
var current_input = Vector2.ZERO
var active_tween: Tween

const LERP_SPEED = 10.0
func _process(delta):
	#애니트리에서 플레이백 가져오기
	var playback = anim_tree.get("parameters/playback")
	var label=$Label
	print(label.text)
	if playback:
		var current_node = playback.get_current_node()
		if current_node == "Move.Right":
			print("hi")
			pass

	target_input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	current_input = current_input.lerp(target_input, delta * LERP_SPEED)
	
	
	anim_tree.set("parameters/Move/blend_position", current_input)
	
	
	if target_input != Vector2.ZERO:
		if anim_player:
			if active_tween:	#연속 작동(애니 중첩) 방지
				active_tween.kill()
			active_tween = create_tween()
			active_tween.set_parallel(true) 
			active_tween.tween_property($Icon, "position", target_input * 100, 0.4)\
			.set_trans(Tween.TRANS_QUINT)\
			.set_ease(Tween.EASE_OUT)
			
			active_tween.set_parallel(false) # 이제부터는 줄을 서시오!
			active_tween.chain().tween_property($Icon, "scale", Vector2(1.5, 0.5), 0.1)
			active_tween.tween_property($Icon, "scale", Vector2(0.8, 1.2), 0.1)
			active_tween.tween_property($Icon, "scale", Vector2(1.0, 1.0), 0.2)\
			.set_trans(Tween.TRANS_ELASTIC)\
			.set_ease(Tween.EASE_OUT)
