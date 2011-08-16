# -*- coding: utf-8 -*-
require "/home/admin/code/oop_traning/baseball/src/team.rb"

class Runner
  def initialize(attache_team)
    raise ArgumentError if attache_team.class != Team
    @team = attache_team
  end

  attr_reader :team
end
