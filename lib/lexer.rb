#
# String helper methods used
#
class String
	def is_digit?
		self =~ /\d/
	end

	def is_space?
		self =~ /\s/
	end
end

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

	# Returns the next token in the string
	def get_next_token
		while not(@current_char == nil)
			# Skip whitespace
			if @current_char.is_space?
				self.skip_whitespace
				next
			end

			# Numeric tokekn
			return Token.new(Token::INTEGER, integer) if @current_char.is_digit? 

		end
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

	def integer
		result = ''
		while not(@current_char == nil) and @current_char.is_digit?
			result += @current_char
			self.advance
		end
		result.to_i
	end

	def skip_whitespace
		while not(@current_char == nil) and @current_char.is_space?
			self.advance
		end
	end

	# Unknown token error
	def error
		raise "Unknown token exception"
	end
end