# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "bad_consequence"

module NapakalakiGame
  class NumericBadConsequence < BadConsequence
    attr_reader :n_visible_treasures, :n_hidden_treasures
    
    def initialize(text, level, someVisibleTreasures, someHiddenTreasures)
      super(text, level)
      @n_visible_treasures = someVisibleTreasures
      @n_hidden_treasures = someHiddenTreasures
    end
    
    def isEmpty
      @n_visible_treasures == 0 && @n_hidden_treasures == 0
    end
    
    def substractVisibleTreasure(t)
      @n_visible_treasures-=1 if (@n_visible_treasures > 0)
    end
    
    def substractHiddenTreasure(t)
      @n_hidden_treasures-=1 if (@n_hidden_treasures > 0)
    end
    
    def adjustToFitTreasureLists(v, h)
      devolver = nil
      visible_treasures = 0
      hidden_treasures = 0

      visible_treasures = v.size if @n_visible_treasures > v.size
      hidden_treasures = h.size if @n_hidden_treasures > h.size
      devolver = NumericBadConsequence.new(@text, @level, visible_treasures, hidden_treasures)

      devolver
    end
    
    def to_s
      "\"#{@text}\"
      Tesoros visibles perdidos: #{@n_visible_treasures}
      Tesoros ocultos perdidos: #{@n_hidden_treasures}
      Niveles perdidos: #{@level}"
    end
    
  end
end
