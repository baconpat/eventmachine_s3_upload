require "rubygems"
require "bundler/setup"
require 'happening'
require 'yaml'

s3_config = YAML.load_file("s3.yml")

EM.run do 
  EventMachine::add_periodic_timer(1) { print "." }
  
  item = Happening::S3::Item.new(s3_config['bucket'],
                                 "25mb_file", 
                                 :protocol => "http",
                                 :aws_access_key_id => s3_config['access_key_id'],
                                 :aws_secret_access_key => s3_config['secret_access_key'],
                                 :permissions => 'public-read')
  
  file_contents = File.read("data/25mb_file")
  start_time = Time.now
  item.put file_contents do |response|
    puts "Finished in #{Time.now - start_time} seconds"
    EM.stop
  end
end
