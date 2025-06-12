extends PanelContainer
class_name DialogueEditor

@onready var EntryDupe = preload("res://Scenes/DialogueEntry.tscn")

var CurrentDialogue = null

var EntryCount = 1


func Add_Entry() -> void:
	var NewEntry = EntryDupe.instantiate()
	%Entries.add_child(NewEntry)


func Duplicate_Entry(EntryToDuplicate) -> void:
	var NewEntry = EntryDupe.instantiate()
	NewEntry.get_node("CharacterName").text = EntryToDuplicate.get_node("CharacterName").text
	NewEntry.get_node("Dialogue").text = EntryToDuplicate.get_node("Dialogue").text
	%Entries.add_child(NewEntry)
