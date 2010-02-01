require 'example_helper'

match = rebuil("hello world") do
  many
	group("rebuil", :cool)
end.match('hello world with rebuil')

puts "#{match[:cool]} is cool"

