require_relative "../lib/lexer"

describe Lexer do
	describe ".get_next_token" do
		it "Returns a list of all available tokens" do
			tokens = "30 + - * / ( ) var . BEGIN END ;"
			lex = Lexer.new(tokens)
			(tokens.length).times { lex.get_next_token }
			expect(lex.get_next_token.type).to eql("EOF")
		end
		#
		# TODO: Write test cases for Pascal code
		#
	end
	
	it 'Should skip over comments' do
		program = '{  This is a comment  }'
		lex = Lexer.new(program)
		expect(lex.get_next_token.type).to eql("EOF")
	end
end