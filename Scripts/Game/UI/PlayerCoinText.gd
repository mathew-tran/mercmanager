extends HBoxContainer

func _ready():
	Helper.GetShop().UpdateMoney.connect(OnUpdateMoney)

func OnUpdateMoney():
	$Label.text = str(Helper.GetShop().Money)
