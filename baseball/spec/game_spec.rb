# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), 'spec_helper')

describe Game do
  before do
    @game = Game.new
  end

  context "before start" do
    describe "#start" do
      it "should be true" do
        @game.start(1).should be_true
      end
    end

    describe "#attack_team" do
      it "should be nil" do
        @game.attack_team.should be_nil
      end
    end

    describe "#action" do
      it "should be false" do
        @game.action("HIT").should be_false
      end
    end

    describe "#started" do
      it "should be false" do
        @game.started.should be_false
      end
    end
  end

  context "after start" do
    before do
      @inning = 2
      @game.start @inning
    end

    context "first start"do
      describe "#out_count" do
        it "should be 0" do
          @game.out_count.should == 0
        end
      end

      describe "#first_base" do
        it "should be nil" do
          @game.first_base.should be_nil
        end
      end

      describe "#second_base" do
        it "should be nil" do
          @game.second_base.should be_nil
        end
      end

      describe "#third_base" do
        it "should be nil" do
          @game.third_base.should be_nil
        end
      end

      describe "#team1_score" do
        it "should be 0" do
          @game.team1_score.should == 0
        end
      end

      describe "#team2_score" do
        it "should be 0" do
          @game.team2_score.should == 0
        end
      end

      describe "#now_inning" do
        it "should be 0" do
          @game.now_inning.should == 0
        end
      end

      describe "#inning" do
        it "should be start argument" do
          @game.inning.should == @inning
        end
      end
    end

    context "next start"do
      before do
        (@inning * 2).times { |i|
          @game.action("HOMERUN")
          @game.action("OUT")
          @game.action("OUT")
          @game.action("OUT")
        }
        @game.start @inning
      end

      describe "#out_count" do
        it "should be 0" do
          @game.out_count.should == 0
        end
      end

      describe "#first_base" do
        it "should be nil" do
          @game.first_base.should be_nil
        end
      end

      describe "#second_base" do
        it "should be nil" do
          @game.second_base.should be_nil
        end
      end

      describe "#third_base" do
        it "should be nil" do
          @game.third_base.should be_nil
        end
      end

      describe "#team1_score" do
        it "should be 0" do
          @game.team1_score.should == 0
        end
      end

      describe "#team2_score" do
        it "should be 0" do
          @game.team2_score.should == 0
        end
      end

      describe "#now_inning" do
        it "should be 0" do
          @game.now_inning.should == 0
        end
      end

      describe "#inning" do
        it "should be start argument" do
          @game.inning.should == @inning
        end
      end
    end

    describe "#start" do
      it "raise InvalidOperationError" do
        lambda {
          @game.start 1
        }.should raise_error(InvalidOperationError)
      end
    end

    describe "#attack_team" do
      it "should not be nil" do
        @game.attack_team.should_not be_nil
      end
    end

    describe "#action" do
      describe "event: HIT" do
        it "should be true at hit" do
          @game.action("HIT").should be_true
        end

        it "should not nil first_base at attack team is 1 hit" do
          @game.action("HIT")

          @game.first_base.should_not be_nil
        end

        it "should eqauls first_base runner is move on second_base at hit" do
          @game.action("HIT")
          runner = @game.first_base
          @game.action("HIT")

          @game.second_base.should == runner
        end

        it "should eqauls first_base runner is move on third_base at 2 hit" do
          @game.action("HIT")
          runner = @game.first_base
          @game.action("HIT")
          @game.action("HIT")

          @game.third_base.should == runner
        end

        it "should add score at attack team is 4 hit" do
          @game.action("HIT")
          @game.action("HIT")
          @game.action("HIT")
          @game.action("HIT")

          @game.get_attack_team_score.should == 1
        end
      end

      describe "event: HOMERUN" do
        it "should be true at home run" do
          @game.action("HOMERUN").should be_true
        end

        it "should add 1 score at attack team when no hit" do
          @game.action("HOMERUN")

          @game.get_attack_team_score.should == 1
        end

        it "should add 2 score at attack team when one hit" do
          @game.action("HIT")
          @game.action("HOMERUN")

          @game.get_attack_team_score.should == 2
        end

        it "should add 3 score at attack team when two hit" do
          @game.action("HIT")
          @game.action("HIT")
          @game.action("HOMERUN")

          @game.get_attack_team_score.should == 3
        end

        it "should add 4 score at attack team when three hit" do
          @game.action("HIT")
          @game.action("HIT")
          @game.action("HIT")
          @game.action("HOMERUN")

          @game.get_attack_team_score.should == 4
        end

        it "should be nil all baseafter homerun" do
          @game.action("HIT")
          @game.action("HIT")
          @game.action("HIT")
          @game.action("HOMERUN")

          @game.first_base.should be_nil
          @game.second_base.should be_nil
          @game.third_base.should be_nil
        end
      end

      describe "event: OUT" do
        it "should be true at out" do
          @game.action("OUT").should be_true
        end

        it "should add out count" do
          @game.action("OUT")

          @game.out_count.should == 1
        end

        it "should change attack team at 3 out" do
          attack_team = @game.attack_team
          @game.action("OUT")
          @game.action("OUT")
          @game.action("OUT")

          @game.attack_team.should_not == attack_team

          @game.action("OUT")
          @game.action("OUT")
          @game.action("OUT")

          @game.attack_team.should == attack_team
        end

        it "should add now_inning at loop attack team" do
          @game.action("OUT")
          @game.action("OUT")
          @game.action("OUT")
          @game.action("OUT")
          @game.action("OUT")
          @game.action("OUT")

          @game.now_inning.should == 1
        end

        it "should be false started at now_inning eqauls game inning" do
          (@inning * 2).times { |i|
            @game.action("OUT")
            @game.action("OUT")
            @game.action("OUT")
          }

          @game.started.should be_false
        end
      end

      it "should be false other event" do
        @game.action("ERROR").should be_false
      end
    end
  end
end
