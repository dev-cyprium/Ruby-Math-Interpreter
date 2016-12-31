require_relative 'lib/interpreter'
require_relative 'lib/lexer'

while  true
	print "expr> "
	input = gets.chomp
	
	begin
		lexer = Lexer.new(input)
		inter = Interpreter.new(lexer)
		result = inter.parse
	rescue Exception => e
		puts e.message
	else
		puts "=> #{result}"
	end
end