require 'benchmark'

require_relative 'lib/interpreter'
require_relative 'lib/symbol_builder'

file_name = ARGV[0]
data = ''
File.open(file_name, "r") do |file|
	data = file.read
end
puts "Parsing pascal program..."
puts data
lexer  = Lexer.new data
parser = Parser.new lexer
tree = parser.parse
symb_table  = SymbolTableBuilder.new

# interpreter = Interpreter.interpreterFactory(data)
Benchmark.bm do |bm|
	bm.report do
		# interpreter.interpret
		symb_table.visit(tree)
	end
end
# puts "Memory locations: #{Interpreter::GLOBAL_SCOPE}"
