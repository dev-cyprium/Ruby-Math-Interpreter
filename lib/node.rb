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

#
# Reporesent the whole programm
#
class Program < AST
	attr_reader :name, :block
	
	def initialize(name, block)
		@name = name
		@block = block
	end	
end

#
# Represents a block
#
class Block < AST
	attr_reader :declarations
	attr_reader :compound_statement
	
	def initialize(declarations, compound_statement)
		@declarations = declarations
		@compound_statement = compound_statement
	end
end

#
# VarDecl represents a variable declaration
#
class VarDecl < AST
	attr_reader :var_node, :type_node
	
	def initialize(var_node, type_node)
		@var_node = var_node
		@type_node = type_node
	end	
end

#
# Represents a type node ( INTEGER, REAL )
#
class Type < AST
	attr_reader :token, :value
	
	def initialize(token)
		@token = token
		@value = token.value
	end	
end