require_relative "../lib/interpreter"
require_relative "../lib/lexer"

describe Interpreter do
	describe '.expr' do
		it "Evaluates single values to themselfs" do
			lexer = Lexer.new("1")
			inter = Interpreter.new( lexer )
			expect(inter.expr).to eql(1)
		end

		context "Given an expression a + b + c + ..." do
			it "Evaluates 1 + 2 + 3" do
				lexer = Lexer.new("1 + 2 + 3")
				inter = Interpreter.new( lexer )
				expect(inter.expr).to eql(6)
			end
			it "Evaluates 10 + 200" do
				lexer = Lexer.new("10 + 200")
				inter = Interpreter.new( lexer )
				expect(inter.expr).to eql(210)
			end
		end


		context "Given an expression a - b - c - ..." do
			it "Evaluates 1 - 2 - 3" do
				lexer = Lexer.new("1 - 2 - 3")
				inter = Interpreter.new( lexer )
				expect(inter.expr).to eql(-4)
			end

			it "Evaluates 200 - 10" do
				lexer = Lexer.new("200 - 10")
				inter = Interpreter.new( lexer )
				expect(inter.expr).to eql(190)
			end
		end
	end
end