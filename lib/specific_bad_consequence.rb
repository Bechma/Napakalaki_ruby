# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "bad_consequence"

module NapakalakiGame
  class SpecificBadConsequence < BadConsequence
    attr_reader :specific_hidden_treasures, :specific_visible_treasures
    
    def initialize(text, level, someSpecificVisibleTreasures, someSpecificHiddenTreasures)
      super(text, level)
      @specific_visible_treasures = someSpecificVisibleTreasures
      @specific_hidden_treasures = someSpecificHiddenTreasures
    end
    
    def isEmpty
      @specific_hidden_treasures.size() == 0 && @specific_visible_treasures.size() == 0
    end
    
    def substractVisibleTreasure(t)
      @specific_visible_treasures.delete(t.type)
    end
    
    def substractHiddenTreasure(t)
      @specific_hidden_treasures.delete(t.type)
    end
    
    def adjustToFitTreasureLists(v, h)
      aux_visible = Array.new 
      aux_hidden = Array.new
      
      v.each do |i|
        if @specific_visible_treasures.include?(i.type) and @specific_visible_treasures.count(i.type) >= aux_visible.count(i.type)
          aux_visible << i.type
        end
      end

      h.each do |i|
        if @specific_hidden_treasures.include?(i.type) and @specific_hidden_treasures.count(i.type) >= aux_hidden.count(i.type)
          aux_hidden << i.type
        end
      end


      devolver = SpecificBadConsequence.new(@text, @level, aux_visible, aux_hidden)
      
      devolver
    end
    
    def to_s
      "\"#{@text}\"
      Niveles perdidos: #{@level}
      Se pierde equipo visible: #{@specific_visible_treasures}
      Se pierde equipo oculto: #{@specific_hidden_treasures}"
    end
    
  end
end
