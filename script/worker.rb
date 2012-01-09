require 'post'
require "amqp"

EventMachine.run do
  AMQP.connect(:host => '127.0.0.1') do |connection|
    puts "Connected to AMQP broker. Running #{AMQP::VERSION} version of the gem..."

    channel  = AMQP::Channel.new(connection)

    channel.queue("posts.sanitize", :auto_delete => true).subscribe do |payload|
      p "[sanitize] finding post #{payload} "
      po = Post.find(payload)
      po.sanitize!
      channel.direct("").publish(payload, :routing_key => "posts.process") 
    end
    
    channel.queue("posts.process", :auto_delete => true).subscribe do |payload|
      p "[process] finding post #{payload}"
      po = Post.find(payload)
      po.process!
      channel.direct("").publish(payload, :routing_key => "posts.autopost") 
    end
   
    channel.queue("posts.autopost", :auto_delete => true).subscribe do |payload|
      p "[autopost] finding post #{payload}"
      po = Post.find(payload)
      po.autopost!
      p "finished post #{payload}"
    end



  end
end
