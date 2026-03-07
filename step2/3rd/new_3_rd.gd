extends Node2D

@onready var anim_tree = $AnimationTree
@onready var anim_player = $AnimationTree/AnimationPlayer

var target_input = Vector2.ZERO
var current_input = Vector2.ZERO


const LERP_SPEED = 10.0
func _process(delta):
	target_input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	current_input = current_input.lerp(target_input, delta * LERP_SPEED)
	
	
	anim_tree.set("parameters/Move/blend_position", current_input)
	
	
	if target_input != Vector2.ZERO:
		if anim_player:
			print("현재 재생 애니: ", anim_player.current_animation)
