
class Image
	attr_reader :x,:y,:w,:h
	# Constructor for the Image class
	#
	# @param img [String] the path to the image file
	# @param x [Integer] the x position of the image
	# @param y [Integer] the y position of the image
	# @param z [Integer] the z position of the image
	# @return [nil]
	def initialize(img,x,y,z)
		# Load the image from the specified path
		@img = Gosu::Image.new(img)

		# Store the width and height of the image
		@w,@h = @img.width,@img.height

		# Store the x, y, and z positions of the image
		@x,@y,@z = x,y,z
	end

	# Draws the image at the specified position
	#
	# @return [nil]
	def draw
		@img.draw(@x,@y,@z)
	end
end

class Player < Image
	# Constructor for the Player class
	#
	# @return [nil]
	def initialize
		# Call the superclass constructor to initialize the image
		super "image/ship_1.bmp",500,200,1

		# Set the player's screen width
		@screen_w = 1000

		# Set the player's movement speed
		@speed = 3

		# Set the maximum number of bombs the player can carry
		@max_bomb_carry = 5

		# Set the cooldown time for the player to drop a bomb
		@cd = 0

		# Set the cooldown time for the player to drop a bomb
		@cold = 200

		# Load the bomb image
		@b_img = Gosu::Image.new("image/bomb.bmp")
	end

	# Moves the player to the right
	#
	# If the player is on the right edge of the screen, the player will not move
	# @return [nil]
	def right
		# Check if the player is not on the right edge of the screen
		# and if the player is not on the right edge of the screen, move the player to the right
		@x+=@speed if @x<@screen_w-@w
	end

	# Moves the player to the left
	#
	# If the player is on the left edge of the screen, the player will not move
	# @return [nil]
	def left
		@x-=@speed if @x>0
	end

	# Checks if the player can drop a bomb.
	#
	# The player can drop a bomb if the number of bombs the player has is less than the maximum number of bombs the player can carry and if the cooldown time for dropping a bomb has passed.
	# @param list [Array] the array of bombs the player currently has
	# @param currtime [Integer] the current time
	# @return [Boolean] whether the player can drop a bomb
	def drop?(list,currtime)
		# Check if the number of bombs the player has is less than the maximum number of bombs the player can carry
		# and if the cooldown time for dropping a bomb has passed
		if list.size<@max_bomb_carry && @cd<currtime
			# Set the cooldown time for dropping a bomb to the current time plus the cooldown time
			@cd = currtime+@cold
			# Return true to indicate that the player can drop a bomb
			true
		else
			# Return false to indicate that the player cannot drop a bomb
			false
		end
	end

	# Draws the player at the specified position.
	#
	# @return [nil]
	def draw
		# Draw the player at the specified position
		@img.draw(@x, @y-@h, @z)
	end

	# Draws the number of bombs the player can still drop
	#
	# @param bombs [Array] the array of bombs the player currently has
	# @return [nil]
	def draw_remained_bombs(bombs)
		# Calculate the number of bombs the player can still drop
		remained = @max_bomb_carry-bombs.length

		# Set the initial x position
		x = @screen_w/2-50

		# Set the offset for each bomb image
		offset = 20

		# Draw the bomb images
		(remained).times do |b|
			# Draw the bomb image at the specified position
			@b_img.draw(x, 0, 1)

			# Update the x position for the next bomb image
			x += offset
		end
	end
end
