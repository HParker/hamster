require "spec_helper"
require "hamster/hash"

describe Hamster::Hash do
  describe ".new" do
    it "is amenable to overriding of #initialize" do
      class SnazzyHash < Hamster::Hash
        def initialize
          super({'snazzy?' => 'oh yeah'})
        end
      end

      hash = SnazzyHash.new
      hash['snazzy?'].should == 'oh yeah'
    end

    context "from a subclass" do
      it "returns a frozen instance of the subclass" do
        subclass = Class.new(Hamster::Hash)
        instance = subclass.new("some" => "values")
        instance.class.should be(subclass)
        instance.frozen?.should be true
      end
    end

    it "accepts an array as initializer" do
      Hamster::Hash.new([['a', 'b'], ['c', 'd']]).should eql(Hamster.hash('a' => 'b', 'c' => 'd'))
    end
  end

  describe ".[]" do
    it "accepts a Ruby Hash as initializer" do
      hash = Hamster::Hash[a: 1, b: 2]
      hash.class.should be(Hamster::Hash)
      hash.size.should == 2
      hash.key?(:a).should == true
      hash.key?(:b).should == true
    end

    it "accepts a Hamster::Hash as initializer" do
      hash = Hamster::Hash[Hamster.hash(a: 1, b: 2)]
      hash.class.should be(Hamster::Hash)
      hash.size.should == 2
      hash.key?(:a).should == true
      hash.key?(:b).should == true
    end

    it "accepts an array as initializer" do
      hash = Hamster::Hash[[[:a, 1], [:b, 2]]]
      hash.class.should be(Hamster::Hash)
      hash.size.should == 2
      hash.key?(:a).should == true
      hash.key?(:b).should == true
    end

    it "can be used with a subclass of Hamster::Hash" do
      subclass = Class.new(Hamster::Hash)
      instance = subclass[a: 1, b: 2]
      instance.class.should be(subclass)
      instance.size.should == 2
      instance.key?(:a).should == true
      instance.key?(:b).should == true
    end
  end
end