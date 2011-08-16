# -*- coding: utf-8 -*-
class Runner
  def initialize(attache_team)
    raise ArgumentError if attache_team.class != Team
    @team = attache_team
  end

  attr_reader :team
end
