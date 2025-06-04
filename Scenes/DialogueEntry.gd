extends HBoxContainer


func _ready():
	Customize_Popup($CharacterName)
	Customize_Popup($Dialogue)


func Customize_Popup(SomeNode):
	var EntryMenu = SomeNode.get_menu()
	EntryMenu.item_count = EntryMenu.get_item_index(SomeNode.MENU_REDO) + 1
	# Add custom items.
	EntryMenu.add_separator()
	EntryMenu.add_item("Duplicate Entry", $CharacterName.MENU_MAX + 1, 0)
	EntryMenu.add_item("Remove Entry", $Dialogue.MENU_MAX + 2, 1)
	# Connect callback.
	EntryMenu.id_pressed.connect(_on_item_pressed)


func _on_item_pressed(ID):
	if ID == 32: get_tree().root.get_node("Core/%DialogueEditor").Duplicate_Entry(self)
	if ID == 33: queue_free()
