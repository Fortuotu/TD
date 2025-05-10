class_name UpgradeManager extends Node

var _upgrades: Array[Upgrade]
var _next_upgrade = 0

func init(upgrades: Array[Upgrade]):
	_upgrades = upgrades
	
func get_current():
	if _next_upgrade >= len(_upgrades):
		return null
	
	return _upgrades[_next_upgrade]

func upgrade():
	var current = get_current()
	
	if current:
		current.function.call()
		_next_upgrade += 1
