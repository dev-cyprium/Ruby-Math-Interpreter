#
# Abstract class used as 
# a helper to visit nodes
#
class NodeVisitor
	def visit(node)
		method_name = "visit_" + node.class.name
		m = self.method(method_name.to_sym)
		return m.call(node)
	end
end

#
# Class used to interpret AST
# feed in the AST ( Abstract syntax tree you want to calculate )
#
class Interpreter < NodeVisitor
	
	def initialize(parser)
		@parser = parser
	end

	# Interprets the given math expression
	def interpret
		root = @parser.parse
		return self.visit(root)
	end

	# Creates the post-order notation of the given AST
	def post_order

	end

	def visit_BinOp(node)
		case node.op.type
		when Token::PLUS
			return self.visit(node.left) + self.visit(node.right)
		when Token::MINUS
			return self.visit(node.left) - self.visit(node.right)
		when Token::MUL
			return self.visit(node.left) * self.visit(node.right)
		when Token::DIV
			return self.visit(node.left) / self.visit(node.right)
		end
	end

	def visit_Num(node)
		return node.value
	end
end