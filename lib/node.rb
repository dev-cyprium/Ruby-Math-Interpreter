class AST
end

# 
# Binarry Operator AST Node
# Used to store information for the operator node
#
class BinOp < AST 
	attr_reader :left, :op, :token, :right

	def initialize(left, op, right)
		@left = left
		@op = @token = op
		@right = right
	end
end

#
# Numeric AST Node
# Used to store information for the numerical node
#
class Num < AST
	attr_reader :token, :value

	def initialize(token)
		@token = token
		@value = token.value
	end
end