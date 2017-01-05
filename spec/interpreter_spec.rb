require_relative "../lib/interpreter"
require_relative "../lib/lexer"

describe Interpreter do
	it 'Raises an expcetion when divided by 0' do
		par = Parser.new( Lexer.new ('2 / 0') )
		expect{Interpreter.new(par).interpret}.to raise_error('divided by 0')
	end

	context 'Given an expression' do
		it "Calculates 2 + 3 - 1 * 2" do
			par = Parser.new( Lexer.new( '2 + 3 - 1 * 2' ) )
			expect(Interpreter.new(par).interpret).to eql(3)
		end
		it "Converts 2 + 3 - 1 * 2 to reverse polish notation" do
			par = Parser.new( Lexer.new( '2 + 3 - 1 * 2' ) )
			expect(Interpreter.new(par).to_reverse_polish).to eql("2 3 + 1 2 * -")
		end
		it "Converts 2+3/(3-1)*(3+(4/(3*1*2)/2)-1) to reverse polish notation" do
			par = Parser.new( Lexer.new('2 + 3 / ( 3 - 1) * (3 + ( 4 / ( 3 * 1 * 2) / 2) - 1)') )
			expect(Interpreter.new(par).to_reverse_polish).to eql("2 3 3 1 - / 3 4 3 1 * 2 * / 2 / + 1 - * +")
		end
	end
end