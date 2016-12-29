require_relative "../lib/lexer"

describe Lexer do
	describe ".get_next_token" do
		context "Given '3+2'" do
			it "Returns the first token" do
				lex = Lexer.new("3+2")
				expect(lex.get_next_token.value).to eql(3)
			end

			it "Returns a list of all tokens" do
				lex = Lexer.new("3+2")
				tokens = []
				tokens.push lex.get_next_token.value
				tokens.push lex.get_next_token.value
				tokens.push lex.get_next_token.value

				expect(tokens).to match_array([3,'+',2])
			end
		end
	end
end