extends Node2D

#이건 단순 한번 실행
func _ready():
	print("시스템 준비 완료!")
	
	# 다른 언어랑 똑같이 $이걸로 개체 선택하는 거임
	# $개체.개체속성
	# 이경우는 스프라이트 2d의 자식 label의 속성 text를 수정한것
	$Sprite2D/Label.text = "Hello, GDScript!"

#여기는 반복 실행
func _process(delta):
	pass
