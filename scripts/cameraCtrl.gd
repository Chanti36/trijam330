extends Camera3D

@onready var ui: Control = $"../UI"


@onready var n: Node3D = $"../World/N"
@onready var n2: Node3D = $"../World/N2"
@onready var n3: Node3D = $"../World/N3"
@onready var treeN = $"../World/N/Sprite3D"

@onready var s: Node3D = $"../World/S"
@onready var s2: Node3D = $"../World/S2"
@onready var s3: Node3D = $"../World/S3"
@onready var treeS = $"../World/S/Sprite3D"

@onready var e: Node3D = $"../World/E"
@onready var e2: Node3D = $"../World/E2"
@onready var e3: Node3D = $"../World/E3"
@onready var treeE = $"../World/E/Sprite3D"

@onready var w: Node3D = $"../World/W"
@onready var w2: Node3D = $"../World/W2"
@onready var w3: Node3D = $"../World/W3"
@onready var treeW = $"../World/W/Sprite3D"

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

var b_onEnding := false
var f_ending := 0.0
@onready var cam = $"."


func _process(delta: float) -> void:
	InputCtrl()
	Rotate(delta)
	Advance(delta)
	Ending(delta)

func Ending(delta : float) -> void:
	if !b_onEnding:
		return
	f_ending += delta
	if f_ending < 5:
		cam.position = Vector3(randf_range(-0.05, 0.05),randf_range(-0.05, 0.05),randf_range(-0.05, 0.05))
	else:
		cam.far = 0
		$"../UI/CtrlL".visible = false
		$"../UI/CtrlR".visible = false
		$"../UI/CtrlU".visible = false

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
	if val == 1:
		print("rotate left")
		ui.InputLeft()
		if i_pos < 1: i_pos = 3
		else:         i_pos -=1
		if i_lv == 2:
			i_rotate -=1
			if i_rotate <= -4:
				print("END")
				b_onEnding = true
				if i_pos == 0:
					for _i in n.get_children():
						_i.visible = false
					for _i in n2.get_children():
						_i.visible = false
					for _i in n3.get_children():
						_i.visible = false
					treeN.visible = true
				if i_pos == 1:
					for _i in e.get_children():
						_i.visible = false
					for _i in e2.get_children():
						_i.visible = false
					for _i in e3.get_children():
						_i.visible = false
					treeE.visible = true
				if i_pos == 2:
					for _i in s.get_children():
						_i.visible = false
					for _i in s2.get_children():
						_i.visible = false
					for _i in s3.get_children():
						_i.visible = false
					treeS.visible = true
				if i_pos == 3:
					print(treeW.visible)
					for _i in w.get_children():
						_i.visible = false
					for _i in w2.get_children():
						_i.visible = false
					for _i in w3.get_children():
						_i.visible = false
					treeW.visible = true
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
				b_onEnding = true
				if i_pos == 0:
					for _i in n.get_children():
						_i.visible = false
					for _i in n2.get_children():
						_i.visible = false
					for _i in n3.get_children():
						_i.visible = false
					treeN.visible = true
				if i_pos == 1:
					for _i in e.get_children():
						_i.visible = false
					for _i in e2.get_children():
						_i.visible = false
					for _i in e3.get_children():
						_i.visible = false
					treeE.visible = true
				if i_pos == 2:
					for _i in s.get_children():
						_i.visible = false
					for _i in s2.get_children():
						_i.visible = false
					for _i in s3.get_children():
						_i.visible = false
					treeS.visible = true
				if i_pos == 3:
					for _i in w.get_children():
						_i.visible = false
					for _i in w2.get_children():
						_i.visible = false
					for _i in w3.get_children():
						_i.visible = false
					treeW.visible = true
				b_canmove = false
	
	
	f_rotateTimer = 0.0
	f_startAngle = rotation_degrees.y
	b_rotating = true
	i_rotateDir = val

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
			for _i in n.get_children():
				if _i.name == "Sprite3D2":
					_i.visible = false
			for _i in s.get_children():
				if _i.name == "Sprite3D2":
					_i.visible = false
			for _i in e.get_children():
				if _i.name == "Sprite3D2":
					_i.visible = false
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
			for _i in n.get_children():
				if _i.name == "Sprite3D2":
					_i.visible = true
			for _i in s.get_children():
				if _i.name == "Sprite3D2":
					_i.visible = true
			for _i in e.get_children():
				if _i.name == "Sprite3D2":
					_i.visible = true
	
	elif i_lv == 2:
		print(0)
		i_lv = 0
		$"../UI".DoText(0)

func Advance(delta : float) -> void:
	if !b_advancing:
		return
	f_advanceTimer += delta
	if f_advanceTimer < 3:
		if i_pos == 0: #norte 0 0 -2
			n.position = Vector3(0, 0, lerpf(-2, 0, f_advanceTimer / 3))
			n2.position = Vector3(0, 0, lerpf(-4, -2, f_advanceTimer / 3))
			n3.position = Vector3(0, 0, lerpf(-6, -4, f_advanceTimer / 3))
		elif i_pos == 1:
			e.position  = Vector3(lerpf(2, 0, f_advanceTimer / 3), 0, 0)
			e2.position = Vector3(lerpf(4, 2, f_advanceTimer / 3), 0, 0)
			e3.position = Vector3(lerpf(6, 4, f_advanceTimer / 3), 0, 0)
		elif i_pos == 2:
			s.position =  Vector3(0, 0, lerpf(2, 0, f_advanceTimer / 3))
			s2.position = Vector3(0, 0, lerpf(4, 2, f_advanceTimer / 3))
			s3.position = Vector3(0, 0, lerpf(6, 4, f_advanceTimer / 3))
		elif i_pos == 3:
			w.position  = Vector3(lerpf(-2, 0, f_advanceTimer / 3), 0, 0)
			w2.position = Vector3(lerpf(-4, -2, f_advanceTimer / 3), 0, 0)
			w3.position = Vector3(lerpf(-6, -4, f_advanceTimer / 3), 0, 0)
		
		print(n.position)
		
	else:
		if i_pos == 0:
			n.position =  Vector3(0, 0, -2)
			n2.position = Vector3(0, 0, -4)
			n3.position = Vector3(0, 0, -6)
		elif i_pos == 1:
			e.position  = Vector3(2, 0, 0)
			e2.position = Vector3(4, 0, 0)
			e3.position = Vector3(6, 0, 0)
		elif i_pos == 2:
			s.position =  Vector3(0, 0, 2)
			s2.position = Vector3(0, 0, 4)
			s3.position = Vector3(0, 0, 6)
		elif i_pos == 3:
			w.position  = Vector3(-2, 0, 0)
			w2.position = Vector3(-4, 0, 0)
			w3.position = Vector3(-6, 0, 0)
		b_advancing = false
		f_advanceTimer = 0.0
