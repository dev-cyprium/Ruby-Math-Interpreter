require_relative 'lib/interpreter'

file_name = ARGV[0]
data = ''
File.open(file_name, "r") do |file|
	data = file.read
end
puts "Parsing pascal program..."
puts data
interpreter = Interpreter.interpreterFactory(data)
interpreter.interpret
puts "Memory locations: #{Interpreter::GLOBAL_SCOPE}"
