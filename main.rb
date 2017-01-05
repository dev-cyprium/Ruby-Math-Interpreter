require_relative 'lib/interpreter'
require_relative 'lib/lexer'
require_relative 'lib/parser'

while  true
	print "expr> "
	input = gets.chomp
	
	begin
		lexer = Lexer.new(input)
		parser = Parser.new(lexer)
		interpreter = Interpreter.new(parser)
		result = interpreter.interpret
	rescue Exception => e
		puts e.message
	else
		puts "=> #{result}"
	end
end