extends Node2D
# 초당 이동 픽셀 수
# 전역 변수? 같은 느낌으로 선언하고 끌어다 쓰는듯
var speed = 300 


func _ready():
	$Sprite2D/Label.text = "시작함을 알리는 텍스트"

func _process(delta):
	# 키가 눌려있다면 좌표 증감
	#delta를 곱하면 기기 성능 따라 퍼포먼스 차이가 안일어난다고 함
	
	if Input.is_action_pressed("ui_right"):position.x += speed * delta
	if Input.is_action_pressed("ui_left"):position.x -= speed * delta
	if Input.is_action_pressed("ui_down"):position.y += speed * delta
	if Input.is_action_pressed("ui_up"):position.y -= speed * delta
