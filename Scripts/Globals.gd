extends Node

@onready var CurrentlyVisible = null

var Core = null


enum Types {
	NOTE,
	TEXTFILE,
	MARKDOWN,
}

var DataFile:FileAccess = null
var DummyNoteFile:FileAccess = null

var DataFilePath:String = "user://{}.dfs"
var DummyNoteFilePath:String = "user://DummyFile.dfs"

var Notes:Dictionary = {}

var LastSearchSize:int = 0
var CurrentEditorContentName:String = ""


func _ready():
	if !FileAccess.file_exists(Globals.DummyNoteFilePath): Core.Create_Dummy_Note()

	for File in DirAccess.get_files_at("user://"):
		if File.ends_with(".dfs"):
			Load_DFS_File(File)


func Load_DFS_File(FileToLoadPath:String) -> void:
	var File = FileAccess.open("user://%s" % FileToLoadPath, FileAccess.READ)
	var Content = File.get_as_text()
	var FileName = FileToLoadPath.split(".dfs")[0]
	Globals.Notes[FileName] = Content
	File.close()


func Pop_Save_Toast():
	Core.get_node("%SavedPanel").visible = true
	await get_tree().create_timer(1).timeout
	Core.get_node("%SavedPanel").visible = false


func Show(NodePathToShow:String):
	CurrentlyVisible.visible = false
	CurrentlyVisible = Core.get_node(NodePathToShow)
	CurrentlyVisible.visible = true
