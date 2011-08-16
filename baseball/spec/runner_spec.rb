# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), 'spec_helper')

describe Runner do
  before do
    @team = Team.new "team1"
  end

  describe "#new" do
    it "raise ArgumentError when argument is nil" do
      lambda {
        Runner.new
      }.should raise_error(ArgumentError)
    end

    it "not raise ArgumentError when argument is Team" do
      lambda {
        Runner.new @team
      }.should_not raise_error(ArgumentError)
    end

    it "raise ArgumentError when argument is not Team" do
      lambda {
        Runner.new "d"
      }.should raise_error(ArgumentError)
    end
  end

  describe "#team" do
    it "should eqauls initialize argument" do
      Runner.new(@team).team.should == @team
    end
  end
end
