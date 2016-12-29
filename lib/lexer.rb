#
# Class used to tokenize the string intro token stream
#
class Lexer
	# The lexer needs a referance to an input text
	def initialize(text)
		@text = text
		@pos = 0
		@current_char = text[0]
	end

	def get_next_token

	end

	private
	# Moves the pointer to the next character
	def advance
		@pos += 1
		if @pos > @text.length - 1
			@current_char = nil
		else
			@current_char = @text[@pos]
		end
	end

	def error
		raise "Unknown token exception"
	end
end