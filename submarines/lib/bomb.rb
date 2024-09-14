
class Bomb
	attr_reader :x, :y, :w, :h
	# Initializes a new Bomb object.
	#
	# @param x [Integer] the initial x position of the bomb
	# @param y [Integer] the initial y position of the bomb
	def initialize(x, y)
		# Load the bomb image
		@img=Gosu::Image.new("image/bomb.bmp")

		# Store the width and height of the bomb
		@w, @h=@img.width, @img.height

		# Store the x and y positions of the bomb
		@x, @y=x, y

		# Store the screen height
		@screen_h=500

		# Store the speed of the bomb
		@speed=2

		# Store whether the bomb has been destroyed
		@dead=false
	end

	# Moves the bomb down the screen
	#
	# @return [nil]
	def move
		# Move the bomb down the screen by its speed
		@y += @speed
	end

	# Sets whether the bomb has been destroyed.
	#
	# @param state [Boolean] whether the bomb has been destroyed
	# @return [nil]
	def dead=(state)
		@dead=state
	end

	# Checks if the bomb has moved off the screen or has been destroyed.
	#
	# @return [Boolean] whether the bomb has moved off the screen or has been destroyed
	def update
		# If the bomb has moved off the screen
		if @y > @screen_h
			# Return true to indicate that the bomb needs to be removed
			true
		# If the bomb has been destroyed
		elsif @dead
			# Return true to indicate that the bomb needs to be removed
			true
		else
			# Return false to indicate that the bomb does not need to be removed
			false
		end
	end
	def draw
		@img.draw(@x-@w/2, @y, 1)
	end
end

class Torpedo
	attr_reader :x, :y, :w, :h
	# Initializes a new Torpedo object.
	#
	# @param x [Integer] the initial x position of the torpedo
	# @param y [Integer] the initial y position of the torpedo
	def initialize(x, y)
		# Load the torpedo image
		@img=Gosu::Image.new("image/torpedo.bmp")

		# Store the width and height of the torpedo
		@w, @h=@img.width, @img.height

		# Store the x and y positions of the torpedo
		@x, @y=x, y

		# Store the screen height
		@screen_h=500

		# Store the speed of the torpedo
		@speed=rand(1..2)

		# Store whether the torpedo has been destroyed
		@dead=false
	end

	# Sets whether the torpedo has been destroyed.
	#
	# @param state [Boolean] whether the torpedo has been destroyed
	# @return [nil]
	def dead=(state)
		@dead=state
	end

	# Moves the torpedo up the screen
	#
	# @return [nil]
	def move
		# Move the torpedo up the screen by its speed
		@y -= @speed
	end

	# Checks if the torpedo is off the screen or has been destroyed.
	#
	# @return [Boolean] whether the torpedo is off the screen or has been destroyed
	def update
		# Check if the torpedo is off the screen
		if @y < 200-@h/2
			# Return true to indicate that the torpedo is off the screen
			true
		# Check if the torpedo has been destroyed
		elsif @dead
			# Return true to indicate that the torpedo has been destroyed
			true
		else
			# Return false to indicate that the torpedo is not off the screen or has not been destroyed
			false
		end
	end

	# Draws the torpedo at the specified position.
	#
	# @return [nil]
	def draw
		# Draw the torpedo at the specified position
		@img.draw(@x-@w/2, @y, 1)
	end
end