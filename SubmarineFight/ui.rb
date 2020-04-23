class UI
	def initialize
		@bgm = Gosu::Sample.new("audio/The looming!.wav")
		@skyColor = Gosu::Color.argb(0xff_808080)
		@seaColor = Gosu::Color.argb(0xff_0000ff)
		@font20 = Gosu::Font.new(20)
		@font25 = Gosu::Font.new(25)
	end
	def draw_background
		Gosu.draw_quad(0, 0, @skyColor, 1000, 0, @skyColor, 1000, 200, @skyColor, 0, 200, @skyColor, 0)
		Gosu.draw_quad(0, 200, @seaColor, 1000, 200, @seaColor, 1000, 500, @seaColor, 0, 500, @seaColor, 0)
	end
	def draw_text(score)
		@font20.draw_text("score: #{score}", 10, 10, 2, 1.0, 1.0, Gosu::Color::YELLOW)
	end
	def draw_lose_menu
		@font25.draw_text("presse [Esc] to exit game", 300, 180, 2, 1.0, 1.0, Gosu::Color::WHITE)
		@font25.draw_text("presse [R] to restart game", 300, 220, 2, 1.0, 1.0, Gosu::Color::WHITE)
	end
	def play_bgm
		@bgm.play(1, 1, true)
	end
	def stop_bgm
		@bgm.stop
	end
end
