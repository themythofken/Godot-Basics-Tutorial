class_name Enemy
extends CharacterBody2D

# Movement
var move_speed = -100

# Health
var health: int = 50

# Attack
var attack_damage: int = 10
var time_between_attacks: float = 1.0
var attack_timer: Timer
var attack_distance: int = 130

var player: Player

func _ready():
	$Sprite2D.modulate = Color(1, 0, 0)
	player = get_tree().get_first_node_in_group("player")
	
	attack_timer = Timer.new()
	attack_timer.wait_time = time_between_attacks
	attack_timer.autostart = true
	attack_timer.timeout.connect(_on_attack_timer_timeout)
	add_child(attack_timer)

func _process(delta: float) -> void:
	velocity.x = move_speed
	move_and_slide()

func attack(target: Player) -> void:
	print("Enemy attacked")
	target.take_damage(attack_damage)

func take_damage(amount: int) -> void:
	health -= amount

	if health <= 0:
		die()

func die() -> void:
	print("enemy died")
	queue_free()

func _on_attack_timer_timeout() -> void:
	if is_instance_valid(player):
		if position.distance_to(player.position) < attack_distance:
			attack(player)
