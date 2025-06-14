extends PanelContainer
class_name Editor


var ActionMapping = {
	KEY_S: func(): Save(),
	KEY_N: func(): New_Note(),
}


func _unhandled_input(Event:InputEvent):
	if Event is InputEventKey:
		if Event.pressed and ActionMapping.has(Event.keycode):
			if Input.is_key_pressed(KEY_CTRL):
				ActionMapping[Event.keycode].call()
			else:
				ActionMapping[Event.keycode].call()


func Save():
	var FileName = "user://%s.dfs" % Globals.CurrentEditorContentName
	var File = FileAccess.open(FileName, FileAccess.WRITE)
	File.store_string(%Editor.get_node("%Text").text)
	File.close()
	Globals.Pop_Save_Toast()


func Load_Note(NoteName):
	Globals.CurrentEditorContentName = NoteName
	%Editor.get_node("%Name").text = NoteName
	%Editor.get_node("%Text").text = Globals.Notes[NoteName]
	Globals.Show("%Editor")


func New_Note():
	Globals.CurrentEditorContentName = "Untitled"
	%Editor.get_node("%Name").text = "Untitled"
	%Editor.get_node("%Text").text = ""
	Globals.Show("%Editor")
