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

	# Interprets the given AST
	def interpret
		return self.visit(@root)
	end

	private
	def visit_Program(node)
		self.visit(node.block)
	end
	
	def visit_Block(node)
		node.declarations.each do |declaration|
			self.visit(declaration)
		end
		self.visit(node.compound_statement)
	end
	
	def visit_VarDecl(node)
		# Do nothing
	end
	
	def visit_Type(node)
		# Do nothing
	end
	
	def visit_BinOp(node)
		case node.op.type
		when Token::PLUS
			return self.visit(node.left) + self.visit(node.right)
		when Token::MINUS
			return self.visit(node.left) - self.visit(node.right)
		when Token::MUL
			return self.visit(node.left) * self.visit(node.right)
		when Token::INTEGER_DIV
			return self.visit(node.left) / self.visit(node.right)
		when Token::FLOAT_DIV
			return self.visit(node.left).to_f / self.visit(node.right).to_f
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