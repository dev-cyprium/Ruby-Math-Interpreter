#
# Class used to interpret tokens
#
class Interpreter
	def initialize(lexer)
		@lexer = lexer
		@current_token = @lexer.get_next_token
	end


	#
	# Grammar used:
	# expr: term((plus|minus) term)*
	# term: factor((mul|div) factor)*
	# factor: INTEGER
	#
	def expr
		# Check if all the parentesies are closed
		text = @lexer.text
		check_parentesies_pairs( text )
		
		result = term()

		while [Token::PLUS, Token::MINUS].include? (@current_token.type)
			case @current_token.type
			when Token::PLUS
				eat(Token::PLUS)
				result = result + term()
			when Token::MINUS
				eat(Token::MINUS)
				result = result - term()
			end
		end

		result
	end

	private
	# Consumes the curent token and requests a new one
	# If an unexpected token gets consumed, throw an error
	def eat(token_type)
		if @current_token.type == token_type
			@current_token = @lexer.get_next_token
		else
			error
		end
	end

	def term
		result = factor()

		while [Token::MUL, Token::DIV].include? (@current_token.type)
			case @current_token.type
			when Token::MUL
				eat(Token::MUL)
				result = result * factor()
			when Token::DIV
				eat(Token::DIV)
				result = result / factor()
			end
		end

		result
	end

	def factor
		token = @current_token
		if token.type == Token::INTEGER
			eat(Token::INTEGER)
			return token.value
		elsif token.type == Token::LPARENT
			eat(Token::LPARENT)
			result = self.expr
			eat(Token::RPARENT)
			result
		else
			error
		end
	end

	# Cheks if all the parentesies are closed
	def check_parentesies_pairs (input)
		lparen_count = 0
		rparen_count = 0
		input.each_char do |char|
			lparen_count+=1 if char == '('
			rparen_count+=1 if char == ')'
		end
		raise error if lparen_count != rparen_count
	end

	# Throws syntax error
	def error
		raise "Unknown syntax Exception"
	end
end