require_relative 'token'
require_relative 'lexer'
#
# Parser class for parsing the AST
# Creates the tree of nodes, that the interpreter can exectute
#
class Parser
	attr_reader ast

	def initialize(lexer)
		@lexer = lexer
	end

	def parse
	end

	# Private methods used to parse the math expression
	private

	#
	# Expression method, the first method in the GRAMMAR
	# expr: term((plus|minus) term)*
	#
	def expr
	end

	def term
	end

	def factor
	end
end