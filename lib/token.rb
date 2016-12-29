# Class holding all the token information
class Token
	INTEGER = "INT"
	PLUS = "PLU"
	EOF = "EOF"

	attr_accessor :type, :value

	def initialize(type, value)
		@type = type
		@value = value
	end
end