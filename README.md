# Immediate GUI for Godot Engine
# How to use
- Add `GUI.gd` in your project
- Add `GUI.gd` as autoload
# Example
```gdscript
func _gui(delta):
	GUI.label(str("FPS: ", Engine.get_frames_per_second()));
```
