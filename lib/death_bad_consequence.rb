# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "bad_consequence"
require_relative "numeric_bad_consequence"

module NapakalakiGame
  class DeathBadConsequence < NumericBadConsequence
    attr_reader :death
    
    def initialize(text, muerte)
      super(text, 0, MAXTREASURES, MAXTREASURES)
      @death = muerte
    end
    
    def isEmpty
      return true
    end
    
    def adjustToFitTreasureLists(v, h)
      devolver = DeathBadConsequence.new(@text, @death)
      
      devolver
    end
    
    def to_s
      "\"#{@text}\"
      Niveles perdidos: #{@level}
      Muerto?: #{@death}"
    end
    
  end
end
