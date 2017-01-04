require_relative '../lib/parser'

describe Parser do
	describe '.parse' do
		context 'Given a single value n' do
			it 'Creates a single value 1' do
				root = Parser.new( Lexer.new('2') ).parse
				expect(root.value).to eql(1)
			end
			it 'Creates a single value 2' do
				root = Parser.new( Lexer.new('2') ).parse
				expect(root.value).to eql(2)
			end
		end
	end
end