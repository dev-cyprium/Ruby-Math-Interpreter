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
	end

	def parse
		par_error if not(parentes_closed?)
		root = expr
		error if @current_token.type != Token::EOF
		return root
	end

	# Private methods used to parse the math expression
	private

	# Checks to see if brackets are closed in the input
	def parentes_closed?
		input = @lexer.text
		lparen_count = 0
		rparen_count = 0
		input.each_char do |char|
			lparen_count+=1 if char == '('
			rparen_count+=1 if char == ')'
		end
		lparen_count == rparen_count
	end

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
		raise "Unexpected token in syntax"
	end

	# Parentesies error method, raised when parentesies aren't closed
	def par_error
		raise 'Parentesies not closed'
	end

	# 
	# Expression method, the first method in the GRAMMAR
	# expr: term((plus|minus) term) *
	#
	def expr
		node = term()

		while [Token::PLUS, Token::MINUS].include? @current_token.type
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
	# factor: (plus|minus) factor | INTEGER | LPARENT expr RPARENT
	#
	def factor
		case @current_token.type
		when Token::PLUS
			eat(Token::PLUS)
			node = UnaryOp.New(@current_token, factor())
			return node
		when Token::MINUS
			eat(Token::MINUS)
			node = UnaryOp.new(@current_token, factor())
			return node
		when Token::INTEGER
			eat(Token::INTEGER)
			return Num.new(@current_token)
		when Token::LPARENT
			eat(Token::LPARENT)
			node = expr()
			eat(Token::RPARENT)
			return node
		else
			error
		end
	end
end