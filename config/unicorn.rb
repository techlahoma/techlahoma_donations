worker_processes Integer(ENV["WEB_CONCURRENCY"] || 4)
timeout 15
preload_app true

check_client_connection true # try not to waste time on disconnected clients
# http://www.shopify.com/technology/7535298-what-does-your-webserver-do-when-a-user-hits-refresh#axzz2O2SNlD00

# Only allow reasonable backlog of requests per worker
# Force load balancer to send requests elsewhere if backlogged
listen ENV['PORT'], :backlog => Integer(ENV['UNICORN_BACKLOG'] || 20)


before_exec do |server|
  ENV['RUBY_HEAP_MIN_SLOTS']=800000
  ENV['RUBY_GC_MALLOC_LIMIT']=90000000
  ENV['RUBY_HEAP_SLOTS_INCREMENT']=250000
  ENV['RUBY_HEAP_SLOTS_GROWTH_FACTOR']=1
  ENV['RUBY_HEAP_FREE_MIN']=100000
end
#
@resque_pid = nil


before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!

  if defined?(Resque)
    Resque.redis.quit
    Rails.logger.info('Disconnected from Redis')
  end

end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection

  if defined?(Resque)
    #Resque.redis = ENV['REDISTOGO_URL']
    #Resque.redis.namespace = "resque:thephotolabs"
    #Rails.logger.info('Connected to Redis')
  end

end
