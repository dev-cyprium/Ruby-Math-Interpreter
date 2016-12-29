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

		else

		end
	end

	# Throws syntax error
	def error
		raise "Unknown syntax Exception"
	end
end