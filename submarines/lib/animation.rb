
class Animation
	# Animation class
	#
	# This class represents an animation in the game. Each animation
	# consists of a set of frames and a duration. The frames are loaded
	# from the specified image file, and the duration specifies how long
	# the animation should be displayed.
	#
	# @param tiles [String] the path to the image file
	# @param w [Integer] the width of each frame
	# @param h [Integer] the height of each frame
	# @param x [Integer] the x position of the animation
	# @param y [Integer] the y position of the animation
	# @param z [Integer] the z position of the animation
	# @param lifetime [Integer] the duration of the animation in milliseconds
	#
	# @return [nil]
	def initialize(tiles,w,h,x,y,z,lifetime)
		# Load the animation frames from the specified image file
		@tiles = Gosu::Image.load_tiles(tiles,w,h)

		# Store the width and height of the animation
		@w,@h = w,h

		# Store the x, y, and z positions of the animation
		@x,@y,@z = x,y,z

		# Store the duration of the animation
		@lifetime = lifetime
	end

	# Draws the animation at the specified position.
	#
	# @return [nil]
	def draw
		# Get the current time
		currtime = Gosu.milliseconds

		# Check if the animation has expired
		if @lifetime > currtime
			# Calculate the index of the frame to draw
			# based on the current time
			i = (currtime/100) % @tiles.size

			# Draw the frame at the specified position
			@tiles[i].draw(@x-@w/2,@y-@h/2,@z)
		end
	end

	# Checks if the animation has expired.
	#
	# @return [Boolean] whether the animation has expired
	def die?
		# Get the current time
		currtime = Gosu.milliseconds

		# Check if the animation has expired
		@lifetime < currtime
	end
end

class Explosion < Animation
	# Constructor for the Explosion class
	#
	# @param x [Integer] the x position of the explosion
	# @param y [Integer] the y position of the explosion
	# @param currtime [Integer] the current time
	# @return [nil]
	def initialize(x,y,currtime)
		# The delay of the animation
		delay = 750

		# The initial score and chain
		@score,@chain = nil

		# Create a new font object
		@font = Gosu::Font.new(25)

		# Call the superclass constructor to initialize the animation
		super "image/explosion.bmp",62,62,x,y,2,currtime+delay
	end

	# Sets the score and chain for the explosion animation.
	#
	# @param score [Integer] the score of the explosion
	# @param chain [Integer] the chain of the explosion
	# @return [nil]
	def set_text(score,chain)
		# Set the score and chain
		@score,@chain = score,chain
	end

	# Draws the score and chain of the explosion animation.
	#
	# @return [nil]
	def draw_text
		# Draw the text to show the current score
		@font.draw_text("#{@score}x#{@chain}", @x-@w/2,@y-@h/2+25,@z, 1.0, 1.0, Gosu::Color::YELLOW)
	end
end