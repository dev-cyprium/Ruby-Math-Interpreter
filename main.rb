require_relative 'lib/interpreter'
require_relative 'lib/lexer'

while  true
	print "expr> "
	input = gets.chomp
	lexer = Lexer.new(input)
	inter = Interpreter.new(lexer)
	puts "=> #{inter.expr}"
end