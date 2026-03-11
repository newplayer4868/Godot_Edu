extends Area2D

func _ready() -> void:
	# 코인이 위아래로 둥둥 떠다니는 Tween 연출
	var tween = create_tween().set_loops()
	tween.tween_property(self, "position:y", position.y - 20, 0.6).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "position:y", position.y, 0.6).set_trans(Tween.TRANS_SINE)

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D: # 플레이어가 닿았다면
		queue_free() # 삭제
