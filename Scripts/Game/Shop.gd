extends Panel

class_name Shop

@onready var Stock = $Stock

var Money = 8
var StoreStock = 5

signal UpdateMoney

func _ready():
	PopulateStock()
	
func CanAfford(amount):
	return Money >= amount
	
func ReduceMoney(amount):
	Money -= amount
	UpdateMoney.emit()

func AddMoney(amount):
	Money += amount
	UpdateMoney.emit()

func PopulateStock():
	for stock in Stock.get_children():
		stock.queue_free()
	
	var Items = []
	var pogs = Helper.GetAllFilePaths("res://Scripts/Data/PlayerPogs/")
	
	await get_tree().process_frame
	for index in range(0, StoreStock):
		pogs.shuffle()
		
		var instance = load("res://Prefabs/UI/PurchasePogButton.tscn").instantiate()
		instance.Setup(load(pogs[0]))
		Stock.add_child(instance)
	
	UpdateMoney.emit()
