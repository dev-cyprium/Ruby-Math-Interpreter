require_relative "token"
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
				skip_whitespace
				next
			end

			# Numeric tokekn
			return Token.new(Token::INTEGER, integer) if @current_char.is_digit? 

			# Operation cases
			# Advance the current character, and generate a token
			case @current_char
			when '+'
				advance
				return Token.new(Token::PLUS, '+')
			when '-'
				advance
				return Token.new(Token::MINUS, '-')
			when '*'
				advance
				return Token.new(Token::MUL, '*')
			when "/"
				advance
				return Token.new(Token::DIV, "/")
			end

			# No match found, raise an error
			error
		end
		# End of file is reached, token should be EOF
		return Token.new(Token::EOF, nil)
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
			advance
		end
		result.to_i
	end

	def skip_whitespace
		while not(@current_char == nil) and @current_char.is_space?
			advance
		end
	end

	# Unknown token error
	def error
		raise "Unknown token exception"
	end
end