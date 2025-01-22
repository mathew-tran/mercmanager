extends Panel

class_name Shop

@onready var Stock = $Stock

var Money = 10

@export var ShopSlotDataRef : ShopSlotsData

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
	var normalPogs = Helper.GetAllFilePaths("res://Scripts/Data/PlayerPogs/Normal")
	var rarePogs = Helper.GetAllFilePaths("res://Scripts/Data/PlayerPogs/Rare")
	var legendaryPogs = Helper.GetAllFilePaths("res://Scripts/Data/PlayerPogs/Legendary")
	
	await get_tree().process_frame
	for slotInfo in ShopSlotDataRef.Slots:
		var chosenBucket = null
		var result = randi_range(0, 100)
		if result <= slotInfo.NormalChance:
			chosenBucket = normalPogs
		elif result <= slotInfo.NormalChance + slotInfo.RareChance:
			chosenBucket = rarePogs
		else:
			chosenBucket = legendaryPogs
		print(result)
		chosenBucket.shuffle()
		
		var instance = load("res://Prefabs/UI/PurchasePogButton.tscn").instantiate()
		instance.Setup(load(chosenBucket[0]))
		Stock.add_child(instance)
	
	UpdateMoney.emit()
