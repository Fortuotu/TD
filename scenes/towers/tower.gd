class_name Tower extends Node3D

var upgrade_manager = UpgradeManager.new()

static var _upgrades: Array[Upgrade] = [
	Upgrade.create(_upgrade_1, "upgrade 1"),
	Upgrade.create(_upgrade_2, "upgrade 2")
]

static func _upgrade_1():
	print("Upgrade 1")

static func _upgrade_2():
	print("Upgrade 2")

func _ready() -> void:
	upgrade_manager.init(_upgrades)
	
	$FireTimer.wait_time = 0.3
	$FireTimer.one_shot = false
	$FireTimer.start()
	$FireTimer.timeout.connect(_fire_dart)

func _fire_dart() -> void:
	var target = $TowerRange.get_first()
	
	if target:
		var dart = Dart.create(global_position, target.global_position)
		add_child(dart)
