require_relative 'lib/interpreter'


while  true
	print "expr> "
	input = gets.chomp
	lexer = Lexer.new(input)
	inter = Interpreter.new(lexer)
	puts "=> #{inter.expr}"
end