require_relative "../lib/interpreter"
require_relative "../lib/lexer"

describe Interpreter do
	describe '.expr' do
		it "Evaluates single values to themselfs" do
			lexer = Lexer.new("1")
			inter = Interpreter.new( lexer )
			expect(inter.expr).to eql(1)
		end

		context "Given expression a + b + c + ..." do
			it "Evaluates 1 + 2 + 3" do
				lexer = Lexer.new("1 + 2 + 3")
				inter = Interpreter.new( lexer )
				expect(inter.expr).to eql(6)
			end
			it "Evaluates 1 + 2" do
				lexer = Lexer.new("1 + 2")
				inter = Interpreter.new( lexer )
				expect(inter.expr).to eql(3)
			end
		end
	end
end