require_relative "../lib/interpreter"
require_relative "../lib/lexer"

describe Interpreter do
	describe '.expr' do
		it "Evaluates single values to themselfs" do
			lexer = Lexer.new("1")
			inter = Interpreter.new( lexer )
			expect(inter.expr).to eql(1)
		end

		context "Given an expression a + b + c + ..." do
			it "Evaluates 1 + 2 + 3" do
				lexer = Lexer.new("1 + 2 + 3")
				inter = Interpreter.new( lexer )
				expect(inter.expr).to eql(6)
			end
			it "Evaluates 10 + 200" do
				lexer = Lexer.new("10 + 200")
				inter = Interpreter.new( lexer )
				expect(inter.expr).to eql(210)
			end
		end

		context "Given an expression a - b - c - ..." do
			it "Evaluates 1 - 2 - 3" do
				lexer = Lexer.new("1 - 2 - 3")
				inter = Interpreter.new( lexer )
				expect(inter.expr).to eql(-4)
			end

			it "Evaluates 200 - 10" do
				lexer = Lexer.new("200 - 10")
				inter = Interpreter.new( lexer )
				expect(inter.expr).to eql(190)
			end

		end

		context "Given an expression a * b * c * ..." do
				it "Evaluates 1 * 2 * 3" do
					lexer = Lexer.new("1 * 2 * 3")
					inter = Interpreter.new( lexer )
					expect(inter.expr).to eql(6)
				end			

				it "Evaluates 200 * 10" do
				lexer = Lexer.new("200 * 10")
				inter = Interpreter.new( lexer )
				expect(inter.expr).to eql(2000)
			end
		end

		context "Given an expression a / b / c / ..." do
					it "Evaluates 12 / 4 / 3" do
						lexer = Lexer.new("12 / 4 / 3")
						inter = Interpreter.new( lexer )
						expect(inter.expr).to eql(1)
					end			

					it "Evaluates 200 / 10" do
					lexer = Lexer.new("200 / 10")
					inter = Interpreter.new( lexer )
					expect(inter.expr).to eql(20)
				end
			end		
			context "Given an expression a * b + c" do
					it "Evaluates 2 * 10 + 5 " do
						lexer = Lexer.new("2 * 10 + 5")
						inter = Interpreter.new( lexer )
						expect(inter.expr).to eql(25)
					end			

					it "Evaluates 5 + 2 * 10" do
					lexer = Lexer.new("5 + 2 * 10")
					inter = Interpreter.new( lexer )
					expect(inter.expr).to eql(25)
				end
			end

			context "Given a complex expression" do
				it "Evaulates 2 * 10 / 5 + 3 * 10 - 2 + 5" do
					lexer = Lexer.new("2 * 10 / 5 + 3 * 10 - 2 + 5")
					inter = Interpreter.new( lexer )
					expect(inter.expr).to eql(37)
				end
			end

			context "Given an expression with parentecies" do
				it "Evaluates 2 * (3 + 1)" do
					lexer = Lexer.new("2 * (3+1)")
					inter = Interpreter.new( lexer )
					expect(inter.expr).to eql(8)
				end
			end

			context "Given an Error" do
				it "Throws an Error on expression 2 +" do
					lexer = Lexer.new("2 +")
					inter = Interpreter.new( lexer )
					expect{inter.expr}.to raise_error("Unknown syntax Exception")
				end

				it "Throws an Error on expression + 2 3" do
					lexer = Lexer.new("+ 2  3")
					inter = Interpreter.new( lexer )
					expect{inter.expr}.to raise_error("Unknown syntax Exception")
				end

				it "Throws an Error on expression 2 3 4" do
					lexer = Lexer.new("+ 2  3")
					inter = Interpreter.new( lexer )
					expect{inter.expr}.to raise_error("Unknown syntax Exception")
				end

				it "Throws an Error on expression 2 ( 3" do
					lexer = Lexer.new("2 ( 3")
					inter = Interpreter.new( lexer )
					expect{inter.expr}.to raise_error("Unknown syntax Exception")
				end

				it "Throws an Error on extra bracket 2 * ( 3 + 2 )) + 2" do
					lexer = Lexer.new("2 * (3 + 2))")
					inter = Interpreter.new( lexer )
					expect{inter.expr}.to raise_error("Unknown syntax Exception")
				end

				it "Throws an Error on non-closing bracket 2 * ( 3 + 2 * ( 3 + 2 )" do
					lexer = Lexer.new("2 * ( 3 + 2 * ( 3 + 2 )")
					inter = Interpreter.new ( lexer )
					expect{inter.expr}.to raise_error("Unknown syntax Exception")
				end
			end
		end
end