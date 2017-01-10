class AST
	def to_s
		return "#{@token.value}"
	end
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
	attr_reader :token, :value, :left, :right

	def initialize(token)
		@token = token
		@value = token.value
		@left = @right = nil
	end
end

#
# Unarry Operator node
#
class UnaryOp < AST
	attr_reader :op, :expr

	def initialize(op, expr)
		@token = @op = op
		@expr = expr
	end
end

# 
# Represents a BEGIN ... END block
#
class Compound < AST
	attr_accessor :children

	def initialize()
		@children = []
	end
end

#
# Represents an assign node
#
class Assign < AST
	attr_reader :left, :op, :right, :token

	def initialize(left, op , right)
		@left = left
		@token = @op = op
		@right = right
	end
end

#
# Represents a variable node, constructed with ID token
#
class Var < AST
	attr_reader :value, :token

	def initialize(token)
		@token = token
		@value = token.value
	end
end

#
# Represents an empty statement, for example an empty BEGIN END block
#
class NoOp < AST
end