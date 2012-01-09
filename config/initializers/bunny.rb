require 'bunny'
require 'singleton'

class BunnyClient
  include Singleton

  def publish(queue, msg)
    @bunny ||= setup_bunny
    @bunny.publish(msg, :key => queue) 
  end

  def bunny
    @bunny ||= setup_bunny
  end

  def setup_bunny
    p "setting bunny up"
    bunny = Bunny.new
    bunny.start
    bunny.exchange("")
    bunny
  end
end

