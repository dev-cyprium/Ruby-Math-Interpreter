require_relative "../lib/lexer"

describe Lexer do
	describe ".get_next_token" do
		context "Given '3+2'" do
			it "Returns the first token" do
				lex = Lexer.new("3+2")
				expect(lex.get_next_token).to eql("3")
			end
		end
	end
end