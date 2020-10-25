extends VBoxContainer

const boxes = [];
const controls = [];
const used = [];
var tooltip := "";
var size := Vector2();

func _init():
	mouse_filter = MOUSE_FILTER_IGNORE;

func _process(delta):
	used.clear();
	boxes.clear();
	raise();
	get_parent().propagate_call("_gui", [delta]);
	for c in controls:
		if !(c in used):
			reparent(c, null);
			controls.remove(controls.find(c));
			c.free();

func _get_control(type, text=null):
	var _c;
	for c in controls:
		if c is type && !(c in used):
			_c = c;
			break;
	if _c == null:
		_c = type.new();
		controls.append(_c);
	_c.size_flags_horizontal = 0;
	if _c is BaseButton:
		_c.action_mode = BaseButton.ACTION_MODE_BUTTON_PRESS;
		_c.mouse_default_cursor_shape = CURSOR_POINTING_HAND;
	used.append(_c);
	reparent(_c, self if boxes.size() == 0 else boxes[-1]);
	if text != null:
		_c.text = str(text);
	
	_c.rect_min_size = size;
	size = Vector2();
	
	_c.hint_tooltip = tooltip;
	tooltip = "";
	
	return _c;
func reparent(node, new_parent):
	var p = node.get_parent();
	if p == new_parent:
		node.raise();
		return;
	if p != null:
		p.remove_child(node);
	if new_parent != null:
		new_parent.add_child(node);

func _toggle(type, text, state):
	var b = _get_control(type, text);
	b.pressed = !state if b.changed.get_changed() else state;
	return b.pressed;

func label(text):
	_get_control(GUILabel, text);
func button(text):
	return _get_control(GUIButton, text).changed.get_changed();
func buttonpress(text):
	var b = _get_control(GUIButton, text);
	b.changed.get_changed();
	return b.pressed;
	
func toggle(text, state:bool):
	return _toggle(GUIToggle, text, state);
func checkbox(text, state:bool):
	return _toggle(GUICheckBox, text, state);
func checkbutton(text, state:bool):
	return _toggle(GUICheckButton, text, state);

func options(selected:int, options:Array):
	var b = _get_control(GUIOptions);
	b.set_options(options);
	if !b.changed.get_changed():
		b.selected = selected;
	return b.selected;

func pickcolor(color:Color, edit_alpha:bool=true):
	var c = _get_control(GUIColorPicker);
	c.rect_min_size.x = c.rect_size.y*2;
	c.edit_alpha = edit_alpha;
	c.get_popup().rect_global_position = c.rect_global_position + Vector2(0, c.rect_size.y);
	if !c.changed.get_changed():
		c.color = color;
	return c.color;
func progress(value:float):
	var c = _get_control(ProgressBar);
	c.min_value = 0;
	c.max_value = 100;
	c.value = value*100;
func spin(value, min_value, max_value):
	var c = _get_control(GUISpin);
	c.min_value = min_value;
	c.max_value = max_value;
	c.step = 1.0 if value is int else 0.001;
	if !c.changed.get_changed():
		c.value = value;
	return c.value;
func line(text:String):
	var l = _get_control(GUILine);
	if !l.changed.get_changed() && l.text != text:
		l.text = text;
	return l.text;

func hbox():
	var box = _get_control(HBoxContainer);
	boxes.append(box);
	return true;
func vbox():
	var box = _get_control(VBoxContainer);
	boxes.append(box);
	return true;
func grid(columns:int):
	var grid = _get_control(GridContainer);
	grid.columns = columns;
	boxes.append(grid);
	return true;
func margin(left:int=0, top:int=0, right:int=0, bottom:int=0):
	var box = _get_control(MarginContainer);
	box.set("custom_constants/margin_left", left);
	box.set("custom_constants/margin_top", top);
	box.set("custom_constants/margin_right", right);
	box.set("custom_constants/margin_bottom", bottom);
	boxes.append(box);
	return true;
func end():
	boxes.pop_back();
func scroll():
	var box = _get_control(ScrollContainer);
	boxes.append(box);
	return true;

class GUILabel extends Label:
	pass
class GUIBaseButton extends Button:
	var changed = GUIStateChanged.new(self, "pressed");
class GUIButton extends GUIBaseButton:
	pass
class GUIToggle extends GUIBaseButton:
	func _init():
		toggle_mode = true;
class GUICheckBox extends CheckBox:
	var changed = GUIStateChanged.new(self, "pressed");
class GUICheckButton extends CheckButton:
	var changed = GUIStateChanged.new(self, "pressed");
class GUIOptions extends OptionButton:
	var changed = GUIStateChanged.new(self, "item_selected");
	var options = [];
	func set_options(_options):
		if options != _options:
			options = _options;
			clear();
			for text in options:
				add_item(str(text));
class GUILine extends LineEdit:
	var changed = GUIStateChanged.new(self, "text_changed");
#class GUICanvas extends ColorRect:
#	func _process(_delta):
#		update();
class GUIColorPicker extends ColorPickerButton:
	var changed = GUIStateChanged.new(self, "color_changed");
class GUISpin extends SpinBox:
	var changed = GUIStateChanged.new(self, "value_changed");

class GUIStateChanged:
	var changed:bool;
	func _init(node, _signal):
		node.connect(_signal, self, "_changed");
	func _changed(_v=null):
		changed = true;
	func get_changed():
		if changed:
			changed = false;
			return true;
		return false;
