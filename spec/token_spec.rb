require_relative "../lib/token"
describe Token do
	describe 'Token.new' do
		context 'Given Token::INTEGER, 5' do
			it "Creates a new token with given values" do
				t = Token.new(Token::INTEGER, 5)
				expect(t.value).to eql(5)
				expect(t.type).to eql(Token::INTEGER)
			end
		end

		context 'Given Token::EOF, nil' do
			it "Creates a new token with given values" do
				t = Token.new(Token::EOF, nil)
				expect(t.value).to eql(nil)
				expect(t.type).to eql(Token::EOF)
			end
		end
	end
end