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


	private
	# Consumes the curent token and requests a new one
	# If an unexpected token gets consumed, throw an error
	def eat(token_type)
		if @current_token.type != token_type
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
				result = result * factor()
				eat(Token::MUL)
			when Token::DIV
				result = result / factor()
				eat(Token::DIV)
			end
		end
	end

	def factor
		token = @current_token
		eat(Token::INTEGER)
		token.value
	end

	# Throws syntax error
	def error
		raise "Unknown syntax Exception"
	end
end