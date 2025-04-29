class_name WaveGenerator extends Node

static var _this_scene: PackedScene = preload("res://scenes/wave_generator.tscn")

static func create(seed: int):
	var inst = _this_scene.instantiate()
	inst._rng.set_seed(seed)
	return inst

var _balloon_scenes: Array[PackedScene] = [
	preload("res://scenes/balloons/red_balloon.tscn"),
	preload("res://scenes/balloons/blue_balloon.tscn"),
	preload("res://scenes/balloons/green_balloon.tscn"),
	preload("res://scenes/balloons/yellow_balloon.tscn"),
	preload("res://scenes/balloons/pink_balloon.tscn"),
	
	#preload("res://scenes/balloons/black_balloon.tscn"),
	#preload("res://scenes/balloons/white_balloon.tscn")
]

var _wave_counter: int = 0

var _rng: RandomNumberGenerator = RandomNumberGenerator.new()

var _sidx: int
var _sidx_fuzz_range: int

class SpawnEntry:
	var balloon: Balloon
	var delay: float
	
	func _init(_balloon: Balloon, _delay: float) -> void:
		balloon = _balloon
		delay = _delay

func _ready():
	_recalculate_sidx()

func _rng_chance(percent: float):
	return _rng.randf_range(0.0, 100.0) <= percent

func _fuzzed_sidx() -> int:
	var fuzz = _rng.randi_range(-_sidx_fuzz_range / 2, _sidx_fuzz_range)
	return clamp(_sidx + fuzz, 0, len(_balloon_scenes) - 1)

func _generate_burst() -> Array[SpawnEntry]:
	var burst: Array[SpawnEntry] = []
	
	var scene = _balloon_scenes[_fuzzed_sidx()]
	var delay = _rng.randf_range(0.15, 0.8)
	var count = _rng.randi_range(3, 15)
	
	for i in range(count - 1):
		burst.append(SpawnEntry.new(scene.instantiate(), delay))
	
	burst.append(SpawnEntry.new(scene.instantiate(), 0.001))
	
	return burst

func _generate_break() -> Array[SpawnEntry]:
	return [SpawnEntry.new(null, _rng.randf_range(0.0, 1.5  / (float(_wave_counter) + 1.0)))]

func _recalculate_sidx():
	_sidx = _wave_counter / 1
	_sidx_fuzz_range = _sidx / 3 + 1

func generate_next() -> Array[SpawnEntry]:
	var wave: Array[SpawnEntry]
	
	var major_count = _rng.randi_range(0, _wave_counter / 4) + 3
	
	for i in range(major_count):
		wave.append_array(_generate_burst())
		wave.append_array(_generate_break())
	
	_wave_counter += 1
	_recalculate_sidx()
	
	return wave
