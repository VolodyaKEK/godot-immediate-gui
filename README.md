# Immediate GUI for Godot Engine
# How to use
- Add `GUI.gd` in your project
- Add `GUI.gd` as autoload
# Example
![Alt text](/screenshot.png?raw=true "Godot Immediate GUI")
```gdscript
var show = false;
var text = "text";
var color = Color.white;
var integer := 0;
var float_value := 0.2;

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
	GUI.size.x = 200;
	GUI.progress(float_value);
	
	#Utility
	GUI.size.x = 100;
	GUI.tooltip = "Tooltip";
	GUI.button("Button with tooltip");
```
