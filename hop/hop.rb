require "gosu"

class Player
  attr_accessor :x, :y, :width, :height
  def initialize window
    @window = window
    # position
    @x = @window.width/2
    @y = @window.height/2
    # dimensions
    @width = @height = 64
    # movement
    @velocity = 0.0
    @gravity  = -0.25
    @hop      = 7.5
    # images
    @rise = Gosu::Image.new @window, "rubyguy-rise.png"
    @fall = Gosu::Image.new @window, "rubyguy-fall.png"
  end

  def hop
    @velocity += @hop
  end

  def image
    if @velocity >= 0
      @rise
    else
      @fall
    end
  end

  def update
    @velocity += @gravity
    @y -= @velocity
    if @y > 1000
      @window.close
    end
  end

  def draw
    image.draw @x - @width/2, @y - @height/2, 1
  end
end

class HopGame < Gosu::Window
  def initialize width=800, height=600, fullscreen=false
    super
    self.caption = "Ruby Hop"
    @background = Gosu::Image.new self, "background.png"
    @player = Player.new self
  end

  def button_down id
    close       if id == Gosu::KbEscape
    @player.hop if id == Gosu::KbSpace
  end

  def update
    @player.update
  end

  def draw
    @background.draw 0, 0, 0
    @player.draw
  end
end

HopGame.new.show
