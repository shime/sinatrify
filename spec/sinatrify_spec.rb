require 'spec_helper'

describe Sinatrify do
  describe Sinatrify::DSL do
    context "injecting internal router when included" do
      it "should have the sinatrify_router in a class" do
        Base.respond_to?(:sinatrify_router).should be_true
      end
      it "should have the sinatrify_router in a instance" do
        Base.new.respond_to?(:sinatrify_router).should be_true
      end
      it "should set the internal router to new route set" do
        Base.new.sinatrify_router.class.should == ActionDispatch::Routing::RouteSet
      end
    end

    context "class methods" do
      describe "#call" do
        before do
          Base.sinatrify_router = MockRouter.new
        end
        it "should forward the call to router" do
          Base.call("phone").should == "called with phone"
        end
        after do
          Base.sinatrify_router = ActionDispatch::Routing::RouteSet.new
        end
      end

      describe "#mapper" do
        it "should memoize new mapper giving the router" do
          Base.instance_variable_set(:@mapper, "mapper")
          Base.mapper.should == "mapper"
          Base.send(:remove_instance_variable,:@mapper)
        end

        it "should use the AD mapper" do
          Base.mapper.class.should == ActionDispatch::Routing::Mapper
        end
      end

      describe "HTTP verbs" do
        it "should define methods for each of the standard HTTP verbs" do
          %w(get post put delete patch).each do |verb|
            Base.respond_to?(verb)
          end
        end

        it "define action when called" do
          Base.instance_eval do
            def define_action(*args,&blk)
              "called with #{args.first}"
            end
          end
          Base.get("/").should == "called with get"
        end
      end
    end
  end
end
