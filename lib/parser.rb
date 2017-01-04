require_relative 'token'
require_relative 'node'
require_relative 'lexer'
#
# Parser class for parsing the AST
# Creates the tree of nodes, that the interpreter can exectute
#
class Parser
	def initialize(lexer)
		@lexer = lexer

		@current_token = lexer.get_next_token
		@last_token = nil
	end

	def parse
		root = expr
		error if @current_token.type != Token::EOF
		return root
	end

	# Private methods used to parse the math expression
	private

	# Consumes the token, and gets the next one
	def eat(token_type)
		if token_type == @current_token.type
			@last_token = @current_token
			@current_token = @lexer.get_next_token
		else
			error
		end
	end

	# Error method, called when parsing fails
	def error
		raise "Unespected token #{@current_token} after #{@last_token}"
	end

	# 
	# Expression method, the first method in the GRAMMAR
	# expr: term((plus|minus) term) *
	#
	def expr
		node = term()

		while [Token::PLUS, TOKEN::MINUS].include? @current_token.type
			token = @current_token
			case @current_token.type
			when Token::PLUS
				eat(Token::PLUS)
			when Token::MINUS
				eat(Token::MINUS)
			end

			node = BinOp.new(node, token, term() )
		end
		node
	end

	#
	# Term method, the second method in the GRAMMAR
	# term: factor((mul|div) factor) *
	#
	def term
		node = factor()

		while [Token::DIV, Token::MUL].include? @current_token.type 
			token = @current_token
			case @current_token.type
			when Token::DIV 
				eat(Token::DIV)
			when Token::MUL 
				eat(Token::MUL)
			end

			node = BinOp.new(node, token, factor() )
		end
		node
	end

	#
	# Factor method, the third method in the GRRAMMAR
	# factor: INTEGER | LPARENT expr RPARENT
	#
	def factor
		token = @current_token
		if token.type == Token::INTEGER
			eat(Token::INTEGER)
			return Num.new(token)
		elsif token.type == Token::LPARENT
			eat(TOKEN::LPARENT)
			node = expr()
			eat(TOKEN::RPARENT)
			return node
		end
	end
end