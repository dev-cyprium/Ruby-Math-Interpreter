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

	
end