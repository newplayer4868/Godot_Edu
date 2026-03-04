extends CharacterBody2D


const SPEED = 300.0 #속도
const JUMP_VELOCITY = -400.0 #이건 점프 할떄 힘줄 방향 위로 -400가속


func _physics_process(delta):
	#중력 추가
	if not is_on_floor(): #만약 플로어 위에 있지 않는다며느
		velocity += get_gravity() * delta # 중력 가속도로 떨어져라 
		#get 그래비티가 뭔데
		#Vector2 get_gravity() const
		#Returns the gravity vector computed from all sources  
		#that can affect the body, including all gravity 
		#overrides from Area2D nodes and the global world gravity.
		#대충 2d 영역의 전세계에 적용될 중력 값을 get해오는 거 같은데 set_gravity 있나? 없는거 가틍ㄴ데
		
		
 

	# 눌렸을 떄 작동한다. 스페이스바가 눌렸고, 만약 바닥 위에 있다면,
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY #점프하라 
		#velocity 이게 약간 해당 방향으로 힘을 부여해서 사출 시키는 느낌인듯?
		#포물선 그려짐
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right") #방향은 방향키로 받는다 미리 받을 키 지정한건가 디렉션은 저 키로만 값이 바뀐다?
	if direction: 
		velocity.x = direction * SPEED 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
