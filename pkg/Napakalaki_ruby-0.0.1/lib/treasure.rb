# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "treasure_kind"
module NapakalakiGame

class Treasure
  attr_reader :name, :bonus, :type
  
  def initialize(n,bonuss,t)
    @name = n
    @bonus = bonuss
    @type = t
  end
  
  def to_s()
    "Tesoro: #{@name} , Bonus: #{@bonus} , Tipo: #{@type}\n"
  end
end
end