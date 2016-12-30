require_relative '../lib/token'
require_relative '../lib/node'

describe AST do
	describe 'Numeric node' do
		a_token = Token.new(Token::INTEGER, 5)
		b_token = Token.new(Token::INTEGER, 2)
		node = Num.new(a_token)

		it "Inherits from the AST base class" do	
			expect(node.is_a? AST).to eql(true) 
		end

		it "Has a value defined in the token value" do
			expect(node.value).to eql(a_token.value)
		end

		it "Has a referance to the token used to create it" do
			expect(node.token).to eql(a_token)
		end
	end
end