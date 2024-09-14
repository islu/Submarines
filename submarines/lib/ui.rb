class UI
	# Initializes a new UI object.
	#
	# @return [nil]
	def initialize
		# Loads the background music
		@bgm = Gosu::Sample.new("sound/The looming!.wav")

		# Sets the color of the sky
		@skyColor = Gosu::Color.argb(0xff_808080)

		# Sets the color of the sea
		@seaColor = Gosu::Color.argb(0xff_0000ff)

		# Creates a new font object
		@font = Gosu::Font.new(25)
	end

	# Draws the background of the game.
	#
	# The background is composed of the sky and the sea.
	# The sky is drawn as a quad with the color defined by @skyColor,
	# and the sea is drawn as a quad with the color defined by @seaColor.
	# @return [nil]
	def draw_background
		# Draw the sky
		Gosu.draw_quad(0, 0, @skyColor, 1000, 0, @skyColor, 1000, 200, @skyColor, 0, 200, @skyColor, 0)

		# Draw the sea
		Gosu.draw_quad(0, 200, @seaColor, 1000, 200, @seaColor, 1000, 500, @seaColor, 0, 500, @seaColor, 0)
	end

	# Draws the current score in the top left of the screen.
	#
	# @param score [Integer] the current score
	# @return [nil]
	def draw_score(score)
		# Draw the text to show the current score
		@font.draw_text("score: #{score}", 0, 0, 2, 1.0, 1.0, Gosu::Color::YELLOW)
	end

	# Draws the lose menu.
	#
	# The lose menu is drawn in the middle of the screen.
	# The lose menu tells the player to press [Esc] to exit the game
	# and [R] to restart the game.
	# @return [nil]
	def draw_lose_menu
		# Draw the text to tell the player to press [Esc] to exit the game
		@font.draw_text("presse [Esc] to exit game", 300, 180, 2, 1.0, 1.0, Gosu::Color::WHITE)

		# Draw the text to tell the player to press [R] to restart the game
		@font.draw_text("presse [R] to restart game", 300, 220, 2, 1.0, 1.0, Gosu::Color::WHITE)
	end

	# Starts playing the background music.
	#
	# The background music is started with 1 volume, 1 speed, and true for looping.
	# @return [nil]
	def play_bgm
		@bgm.play(1, 1, true)
	end
	def stop_bgm
		#@bgm.stop
	end
end
