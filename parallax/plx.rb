require "gosu"

class PlxGame < Gosu::Window
  def initialize width=800, height=600, fullscreen=false
    super
    @foreground = Gosu::Image.new(self, "foreground.png", false)
    @background = Gosu::Image.new(self, "background.png", false)
    @movement = 8
    @x = @y = 0
  end

  def move_right
    @x = [@x + @movement, max_x].min
  end

  def move_left
    @x = [@x - @movement, min_x].max
  end

  def min_x
    0
  end

  def max_x
    @max_x ||= @foreground.width - self.width
  end

  def update
    move_right if button_down? Gosu::KbRight
    move_left  if button_down? Gosu::KbLeft
    close      if button_down? Gosu::KbEscape
  end

  def draw
    translate 0 - @x, 0 - @y do
      @background.draw 0, 0, -2
      @foreground.draw 0, 0, -1
    end
  end
end

PlxGame.new.show
