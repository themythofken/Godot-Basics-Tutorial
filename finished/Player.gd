class_name Player
extends CharacterBody2D

# Movement
var move_speed: int = 100

# Health
var health: int
var maximum_health: int = 100

# Attack
var attack_damage: int = 10
var time_between_attacks: float = 1.0
var attack_timer: Timer
var attack_distance: int = 130

# Equipment
var potions = 3
var potion_heal_amount: int = 50

# Enemies
var enemy: Enemy

func _ready() -> void:
	health = maximum_health
	enemy = get_tree().get_first_node_in_group("enemies")
	attack_timer = Timer.new()
	attack_timer.wait_time = time_between_attacks
	attack_timer.autostart = true
	attack_timer.timeout.connect(_on_attack_timer_timeout)
	add_child(attack_timer)

func _process(delta: float) -> void:
	velocity.x = move_speed
	move_and_slide()

func attack(target: Enemy) -> void:
	print("Player Attacked")
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

func _on_attack_timer_timeout() -> void:
	if is_instance_valid(enemy):
		if position.distance_to(enemy.position) < attack_distance:
			attack(enemy)
