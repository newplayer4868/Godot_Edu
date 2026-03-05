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
		###중력 수정은 전역 변경: Project Settings > Physics > 2D에서 기본 중력을 수정할 수 있다네요
		###국소적 변경: Area2D 노드를 활용합니다. Area2D를 배치하고 그 영역의 Gravity 설정을 바꾸면, 캐릭터가 그 영역에 들어오는 순간 지정된 중력 값, 게임에서 물속에 들어가면 천천히 떨어지는 구간을 만들 때 
 

	# 눌렸을 떄 작동한다. 스페이스바가 눌렸고, 만약 바닥 위에 있다면,
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY #점프하라 
		#velocity 이게 약간 해당 방향으로 힘을 부여해서 사출 시키는 느낌인듯?
		#포물선 그려짐
		

### get axios는 오른쪽 값을  왼쪽 값에서 뺴는것,
###여기서는 왼쪽 버튼 누른다(true)=1 오른쪽 버튼 누른다 =true(1) 뭐 이상한데 어쩃든
###왼쪽 버튼 누르면  왼쪽(1)-오른쪽(0) =1
###오른쪽 버튼 누르면 왼쪽 (0)-오른쪽(1) =-1 이렇게 해서 음양이 나온
	var direction = Input.get_axis("ui_left", "ui_right") #방향은 방향키로 받는다 미리 받을 키 지정한건가 디렉션은 저 키로만 값이 바뀐다?
	if direction: ## 0 이외의 값은 True임 그럼 0일때(아무것도 안누를떄)는 아래로 가
		velocity.x = direction * SPEED 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED) #마찰력 표현 현재 속도에서 0으로 300만큼의 힘으로 브레이크 걸라는거임

	move_and_slide() #이건 결국 충돌 감지 인듯
##	● float get_axis(negative_action: StringName, positive_action: StringName) const
#Get axis input by specifying two actions, one negative and one positive.
#This is a shorthand for writing Input.get_action_strength("positive_action") - Input.get_action_strength("negative_action").

#get axis는 앞의 값은 부정 뒤의 값은 긍정으로 처리해주는 듯 
#디렉션은 레프트는 부정 인풋 
#라이트는 긍정 인풋하는거임
#그럼 라이트일 떄는 true*speed true는 보통 1이야 그러니까 스피드 만큼 좌표 이동=오른쪽 300힘 
#그럼 else는 레프트 부정일 떄야 

#float move_toward(from: float, to: float, delta: float)
#from 값을 to까지 delta 만큼 움직입니다. to를 넘어가진 않습니다.
#delta 값을 음수로 설정하면 멀어집니다.

#move_toward(5, 10, 4)    # 9를 반환합니다 5에서 4칸 가라
#move_toward(10, 5, 4)    # 6을 반환합니다  10에서 5방향으로 4칸 가라
#move_toward(5, 10, 9)    # 10을 반환합니다 5에서 10 방향으로 9칸 가라 근데 10반환했네 최대 값은 못넘어가는듯?
#move_toward(10, 5, -1.5) # 11.5를 반환합니다 근데 여긴 왜 넘어가냐? 왼쪽으로 뚫는건 가능한건가? 

#move_toward(1, 5, -1.5) # 11.5를 반환합니다 근데 여긴 왜 넘어가냐? 왼쪽으로 뚫는건 가능한건가?  이건 그럼 -0.5뜸?
