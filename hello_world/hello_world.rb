require "gosu"

class HelloWorldGame < Gosu::Window
  def initialize width=800, height=600, fullscreen=false
    super
    self.caption = "Hello world!"
  end

  def update
  end

  def draw
  end
end

HelloWorldGame.new.show
