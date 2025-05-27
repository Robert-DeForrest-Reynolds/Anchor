extends PanelContainer

@onready var Items = %Browser.get_node("%Items")
@onready var SearchBox = %Browser.get_node("%SearchBox")

@onready var NamesContainerDupe = Items.get_node("Names").duplicate(8)
@onready var ContentContainerDupe = Items.get_node("Contents").duplicate(8)
@onready var NameMarginDupe = Items.get_node("Names/NameMargin").duplicate(8)
@onready var ContentMarginDupe = Items.get_node("Contents/ContentMargin").duplicate(8)


func _ready() -> void:
	SearchBox.text_changed.connect(Search)
	Initial_Search_Content_Load()


func Clear_Search_Box():
	Items.get_node("Names").queue_free()
	Items.get_node("Contents").queue_free()
	await get_tree().physics_frame
	var NewNamesContainer = NamesContainerDupe.duplicate(8)
	var NewContentsContainer = ContentContainerDupe.duplicate(8)
	Items.add_child(NewNamesContainer)
	NewNamesContainer.name = "Names"
	Items.add_child(NewContentsContainer)
	NewContentsContainer.name = "Contents"


func Search(NewText: String) -> void:
	await get_tree().physics_frame
	await Clear_Search_Box()
	var Content = SearchBox.text
	if Content == "":
		Initial_Search_Content_Load()
	else:
		Globals.LastSearchSize = Content.length()

		for NoteKey in Globals.Notes:
			if Content in NoteKey:
				Insert_Search_Item(NoteKey, Globals.Notes[NoteKey])


func Select_Item(Event:InputEvent, ItemName:String, ItemType:int):
	if Event is InputEventMouseButton and Event.pressed:
		if ItemType == Globals.Types.NOTE:
			%Editor.Load_Note(ItemName)



func Insert_Search_Item(NoteName:String, NoteContent:String):
	var NewNameMargin = NameMarginDupe.duplicate()
	NewNameMargin.get_node("NameLabel").text = NoteName
	NewNameMargin.get_node("NameLabel").gui_input.connect(Select_Item.bind(NoteName, Globals.Types.NOTE))
	NewNameMargin.visible = true
	Items.get_node("Names").add_child(NewNameMargin)

	var NewContentMargin = ContentMarginDupe.duplicate()
	NewContentMargin.get_node("ContentLabel").text = Globals.Notes[NoteName]
	NewContentMargin.visible = true
	Items.get_node("Contents").add_child(NewContentMargin)


func Initial_Search_Content_Load() -> void:
	for NoteName in Globals.Notes.keys():
		Insert_Search_Item(NoteName, Globals.Notes[NoteName])
