require "amqp"

EventMachine.run do
  AMQP.connect(:host => '127.0.0.1') do |connection|
    puts "Connected to AMQP broker. Running #{AMQP::VERSION} version of the gem..."

    channel  = AMQP::Channel.new(connection)

    channel.queue("amqpgem.examples.helloworld", :auto_delete => true).subscribe do |payload|
      puts "Received a message: #{payload}. Disconnecting..."

      connection.close { EventMachine.stop }
    end

    channel.direct("").publish "Hello, world!", :routing_key => "amqpgem.examples.helloworld"
  end
end
