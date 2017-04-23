require_relative 'lexer'
require_relative 'parser'
require_relative 'node'
require_relative 'token'

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
		
	# Variable memory locations
	GLOBAL_SCOPE = {}

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

	def visit_Compound(node)
		node.children.each do |child|
			self.visit(child)
		end
	end

	def visit_NoOp(node)
		# Pass the current node, EMPTY node
	end

	def visit_Assign(node)
		var_name = node.left.value
		GLOBAL_SCOPE[var_name.to_sym] = visit(node.right)
	end

	def visit_Var(node)
		var_name = node.value
		val = GLOBAL_SCOPE[var_name.to_sym]
		raise "Undefined variable #{var_name}" if val.nil?
		val
	end
	
	# Create interpreter with the given string
	def self.interpreterFactory(string)
		interpreter = Interpreter.new( Parser.new( Lexer.new( string ) ) )
	end
end