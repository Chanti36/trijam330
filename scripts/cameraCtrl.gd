extends Camera3D

@onready var ui: Control = $"../UI"


@onready var n: Node3D = $"../World/N"
@onready var n2: Node3D = $"../World/N2"
@onready var n3: Node3D = $"../World/N3"

@onready var s: Node3D = $"../World/S"
@onready var s2: Node3D = $"../World/S2"
@onready var s3: Node3D = $"../World/S3"

@onready var e: Node3D = $"../World/E"
@onready var e2: Node3D = $"../World/E2"
@onready var e3: Node3D = $"../World/E3"

@onready var w: Node3D = $"../World/W"
@onready var w2: Node3D = $"../World/W2"
@onready var w3: Node3D = $"../World/W3"

var f_advanceTimer := 0.0

var b_rotating  := false
var b_advancing := false
var b_canmove   := true
var f_rotateTimer := 0.0
var i_rotateDir   := 0
var f_startAngle  := 0.0

var i_pos    := 0
var i_lv     := 0
var i_rotate := 0

func _process(delta: float) -> void:
	InputCtrl()
	Rotate(delta)
	Advance(delta)

func InputCtrl() -> void:
	if !b_canmove || b_rotating || b_advancing:
		return
	
	if Input.is_action_just_released("ui_left"):
		DoRotation(1)
	if Input.is_action_just_released("ui_right"):
		DoRotation(-1)
	if Input.is_action_just_released("ui_up"):
		DoAdvance()

func DoRotation(val: int) -> void:
	f_rotateTimer = 0.0
	f_startAngle = rotation_degrees.y
	b_rotating = true
	i_rotateDir = val
	
	if val == 1:
		print("rotate left")
		ui.InputLeft()
		if i_pos < 1: i_pos = 3
		else:         i_pos -=1
		if i_lv == 2:
			i_rotate -=1
			if i_rotate <= -4:
				print("END")
				b_canmove = false
	
	elif val == -1:
		print("rotate right")
		ui.InputRight()
		if i_pos > 2: i_pos = 0
		else:         i_pos += 1
		if i_lv == 2:
			i_rotate += 1
			if i_rotate >= 4:
				print("END")
				b_canmove = false

func Rotate(delta : float) -> void:
	if !b_rotating:
		return
	f_rotateTimer += delta
	rotation_degrees = Vector3(0, lerp(f_startAngle, f_startAngle + (i_rotateDir * 90), f_rotateTimer), 0)
	if f_rotateTimer >= 1:
		rotation_degrees = Vector3(0, f_startAngle + (i_rotateDir * 90), 0)
		b_rotating = false

func DoAdvance() -> void:
	print("go on ", i_pos)
	ui.InputUp()
	b_advancing = true
	
	if i_lv == 0:
		if i_pos == 3:
			print("1")
			i_lv += 2
			$"../UI".DoText(1)
		else:
			print("0")
			i_lv = 0
	
	elif i_lv == 1:
		if i_pos == 3:
			print("2")
			i_lv += 1
		else:
			print("0")
			i_lv = 0
	
	elif i_lv == 2:
		print(0)
		i_lv = 0
		$"../UI".DoText(0)

func Advance(delta : float) -> void:
	if !b_advancing:
		return
	f_advanceTimer += delta
	if f_advanceTimer < 5:
		if i_pos == 0: #norte 0 0 -2
			n.position = Vector3(0, 0, lerpf(-2, 0, f_advanceTimer / 5))
			n2.position = Vector3(0, 0, lerpf(-4, -2, f_advanceTimer / 5))
			n3.position = Vector3(0, 0, lerpf(-6, -4, f_advanceTimer / 5))
		print(n.position)
		
	else:
		b_advancing = false
		f_advanceTimer = 0.0

#lo mismo con todas las direcciones, reset en el else, hacer el final y meter sfx :')
