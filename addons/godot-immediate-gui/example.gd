extends Node

var show = false;
var text = "text";
var color = Color.white;
var integer := 0;
var float_value := 0.2;

func _ready():
	GUI.default[Control] = {
		"size_flags_horizontal":0,
		"size_flags_vertical":0,
	};

func _gui(delta):
	#Label
	GUI.label(str("FPS: ", Engine.get_frames_per_second()));
	
	#Button
	if GUI.button("button"):
		print("Button clicked");
	
	if GUI.buttonpress("buttonpress"):
		GUI.label("Button continuously pressed");
	
	#Toggle
	show = GUI.toggle("toggle", show);
	if show:
		GUI.label("Toggle on");
	
	#Boxes - VBoxContainer, HBoxContainer, GridContainer...
	GUI.hbox();
	for i in 3:
		if GUI.button(str("button ", i)):
			print("Button ", i, " pressed");
	GUI.end();
	
	#LineEdit
	text = GUI.line(text);
	
	#Color
	color = GUI.pickcolor(color);
	
	#SpinBox
	integer = GUI.spin(integer, 0, 20);
	float_value = GUI.spin(float_value, 0.0, 1.0);
	
	#Progress bar
	GUI.property.rect_min_size = Vector2(200, 0);
	GUI.progress(float_value);
	
	#Utility
	GUI.property.rect_min_size = Vector2(200, 0);
	GUI.property.hint_tooltip = "Tooltip";
	GUI.button("Button with tooltip");
