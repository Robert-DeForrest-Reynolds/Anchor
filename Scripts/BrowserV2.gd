extends PanelContainer
class_name Browser
var BrowserItem = preload("res://Scenes/BrowserItem.tscn")

@onready var Items = %Items


func _ready() -> void:
	%SearchBox.text_changed.connect(Search)
	Initial_Search_Content_Load()


func Clear_Search_Box():
	print("Clearing Search Box")
	Items.queue_free()
	await get_tree().physics_frame
	Items = VBoxContainer.new()
	%VBox.add_child(Items)


func Search(NewText: String) -> void:
	await get_tree().physics_frame
	await Clear_Search_Box()
	var Source = %SearchBox.text
	if Source == "":
		Initial_Search_Content_Load()
	else:
		Globals.LastSearchSize = Source.length()

		for NoteKey in Globals.Notes:
			if Source.to_lower() in NoteKey.to_lower():
				Insert_Search_Item(NoteKey, Globals.Notes[NoteKey])


func Select_Item(ItemName:String, ItemType:int):
	if ItemType == Globals.Types.NOTE:
		%Editor.Load_Note(ItemName)



func Insert_Search_Item(NoteName:String, NoteContent:String):
	var NewBrowserItem = BrowserItem.instantiate()
	var NameNode = NewBrowserItem.get_node("%Name")
	var ContentNode = NewBrowserItem.get_node("%Content")
	NameNode.text = NoteName
	ContentNode.text = NoteContent
	Items.add_child(NewBrowserItem)
	NewBrowserItem.pressed.connect(Select_Item.bind(NoteName, Globals.Types.NOTE))
	print("Added Item")


func Initial_Search_Content_Load() -> void:
	await Clear_Search_Box()
	print("Finished Clearing Box")
	for NoteName in Globals.Notes.keys():
		print("Inserting Note")
		Insert_Search_Item(NoteName, Globals.Notes[NoteName])
