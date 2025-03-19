class_name Enemy
extends Node2D

# Health
var health: int = 50

# Attack
var attack_damage: int = 10

var player: Player

func _ready():
	player = get_tree().get_first_node_in_group("player")

func _process(delta: float) -> void:
	if is_instance_valid(player):
		attack(player)

func attack(target: Player) -> void:
	target.take_damage(attack_damage)

func take_damage(amount: int) -> void:
	health -= amount

	if health <= 0:
		die()

func die() -> void:
	print("enemy died")
	queue_free()
