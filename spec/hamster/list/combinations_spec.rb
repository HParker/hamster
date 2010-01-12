require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

require 'hamster/list'

describe Hamster::List do

  [:combinations, :combination].each do |method|

    describe "##{method}" do

      describe "doesn't run out of stack space on a really big" do

        it "stream" do
          @list = Hamster.interval(0, STACK_OVERFLOW_DEPTH)
        end

        it "list" do
          @list = (0...STACK_OVERFLOW_DEPTH).reduce(Hamster.list) { |list, i| list.cons(i) }
        end

        after do
          pending do
            @list.send(method, 1).take(1)
          end
        end

      end

      [
        [["A", "B", "C", "D"], 1, [["A"], ["B"], ["C"], ["D"]]],
        [["A", "B", "C", "D"], 2, [["A", "B"], ["A", "C"], ["A", "D"], ["B", "C"], ["B", "D"], ["C", "D"]]],
        [["A", "B", "C", "D"], 3, [["A", "B", "C"], ["A", "B", "D"], ["A", "C", "D"], ["B", "C", "D"]]],
        [["A", "B", "C", "D"], 4, [["A", "B", "C", "D"]]],
        [["A", "B", "C", "D"], 0, [[]]],
        [["A", "B", "C", "D"], 5, []],
        [[], 0, [[]]],
        [[], 1, []],
      ].each do |values, number, expected|

        expected = expected.map { |x| Hamster.list(*x) }

        describe "on #{values.inspect} in groups of #{number}" do

          before do
            @original = Hamster.list(*values)
            @result = @original.send(method, number)
          end

          it "preserves the original" do
            @original.should == Hamster.list(*values)
          end

          it "returns #{expected.inspect}" do
            pending do
              @result.should == Hamster.list(*expected)
            end
          end

        end

      end

    end

  end

end
