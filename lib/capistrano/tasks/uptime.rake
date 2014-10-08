desc "get uptime from server"
task :uptime do
  on roles(:all), in: :parallel do |host|
    uptime = capture(:uptime)
    puts "#{host.hostname} reports: #{uptime}"
  end
end

desc "restart server"
task :restart do
  on roles(:all) do |host|

  end
end