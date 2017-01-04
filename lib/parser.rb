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

		@current_token = lexer.get_next_token
	end

	def parse
	end

	# Private methods used to parse the math expression
	private

	# Consumes the token, and gets the next one
	def eat(token_type)
		if token_type == @current_token.type
			@current_token = @lexer.get_next_token
		else
			error
		end
	end

	# Error method, called when parsing fails
	def error

	end

	# 
	# Expression method, the first method in the GRAMMAR
	# expr: term((plus|minus) term) *
	#
	def expr
		node = term()
	end

	#
	# Term method, the second method in the GRAMMAR
	# term: factor((mul|div) factor) *
	#
	def term
		node = factor()
	end

	#
	# Factor method, the third method in the GRRAMMAR
	# factor: INTEGER | LPARENT expr RPARENT
	#
	def factor
		token = @current_token
		if token.type == Token::INTEGER

		elsif token.type == Token::LPARENT
			
		end
	end
end