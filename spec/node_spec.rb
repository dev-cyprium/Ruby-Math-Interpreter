require_relative '../lib/token'
require_relative '../lib/node'

describe AST do
	describe 'Numeric node' do
		a_token = Token.new(Token::INTEGER, 5)
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

	describe 'Binary Operator node' do
		a_token = Token.new(Token::INTEGER, 2)
		b_token = Token.new(Token::INTEGER, 5)
		op_token = Token.new(Token::PLUS, '+')

		leaf_left = Num.new(a_token)
		leaf_right = Num.new(b_token)
		root = BinOp.new(leaf_left, op_token, leaf_right)

		it "Inherits from the AST base class" do
			expect(root.is_a? AST).to eql(true)
		end

		it "Evaluates the operator node" do
			expect(root.left.value + root.right.value).to eql(7)
		end
	end
end