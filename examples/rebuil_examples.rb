require 'example_helper'

puts "cool" if rebuil("hello world") do 
	many
end.line_end =~ "hello world with rebuil"

match = rebuil("hello world") do
  many
	group("rebuil")
end.match('hello world with rebuil')

puts match[1]

