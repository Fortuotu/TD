class_name Tower extends Node3D

var upgrade_manager = UpgradeManager.new()

var _upgrades: Array[Upgrade] = [
	Upgrade.create(_upgrade_1, "this upgrade makes the monkey red"),
	Upgrade.create(_upgrade_2, "this upgrade doesn't do anything")
]

@onready var weapon: Weapon = preload("res://scenes/weapons/single_shot.tscn").instantiate()

func _upgrade_1():
	$Shoot.remove_child(weapon)
	weapon = preload("res://scenes/weapons/triple_shot.tscn").instantiate()
	$Shoot.add_child(weapon)
	
	$Headband.visible = true
	$FireTimer.wait_time = 0.5

func _upgrade_2():
	print("Upgrade 2")

func _ready() -> void:
	upgrade_manager.init(_upgrades)
	
	$Shoot.add_child(weapon)
	
	$FireTimer.wait_time = 0.8
	$FireTimer.one_shot = false
	$FireTimer.start()
	$FireTimer.timeout.connect(_fire_dart)

func _fire_dart() -> void:
	var target = $TowerRange.get_last()
	
	if target:
		weapon.shoot(target.global_position)
