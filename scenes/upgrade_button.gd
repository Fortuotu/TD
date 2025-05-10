extends Button

func display(upgrade: Upgrade):
	if not upgrade:
		visible = false
		reset()
	else:
		visible = true
		text = upgrade.description

func reset():
	text = ""
