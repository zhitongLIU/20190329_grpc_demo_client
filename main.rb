# SETUP
require 'rubygems'
require 'bundler'

Bundler.setup

require 'pry'
require 'grpc'
require 'google/protobuf'

this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, '20190329_user_service_ruby_lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'users_service_services_pb'
#___________________________________
#


def main
  start = Time.now
  user_service = Demo::Users::Stub.new('0.0.0.0:3000', :this_channel_is_insecure)

  id = ARGV.size > 0 ? ARGV[0] : nil

  if id
    user = user_service.find(Demo::FindUserRequest.new(id: id.to_i))
    puts "user #{user.id}, email: #{user.email}  name: #{user.name}"
  else
    response = user_service.all(Demo::AllUserRequest.new())
    response.users.each do |user|
      puts "user #{user.id}, email: #{user.email}  name: #{user.name}"
    end
  end
  finish = Time.now
  puts finish - start
end

main

