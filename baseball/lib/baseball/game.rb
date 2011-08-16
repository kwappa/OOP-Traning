# -*- coding: utf-8 -*-
class Game
  def initialize
    @inning = 0
    @started = false
  end

  attr_reader :started
  attr_reader :team1_score
  attr_reader :team2_score
  attr_reader :attack_team
  attr_reader :out_count
  attr_reader :first_base
  attr_reader :second_base
  attr_reader :third_base
  attr_reader :inning
  attr_reader :now_inning

  def start(game_inning)
    raise InvalidOperationError if @started
    @inning = game_inning
    @started = true
    @team1 = Team.new "team1"
    @team2 = Team.new "team2"
    @attack_team = @team1
    @team1_score = 0
    @team2_score = 0
    @first_base = nil
    @second_base = nil
    @third_base = nil
    @out_count = 0
    @now_inning = 0
  end

  def action(event)
    if @started
      case event
      when "HIT"
        hit
        true
      when "HOMERUN"
        homerun
        true
      when "OUT"
        out
        true
      else
        false
      end
    else
      false
    end
  end

  def get_attack_team_score
    if @attack_team == @team1
      @team1_score
    else
      @team2_score
    end
  end

  def hit
    if @third_base
      add_score 1
    end
    if @second_base
      @third_base = @second_base
    end
    if @first_base
      @second_base = @first_base
    end
    @first_base = attack_team.new_runner
  end
  private :hit

  def homerun
    score = 1
    if @first_base
      score += 1
    end
    if @second_base
      score += 1
    end
    if @third_base
      score += 1
    end

    @first_base = nil
    @second_base = nil
    @third_base = nil

    add_score score
  end
  private :homerun

  def out
    @out_count += 1
    if @out_count >= 3
      if @attack_team == @team1
        @attack_team = @team2
      else
        @attack_team = @team1
        @now_inning += 1
      end
      @out_count = 0
    end
    if @now_inning == @inning
      @started = false
    end
  end
  private :out

  def add_score score
    if @attack_team == @team1
      @team1_score += score
    else
      @team2_score += score
    end
  end
  private :add_score
end
