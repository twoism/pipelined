require 'bunny'
require 'singleton'

class BunnyClient
  include Singleton

  def publish(queue, msg)
    @bunny ||= setup_bunny
    @bunny.publish(msg, :key => queue) 
  end

  def setup_bunny
    bunny = Bunny.new
    bunny.start

    bunny.queue("sanitize")
    bunny.queue("process")
    bunny.queue("autopost")

    bunny.exchange("")
  end
end

