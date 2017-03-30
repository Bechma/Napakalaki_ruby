# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "cultist"
require_relative "player"

module NapakalakiGame
  class CultistPlayer < Player
    @@total_cultist_players = 0
    
    def initialize(p, c)
      @name = p.name
      @level = p.level
      @dead = p.dead
      @can_i_steal = p.canISteal
      @enemy = p.enemy.clone
      @hidden_treasures = p.hidden_treasures.clone
      @visible_treasures = p.visible_treasures.clone
      @pending_bad_consequence = p.pending_bad_consequence.clone
      @my_cultist_card = c
    end
    
    def self.total_cultist_players
      @@total_cultist_players
    end
    
    protected
    def shouldConvert
      false
    end
    
    def combat_level
      (1.2*super + @my_cultist_card.gained_levels*@@total_cultist_players).to_i
    end
    
    def opponent_level(m)
      m.level_change_against_cultist
    end
    
    private
    def giveMeATreasure
      @visible_treasures[(rand @visible_treasures.size)]
    end
    
    def canYouGiveMeATreasure
      return @visible_treasures.size > 0
    end
  end
end
