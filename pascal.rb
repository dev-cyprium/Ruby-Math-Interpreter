require 'benchmark'

require_relative 'lib/interpreter'
require_relative 'lib/symbol_builder'

file_name = ARGV[0]
data = ''
File.open(file_name, "r") do |file|
	data = file.read
end
puts data
puts "[INFO] Creating symbol table..."
lexer  = Lexer.new data
parser = Parser.new lexer
tree = parser.parse
symb_table  = SymbolTableBuilder.new

Benchmark.bm do |bm|
	bm.report do
		symb_table.visit(tree)
	end
end

puts "[INFO] Interpreting pascal program..."
interpreter = Interpreter.interpreterFactory(data)
Benchmark.bm do |bm|
	bm.report do
		interpreter.interpret
	end
end
puts "[INFO] Symbol Table contents: #{symb_table.symtab.defined_symbols}"
puts "[INFO] Runtime Memory contents: #{Interpreter::GLOBAL_SCOPE}"
