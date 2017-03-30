# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "bad_consequence"
require_relative "prize"
module NapakalakiGame

class Monster
  attr_reader :name, :combat_level, :bc
  
  def initialize (name, combat_level, prize, bc)
    @name = name
    @combat_level = combat_level
    @prize = prize
    @bc = bc
  end
  
  def getLevelsGained
    @prize.level
  end
  
  def getTreasuresGained
    @prize.treasures
  end
  
  def to_s
    "\nNombre = #{@name} \nNivel combate = #{@combat_level} \nPremio:\n #{@prize.to_s} \nMal royo:\n #{@bc.to_s}"
  end
end
end