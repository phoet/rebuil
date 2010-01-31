require 'example_helper'

match = rebuil("hello world") do
  many
	group("rebuil")
end.match('hello world with rebuil')

puts "#{match[1]} is cool"

