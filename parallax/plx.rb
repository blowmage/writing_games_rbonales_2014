require "gosu"

class Sprite
  def initialize window
    @window = window
    # image
    @width = @height = 160
    @idle = Gosu::Image.load_tiles @window,
                                   "player_160x160_idle.png",
                                   @width, @height, true
    @move = Gosu::Image.load_tiles @window,
                                   "player_160x160_move.png",
                                   @width, @height, true
    # center image
    @x = @window.width/2  - @width/2
    @y = @window.height/2 - @height/2
    # direction and movement
    @direction = :right
    @frame = 0
    @moving = false
  end

  def update
    @frame += 1
    @moving = false
    if @window.button_down? Gosu::KbLeft
      @direction = :left
      @moving = true
      @x += -5
    elsif @window.button_down? Gosu::KbRight
      @direction = :right
      @moving = true
      @x += 5
    end
  end

  def draw
    # @move and @idle are the same size,
    # so we can use the same frame calc.
    f = @frame % @idle.size
    image = @moving ? @move[f] : @idle[f]
    if @direction == :right
      image.draw @x, @y, 1
    else
      image.draw @x + @width, @y, 1, -1, 1
    end
  end

end

class PlxGame < Gosu::Window
  def initialize width=800, height=600, fullscreen=false
    super
    @foreground = Gosu::Image.new(self, "foreground.png", false)
    @background = Gosu::Image.new(self, "background.png", false)
    @sprite = Sprite.new self
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
    @sprite.update
  end

  def plx_ratio
    @plx_ratio ||= (@background.width - self.width) / (@foreground.width - self.width).to_f
  end

  def plx_coords
    [0 - (@x * plx_ratio), 0]
  end

  def cam_coords
    [0 - @x, 0 - @y]
  end

  def draw
    translate *plx_coords do
      @background.draw 0, 0, -2
    end
    translate *cam_coords do
      @foreground.draw 0, 0, -1
      @sprite.draw
    end
  end
end

PlxGame.new.show
