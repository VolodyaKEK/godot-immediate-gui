# Immediate GUI for Godot Engine
# How to use
- Add `GUI.gd` in your project
- Add `GUI.gd` as autoload
# Example
```gdscript
var show = false;
func _gui(delta):
	#Label
	GUI.label(str("FPS: ", Engine.get_frames_per_second()));
	
	#Button
	if GUI.button("button"):
		print("Button clicked");
	
	if GUI.buttonpress("buttonpress"):
		print("Button continuously pressed");
	
	#Toggle
	show = GUI.toggle("toggle", show);
	if show:
		GUI.label("Toggle on");
```
