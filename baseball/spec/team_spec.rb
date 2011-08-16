# -*- coding: utf-8 -*-
require "/home/admin/code/oop_traning/baseball/src/team.rb"
require "/home/admin/code/oop_traning/baseball/src/runner.rb"

describe Team do
  describe "#new" do
    it "raise ArgumentError when argument is nil" do
      lambda {
        Team.new
      }.should raise_error(ArgumentError)
    end
  end

  context "instance method" do
    before do
      @name = "team1"
      @team = Team.new @name
    end

    describe "#new_runner" do
      it "shuld be Runner" do
        @team.new_runner.class.should == Runner
      end

      it "new runner has owner team" do
        @team.new_runner.team.should == @team
      end
    end

    describe "#team_name" do
      it "should equals initialize argument" do
        @team.team_name.should == @name
      end
    end
  end
end
