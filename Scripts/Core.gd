extends PanelContainer

@onready var Items = %Browser.get_node("%Items")
@onready var SearchBox = %Browser.get_node("%SearchBox")


var ActionMapping = {
	KEY_ESCAPE: func(): get_tree().quit(),
}


func _ready() -> void:
	Globals.Core = self
	%Browser.visible = true
	Globals.CurrentlyVisible = %Browser

	%Editor.visible = false
	%DialogueEditor.visible = false
	%Tools.visible = false

	%ShowEditor.pressed.connect(Globals.Show.bind("%Editor"))
	%ShowBrowser.pressed.connect(Globals.Show.bind("%Browser"))
	%ShowDialogueEditor.pressed.connect(Globals.Show.bind("%DialogueEditor"))
	%ShowTools.pressed.connect(Globals.Show.bind("%Tools"))


func _unhandled_input(Event:InputEvent):
	if Event is InputEventKey:
		if Event.pressed and ActionMapping.has(Event.keycode):
			if Input.is_key_pressed(KEY_CTRL):
				ActionMapping[Event.keycode].call()
			else:
				ActionMapping[Event.keycode].call()


func Create_Dummy_Note() -> void:
	Globals.DummyNoteFile = FileAccess.open(Globals.DummyNoteFilePath, FileAccess.WRITE_READ)
	Globals.DummyNoteFile.store_string('I am a dummy note')
	Globals.DummyNoteFile.close()
