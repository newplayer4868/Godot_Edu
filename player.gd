extends Node2D


func _ready():
	print("시스템 준비 완료!")
	

	$Sprite2D/Label.text = "Hello, GDScript!"


func _process(delta):
	pass
