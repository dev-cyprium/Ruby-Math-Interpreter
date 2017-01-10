require_relative '../lib/parser'

# TODO: Write Pascal test cases
describe Parser do

	describe '.parse' do
		context 'Given an error' do
			error = "Unexpected token in syntax"
			par_error = "Parentesies not closed"
			it 'Throws an Error on expression 2 +' do
				expect{Parser.new( Lexer.new('2 + ') ).parse }.to raise_error(error)
			end
			it "Throws an Error on expression + 2 3" do
				expect{Parser.new(Lexer.new '+ 2 3').parse }.to raise_error(error)
			end
			it "Throws an Error on expression 2 3 4" do
				expect{Parser.new(Lexer.new '2 3 4').parse }.to raise_error(error)
			end
			it "Throws an Error on expression 2 ( 3" do
				expect{Parser.new(Lexer.new '2 ( 3').parse }.to raise_error(par_error)
			end
			it "Throws an Error on expression 2 * ( 3 + 2 )) + 2" do
				expect{Parser.new(Lexer.new '2 ( 3').parse }.to raise_error(par_error)
			end
			it "Throws an Error on expression 2 * ( 3 + 2 * ( 3 + 2 )" do
				expect{Parser.new(Lexer.new '2 * ( 3 + 2 * ( 3 + 2 )').parse }.to raise_error(par_error)
			end
			it "Throws an Error on expression 2 ()" do
				expect{Parser.new(Lexer.new '2 ()').parse }.to raise_error(error)
			end
		end
	end
end