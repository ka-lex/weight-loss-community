# config/unicorn.rb
# Set environment to development unless something else is specified
rails_env = ENV['RAILS_ENV'] || 'production'
working_directory "/home/deploy/apps/gemabapp/current"
# See http://unicorn.bogomips.org/Unicorn/Configurator.html for complete
# documentation.
worker_processes 4
preload_app true
timeout 180

#listen "127.0.0.1:9000"
listen "/home/deploy/apps/gemabapp/shared/tmp/unicorn.sock", :backlog => 1024

#unicorn_bin "unicorn_rails"
stderr_path "/home/deploy/apps/gemabapp/shared/log/unicorn.stderr.log"
stdout_path "/home/deploy/apps/gemabapp/shared/log/unicorn.stdout.log"

user 'deploy', 'staff'

# Set master PID location
pid "/home/deploy/apps/gemabapp/shared/pids/unicorn.pid"

before_fork do |server, worker|
  # the following is highly recomended for Rails + "preload_app true"
  # as there's no need for the master process to hold a connection
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  end

  # Before forking, kill the master process that belongs to the .oldbin PID.
  # This enables 0 downtime deploys.
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  # the following is *required* for Rails + "preload_app true",
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end

  # if preload_app is true, then you may also want to check and
  # restart any other shared sockets/descriptors such as Memcached,
  # and Redis.  TokyoCabinet file handles are safe to reuse
  # between any number of forked children (assuming your kernel
  # correctly implements pread()/pwrite() system calls)
end