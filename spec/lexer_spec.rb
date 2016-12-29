require_relative "../lib/lexer"

describe Lexer do
	describe ".get_next_token" do
		it "Returns a list of all available tokens" do
			lex = Lexer.new("30 + - * / ( )")
			tokens = []
			6.times { tokens.push(lex.get_next_token.value) }
			expect(tokens).to match_array([30,'+','-','*','/','(',')',nil])
		end
		context "Given '3+2'" do
			it "Returns the first token" do
				lex = Lexer.new("3+2")
				expect(lex.get_next_token.value).to eql(3)
			end

			it "Returns a list of all tokens" do
				lex = Lexer.new("3+2")
				tokens = []
				4.times { tokens.push(lex.get_next_token.value) }

				expect(tokens).to match_array([3,'+',2, nil])
			end
		end

		context "Given '    3 +     2  '" do
			it "Returns the first token without whitespace" do
				lex = Lexer.new("    3 +     2  ")
				expect(lex.get_next_token.value).to eql(3)
			end
			it "Returns a list of all tokens wihtout whitespace" do
				lex = Lexer.new("    3 +     2  ")
				tokens = []
				4.times { tokens.push(lex.get_next_token.value) }

				expect(tokens).to match_array([3,'+',2,nil])
			end
		end

		context "Given ' 12232 + 22131 / 12312 * 34435'" do
			it "Returns a list of all tokens without whitespace" do
				lex = Lexer.new(" 12232 + 22131 / 12312 * 34435")
				tokens = []
				8.times { tokens.push(lex.get_next_token.value)}

				expect(tokens).to match_array([12232,'+',22131,'/',12312,'*',34435,nil])
			end
		end

		context "Given '3 c 2'" do
			it "Raises an Unknown token exception" do
				lex = Lexer.new("3 c 2")
				lex.get_next_token
				expect{lex.get_next_token}.to raise_error("Unknown token Exception")
			end
		end
	end
end