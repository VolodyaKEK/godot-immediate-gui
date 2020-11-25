extends Node

var show = false;
var text = "text";
var color = Color.white;
var integer := 0;
var float_value := 0.2;
var option = 0;

func _ready():
	#By default all Controls have no size_flags
	#and all Buttons have action_mode set to ACTION_MODE_BUTTON_PRESS.
	#You can clear all default values by calling GUI.clear_default();
	#And you can set your own default values.
	#Call this to make all buttons flat by default
	GUI.add_default(Button, "flat", true);
	#Call this to remove default value "flat" from all Buttons
	GUI.remove_default(Button, "flat");

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
	
	#Options
	option = GUI.options(option, ["option 1", "option 2", "option 3"]);
	
	#Progress bar
	GUI.property.rect_min_size = Vector2(200, 0);
	GUI.progress(float_value);
	
	#Tooltip
	GUI.property.rect_min_size = Vector2(200, 0);
	GUI.property.hint_tooltip = "Tooltip";
	GUI.button("Button with tooltip");
