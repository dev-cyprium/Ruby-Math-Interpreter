require_relative "../lib/interpreter"
require_relative "../lib/lexer"

describe Interpreter do
	it 'Raises an expcetion when divided by 0' do
		par = Parser.new( Lexer.new ('2 / 0') )
		expect{Interpreter.new(par).interpret}.to raise_error('divided by 0')
	end
end