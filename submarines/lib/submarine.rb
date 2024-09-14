
class Submarine
	attr_reader :x, :y, :w, :h, :id, :dead
	# Creates a new Submarine object.
	#
	# @param x [Integer] the initial x position of the submarine
	# @param y [Integer] the initial y position of the submarine
	# @param speed [Integer] the speed of the submarine
	# @param path [String] the path to the image file of the submarine
	# @return [Submarine] the new Submarine object
	def initialize(x, y, speed, path)
		# Load the submarine image
		@img = Gosu::Image.new("image/submarine_#{path}.bmp")

		# Store the width and height of the submarine
		@w, @h = @img.width, @img.height

		# Store the x and y positions of the submarine
		@x, @y = x, y

		# Store the speed of the submarine
		@speed = speed

		# Store whether the submarine has been destroyed
		@dead = false
	end

	# Sets whether the submarine has been destroyed.
	#
	# @param state [Boolean] whether the submarine has been destroyed
	# @return [nil]
	def dead=(state)
		@dead=state
	end

	# Moves the submarine up the screen
	#
	# @return [Boolean] whether the submarine has gone off the screen
	def update
		# Check if the submarine has gone off the screen
		if @x<-200-@w || @x>1200
			# Return true to indicate that the submarine has gone off the screen
			true
		elsif @dead
			# Return true to indicate that the submarine has been destroyed
			true
		else
			# Return false to indicate that the submarine is still on the screen and has not been destroyed
			false
		end
	end

	# Draws the submarine at the specified position.
	#
	# @return [nil]
	def draw
		# Draw the submarine at the specified position
		@img.draw(@x, @y, 1)
	end
end

class FromRightSubmarine < Submarine
	def initialize
		@id=[1,1,1,1,1,3,3,3,3,3,5,5,5,7].sample
		super(1100, rand(250)+210, rand(2..4), @id)
	end
	def move
		@x-=@speed
	end
end

class FromLeftSubmarine < Submarine
	# Creates a new FromLeftSubmarine object
	#
	# @return [nil]
	def initialize
		# The id of the submarine
		# The id is randomly chosen from the array [2,2,2,2,2,4,4,4,4,4,6,6,6,8]
		@id=[2,2,2,2,2,4,4,4,4,4,6,6,6,8].sample
		# Call the superclass constructor to initialize the submarine
		super(-100, rand(250)+210, rand(2..4), @id)
	end

	# Moves the submarine to the right
	#
	# @return [nil]
	def move
		# Increase the x position of the submarine by its speed
		@x+=@speed
	end
end