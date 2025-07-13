extends Control

@onready var ctrlL: TextureRect = $CtrlL
@onready var ctrlR: TextureRect = $CtrlR
@onready var ctrlU: TextureRect = $CtrlU

@onready var label: RichTextLabel = $Label

var b_showingTxt := false
var f_txtTimer := 0.0
var txt0 := "[center]THE OWLS ARE NOT WHAT THEY SEEM[/center]"
var txt1 := "[center]WHAT ARE YOU LOOKING FOR WANDERING AROUND A FOREST LIKE THIS?[/center]"

var v2_cLOPos := Vector2()
var v2_cROPos := Vector2()
var v2_cUOPos := Vector2()

#IDLE
var f_cLTimer := 0.0
var f_cRTimer := 0.0
var f_cUTimer := 0.0
var f_cLTime := 0.0
var f_cRTime := 0.0
var f_cUTime := 0.0
var f_cLPauseTime := 0.0
var f_cRPauseTime := 0.0
var f_cUPauseTime := 0.0
var v2_cL0Pos := Vector2()
var v2_cR0Pos := Vector2()
var v2_cU0Pos := Vector2()
var v2_cL1Pos := Vector2()
var v2_cR1Pos := Vector2()
var v2_cU1Pos := Vector2()

func _ready() -> void:
	v2_cLOPos = ctrlL.position
	v2_cROPos = ctrlR.position
	v2_cUOPos = ctrlU.position
	
	v2_cL0Pos = v2_cLOPos
	v2_cR0Pos = v2_cROPos
	v2_cU0Pos = v2_cUOPos
	v2_cL1Pos = Vector2(v2_cLOPos.x + randf_range(-0.3, 0.3), v2_cLOPos.y + randf_range(-0.3, 0.3))
	v2_cR1Pos = Vector2(v2_cROPos.x + randf_range(-0.3, 0.3), v2_cROPos.y + randf_range(-0.3, 0.3))
	v2_cU1Pos = Vector2(v2_cUOPos.x + randf_range(-0.3, 0.3), v2_cUOPos.y + randf_range(-0.3, 0.3))
	DoText(0)

func _process(delta: float) -> void:
	CtrlsIdle(delta)
	ShowText(delta)

func CtrlsIdle(delta : float) -> void:
	
	if f_cLPauseTime <= 0:
		ctrlL.position = Vector2(lerpf(v2_cL0Pos.x, v2_cL1Pos.x, f_cLTimer), lerpf(v2_cL0Pos.y, v2_cL1Pos.y, f_cLTimer))
		f_cLTimer += delta
	else:
		f_cLPauseTime -= delta
	if f_cRPauseTime <= 0:
		ctrlR.position = Vector2(lerpf(v2_cR0Pos.x, v2_cR1Pos.x, f_cRTimer), lerpf(v2_cR0Pos.y, v2_cR1Pos.y, f_cRTimer))
		f_cRTimer += delta
	else:
		f_cRPauseTime -= delta
	if f_cUPauseTime <= 0:
		ctrlU.position = Vector2(lerpf(v2_cU0Pos.x, v2_cU1Pos.x, f_cUTimer), lerpf(v2_cU0Pos.y, v2_cU1Pos.y, f_cUTimer))
		f_cUTimer += delta
	else:
		f_cUPauseTime -= delta
	
	if f_cLTimer >= f_cLTime:
		ResetLctrl()
	if f_cRTimer >= f_cRTime:
		ResetRctrl()
	if f_cUTimer >= f_cUTime:
		ResetUctrl()

#region INPUT

func InputLeft():
	ResetLctrl()
	f_cLPauseTime = 0.5
	ctrlL.position = v2_cLOPos
	v2_cL0Pos = v2_cLOPos

func InputRight():
	ResetRctrl()
	f_cRPauseTime = 0.5
	ctrlR.position = v2_cROPos
	v2_cR0Pos = v2_cROPos

func InputUp():
	ResetUctrl()
	f_cUPauseTime = 0.5
	ctrlU.position = v2_cUOPos
	v2_cU0Pos = v2_cUOPos

#endregion

#region RESET

func ResetLctrl() -> void:
		f_cLTime = randf_range(.7, 1.5)
		f_cLTimer = 0.0
		v2_cL0Pos = ctrlL.position
		v2_cL1Pos = Vector2(v2_cLOPos.x + randi_range(-10, 10), v2_cLOPos.y + randi_range(-10, 10))

func ResetRctrl() -> void:
		f_cRTime = randf_range(.7, 1.5)
		f_cRTimer = 0.0
		v2_cR0Pos = ctrlR.position
		v2_cR1Pos = Vector2(v2_cROPos.x + randi_range(-10, 10), v2_cROPos.y + randi_range(-10, 10))

func ResetUctrl() -> void:
		f_cUTime = randf_range(.7, 1.5)
		f_cUTimer = 0.0
		v2_cU0Pos = ctrlU.position
		v2_cU1Pos = Vector2(v2_cUOPos.x + randi_range(-10, 10), v2_cUOPos.y + randi_range(-10, 10))

#endregion

func DoText(txtIndex:int)->void:
	if txtIndex == 0: label.text = txt0
	else:             label.text = txt1 
	f_txtTimer = 0.0
	label.visible_ratio = 0
	b_showingTxt = true


func ShowText(delta : float) -> void:
	if !b_showingTxt:
		return
	
	f_txtTimer += delta
	
	if f_txtTimer < 4:
		label.visible_ratio = f_txtTimer / 4
	elif f_txtTimer < 6:
		label.visible_ratio = 1
	else:
		print("hide")
		label.visible_ratio = 0
		b_showingTxt = false
