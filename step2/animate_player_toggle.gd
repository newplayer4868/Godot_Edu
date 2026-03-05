extends Sprite2D

@onready var animation_player_toggle = $AnimationPlayerToggle
# 상태 기억 변수
var is_character_shown = true 
func _ready():
	print("hi")


func _input(event):
	if event.is_action_pressed("click"):#프로젝트 설정- 입력 맵에서 추가/편집 가능함.click 만들고 우클릭 할당을 만듦 
		toggle_visibility() 

func toggle_visibility():
	if is_character_shown: #위에서 설정한 변수임
		animation_player_toggle.play_backwards("fade_in") #fadein 애니메이션을 역재생 1>0으로 
	else:
		animation_player_toggle.play("fade_in") #안보이는 상태면 보이도록 
		
	# 상태 반전 (Boolean NOT 연산)
	is_character_shown = !is_character_shown
