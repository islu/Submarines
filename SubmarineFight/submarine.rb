class Submarine
	attr_reader :x, :y, :w, :h, :id, :dead
	def initialize(x, y, speed, path)
		@img=Gosu::Image.new("image/submarine_#{path}.bmp")
		@w, @h=@img.width, @img.height
		@x, @y=x, y
		@speed=speed
		@dead=false
	end
	def dead=(state)
		@dead=state
	end
	def update
		if @x<-200-@w || @x>1200
			true
		elsif @dead
			true	
		else
			false
		end 
	end
	def draw
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
	def initialize
		@id=[2,2,2,2,2,4,4,4,4,4,6,6,6,8].sample
		super(-100, rand(250)+210, rand(2..4), @id)
	end
	def move
		@x+=@speed
	end
end