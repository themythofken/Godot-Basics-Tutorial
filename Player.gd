class_name Player
extends Node2D

# Movement
var move_speed: int = 100

# Health
var health: int
var maximum_health: int = 100

# Attack
var attack_damage: int = 10

# Equipment
var potions = 3
var potion_heal_amount: int = 50

# Enemies
var enemy: Enemy

func _ready() -> void:
	health = maximum_health
	enemy = get_tree().get_first_node_in_group("enemies")

func _process(delta: float) -> void:
	if is_instance_valid(enemy):
		attack(enemy)

func attack(target: Enemy) -> void:
	target.take_damage(attack_damage)

func take_damage(amount: int) -> void:
	health -= amount

	if health <= 0:
		die()
		return
	
	if health <= potion_heal_amount and potions > 0:
		heal(potion_heal_amount)
		potions -= 1

func heal(amount) -> void:
	print("healed")
	health = min(health + amount, maximum_health)

func die() -> void:
	print("Game Over!")
	queue_free()
