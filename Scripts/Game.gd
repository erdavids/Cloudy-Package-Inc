extends Node2D

var good_count = 0
var bad_count = 0

var multiplier = 0
var divisor = 0

var score = 0

var battery = 100.0

var game_started = false

var game_over = false

func _ready():
	$ScoreTimer.set_wait_time(.5)
	$ScoreTimer.start()
	
	$Music.playing = true
	
func comma_sep(number):
	
	var neg = number < 0
	var string = str(abs(number))
	var mod = string.length() % 3
	var res = ""

	for i in range(0, string.length()):
		if i != 0 && i % 3 == mod:
			res += ","
		res += string[i]

	if (neg):
		return "-" + res
	else:
		return res

func _process(delta):
	
	if (game_started == false):
		if (Input.is_action_just_pressed("Switch")):
			if (get_node("Intro-0").visible == true):
				get_node("Intro-0").visible = false
				get_node("Intro-1").visible = true
			elif (get_node("Intro-1").visible == true):
				get_node("Intro-1").visible = false
				get_node("Intro-2").visible = true
			elif (get_node("Intro-2").visible == true):
				get_node("Intro-2").visible = false
				get_node("Intro-3").visible = true
			elif (get_node("Intro-3").visible == true):
				get_node("Intro-3").visible = false
				get_node("Intro-4").visible = true
			elif (get_node("Intro-4").visible == true):
				get_node("Intro-4").visible = false
				get_node("Scoring").visible = true
				get_node("EnemySpawn").start_game()
				game_started = true
				get_node("Player").game_started()
				
	if (game_over == true):
		if (Input.is_action_just_pressed("ui_accept")):
			get_tree().reload_current_scene()
	
	if (game_over == false):
		recount()
			
		get_node("Scoring/GoodCount").text = "+$" + str(good_count + (10 * multiplier)) + '/f'
		get_node("Scoring/BadCount").text = "-$" + str(bad_count) + '/f'
		get_node("Scoring/Battery").text = str(int(battery)) + '%'
	
func recount():
	good_count = 0
	bad_count = 0
	multiplier = 0
	for N in get_node("EnemySpawn").get_children():
		if ("Enemy" in N.name):
			bad_count += 1
		elif ("Package" in N.name):
			good_count += 1
		elif ("Best" in N.name):
			multiplier += 1
			
	if (battery > 100.0):
		battery = 100.0
		
	if (battery <= 0):
		$"Intro-5".visible = true
		game_over = true
		get_node("Player").game_over()
		$ScoreTimer.stop()
		

func timeout():
	recount()
	score += good_count + (10 * multiplier)
	score -= bad_count
	get_node("Scoring/Score").text = '$' + comma_sep(score)
