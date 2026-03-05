extends Sprite2D


@onready var animation_player = $AnimationPlayer
# 애니메이션 플레이어 변수를 선언하고 이건 노드 중에 애니메이션 플레이어를 지칭하는것
##@onready
#Node가 준비되면 다음 속성을 할당된 것으로 표시합니다. 
#이러한 속성에 대한 값은 노드가 초기화될 때(Object._init()) 즉시 할당되지 않고, 
#대신 Node._ready() 직전에 계산되어 저장됩니다.
#@onready var character_name = $Label

func _ready():    
	#노드가 가진 fade in을 플레이하
	animation_player.play("fade_in") #애라니메이션 페이드 인이라고 생성했음 
	#하단 노드 애니메이션 플레이어 하면 하단에 무슨 영상 편집 툴같은 ui 뜨고 거기서 애니메이션 생성, 
	#sprite 2d 속성 중 visibility에서 modulate 옆의 열솨 모양 골라서 생성함 1초 부분 사각형
	#그리고 midulate 클릭 후 하단 속성 중 A(투명도)가 있어서 그거 0으로 해서 투명하게 설정함 그걸 또 key 눌러서 생성했음
	#그레ㅐ서 애니 바에 투명~진한 박스 2개 생성 배치하니까 0~>1로 변하게 애니메이션이 설정됨
	print("애니메이션 시작!")
	#
	 #void play(name: StringName = &"", custom_blend: float = -1, custom_speed: float = 1.0, from_end: bool = false)
#	#.play 함수에 대한 설명 name,
#	커스텀 블랜드:float형으로 -1을 기본으로 받는건가?,
#	커스텀 스피드 기본형은 1.0, 
#	from_end 참트루에서 폴스로 되어 있음

#Plays the animation with key name. Custom blend times and speed can be set.
#애니메이션을 플레이하는데 keyname으로 커스텀 블랜드 타임과 스피드는 설정 가능함
#위에 보니까 기본형이 설정되어 있고

#The from_end option only affects when switching to a new animation track, 
## 정체 불명의 from_end는 새 애니메이션 트렉으로 갈때 효과가 있다는거 같은데
#or if the same track but at the start or end. 
##아니면 같은 트랙, 이 경우에는 시작이나 끝에서만, 그럼 아닐떄는 상관 없는건가
#It does not affect resuming playback that was paused in the middle of an animation. 
## 애니메이션 중간에서 효과름 없다는건가
#If custom_speed is negative and from_end is true, 
#커스텀 스피트가 네더티브고, 프롬엔드가 참인경우
#the animation will play backwards (which is equivalent to calling play_backwards()).
## 애니메이션은 역재생 한다인가
#The AnimationPlayer keeps track of its current or last played animation with assigned_animation. If this method is called with that same animation name, or with no name parameter, the assigned animation will resume playing if it was paused.
#
#Note: The animation will be updated the next time the AnimationPlayer is processed. If other variables are updated at the same time this is called, they may be updated too early. To perform the update immediately, call advance(0).
##모르겠네
##................추정은 뭐 폴스면 1234 1234고 트루면 1234321234 이런거 아닐까요
##모
