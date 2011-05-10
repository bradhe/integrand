ENV["REDIS_URL"] ||= "redis://localhost/"

uri = URI.parse(ENV["REDIS_URL"])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
