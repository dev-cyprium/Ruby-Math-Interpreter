require_relative '../lib/parser'

describe Parser do
	describe '.parse' do
		context 'Given a single value n' do
			it 'Creates a single value 1' do
				root = Parser.new( Lexer.new('1') ).parse
				expect(root.value).to eql(1)
			end
			it 'Creates a single value 2' do
				root = Parser.new( Lexer.new('2') ).parse
				expect(root.value).to eql(2)
			end
		end

		context 'Given a single operator' do
			it 'Creates a tree of expression 2 + 3' do
				root = Parser.new( Lexer.new('2 + 3') ).parse
				expect(root.op.value).to eql('+')
				expect(root.left.value).to eql(2)
				expect(root.right.value).to eql(3)
			end
			it 'Creates a tree of expression 0 - 3' do
				root = Parser.new( Lexer.new('0 - 3') ).parse
				expect(root.op.value).to eql('-')
				expect(root.left.value).to eql(0)
				expect(root.right.value).to eql(3)
			end
			it 'Creates a tree of expression 3 / 1' do
				root = Parser.new( Lexer.new('3 / 1') ).parse
				expect(root.op.value).to eql('/')
				expect(root.left.value).to eql(3)
				expect(root.right.value).to eql(1)
			end
			it 'Creates a tree of expression 3 * 2' do
				root = Parser.new( Lexer.new('3 * 2') ).parse
				expect(root.op.value).to eql('*')
				expect(root.left.value).to eql(3)
				expect(root.right.value).to eql(2)
			end
		end

		context 'Given a math expression with priority' do
			it 'Creates a tree of expression 3 + 2 * 1' do
				root = Parser.new( Lexer.new('3 + 2 * 1') ).parse
				expect(root.op.value).to eql('+')
				expect(root.left.value).to eql(3)
				expect(root.right.op.value).to eql('*')
				expect(root.right.left.value).to eql(2)
				expect(root.right.right.value).to eql(1)
			end

			it 'Creates a tree of expression 3 * 1 + 2' do
				root = Parser.new( Lexer.new('3 * 1 + 2') ).parse
				expect(root.op.value).to eql('+')
				expect(root.left.op.value).to eql('*')
				expect(root.left.left.value).to eql(3)
				expect(root.left.right.value).to eql(1)
				expect(root.right.value).to eql(2)
			end
		end

		context 'Given a math expression with parentesies' do
			it 'Creates a tree of expression 3 * ( 2 +  1 )' do
				root = Parser.new( Lexer.new('3 * ( 2 + 1 )') ).parse
				expect(root.op.value).to eql('*')
				expect(root.left.value).to eql(3)
				expect(root.right.op.value).to eql('+')
				expect(root.right.left.value).to eql(2)
				expect(root.right.right.value).to eql(1)
			end
		end
	end
end