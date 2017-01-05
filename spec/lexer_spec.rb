require_relative "../lib/lexer"

describe Lexer do
	describe ".get_next_token" do
		it "Returns a list of all available tokens" do
			tokens = "30 + - * / ( )"
			lex = Lexer.new(tokens)
			(tokens.length + 1).times { lex.get_next_token }
		end
		
		context "Given '3+2'" do
			it "Returns a list of all tokens" do
				lex = Lexer.new("3+2")
				tokens = []
				4.times { tokens.push(lex.get_next_token.value) }

				expect(tokens).to match_array([3,'+',2, nil])
			end
		end

		context "Given '    3 +     2  '" do
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

		context "Given a number bigger then 15 digits, raise an exception" do
			it "Raises an exception on a big number" do
				lex = Lexer.new("1000000000000000")
				expect{lex.get_next_token}.to raise_error("Number too big Exception")
			end
		end
	end
end