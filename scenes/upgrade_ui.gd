class_name UpgradeUI extends Control

var _manager: UpgradeManager
var player: Player

func attach(upgrade_manager: UpgradeManager):
	_manager = upgrade_manager
	
	$Upgrade.text = _manager.get_current().description
	
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	player.controller_enabled = false
	visible = true

func detach():
	_manager = null
	
	$Upgrade.text = ""
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	player.controller_enabled = true
	visible = false

func _on_close_button_down() -> void:
	detach()
