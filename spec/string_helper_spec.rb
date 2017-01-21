require_relative "../lib/lexer.rb"

describe String do
	describe ".is_digit?" do 
		context "When digit is given" do
			it "Should return true if a digit 5 is given" do
				expect("5".is_digit?).to eql(true)
			end
			it "Should return true if a 11223 digit is given" do
				expect("11223".is_digit?).to eql(true)
			end
			it "Should return false if a character is given" do
				expect("a".is_digit?).to eql(false)
			end
			it "Should return false if a string is given" do
				expect("a123".is_digit?).to eql(false);
			end
		end
	end
end