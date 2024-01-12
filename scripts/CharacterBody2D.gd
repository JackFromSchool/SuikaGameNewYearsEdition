extends CharacterBody2D


const SPEED = 300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var fruitReady = true
@export var FruitScene: PackedScene

func _physics_process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if(Input.get_axis("ui_up", "ui_down") && fruitReady):
		spawnFruit()
		fruitReady = false
		await get_tree().create_timer(1.0).timeout
		fruitReady = true
	
	move_and_slide()

func prepareFruit():
	fruitReady = true

func spawnFruit():
	var newFruit = (FruitScene.instantiate())
	get_parent().add_child(newFruit)
	newFruit.position = position
	
	var new_velocity = Vector2(50, 0)
	
	newFruit.linear_velocity = new_velocity.rotated(randf_range(4.71 - .2, 4.71 + .2))
	
	newFruit.level = 1
