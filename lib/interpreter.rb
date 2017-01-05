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
		@root = @parser.parse

		@polish = []
	end

	# Interprets the given math expression
	def interpret
		return self.visit(@root)
	end

	# Creates the post-order notation of the given AST
	# IT DOES NOT WORK WITH UNARY OPERATORS!
	def to_reverse_polish
		@polish = []
		post_order_traverse(@root)
		return @polish.join(" ")
	end

	private

	def post_order_traverse(node)
		return if node.nil?
		post_order_traverse(node.left)
		post_order_traverse(node.right)

		@polish << node.to_s
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

	def visit_UnaryOp(node)
		case node.op.type
		when Token::PLUS
			return +self.visit(node.expr)
		when Token::MINUS
			return -self.visit(node.expr)
		end
	end
end