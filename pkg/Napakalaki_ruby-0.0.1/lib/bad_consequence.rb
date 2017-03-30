# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "treasure_kind"
module NapakalakiGame
class BadConsequence
  attr_reader :text, :level, :death, :n_visible_treasures, :n_hidden_treasures,
    :specific_hidden_treasures, :specific_visible_treasures
  MAXTREASURES=10

  def initialize(aText, someLevels, someVisibleTreasures, someHiddenTreasures,
      someSpecificVisibleTreasures, someSpecificHiddenTreasures, death)
    @text = aText
    @level  = someLevels
    @n_visible_treasures = someVisibleTreasures
    @n_hidden_treasures = someHiddenTreasures
    @death = death
    @specific_visible_treasures = someSpecificVisibleTreasures
    @specific_hidden_treasures = someSpecificHiddenTreasures
  end
  
  def self.newLevelNumberOfTreasures (aText, someLevels, someVisibleTreasures,
      someHiddenTreasures)
    new(aText, someLevels, someVisibleTreasures, someHiddenTreasures, [], [], false)
  end
  
  def self.newLevelSpecificTreasures (aText, someLevels, 
      someSpecificVisibleTreasures, someSpecificHiddenTreasures)
    new(aText, someLevels, 0, 0, someSpecificVisibleTreasures, someSpecificHiddenTreasures, false)
  end
  
  def self.newDeath (aText, death)
    new(aText,0,0,0,[],[],death)
  end
  
  def adjustToFitTreasureLists(v, h)
    devolver = nil
    if @n_visible_treasures > 0 or @n_hidden_treasures > 0
      visible_treasures = v.size if @n_visible_treasures > v.size
      hidden_treasures = h.size if @n_hidden_treasures > h.size
      devolver = BadConsequence.newLevelNumberOfTreasures(@text, @level, visible_treasures, hidden_treasures)
    
    elsif @death
      devolver = BadConsequence.newDeath(@text, @death)
    
    elsif @specific_visible_treasures.size > 0 or @specific_hidden_treasures.size > 0
      aux_visible = Array.new #@specific_visible_treasures.dup
      aux_hidden = Array.new #@specific_hidden_treasures.dup
      
      v.each do |i|
        if @specific_visible_treasures.include?(i.type) then aux_visible << i.type end
      end
      
      
      
      for t in h
        if @specific_hidden_treasures.include?(t.type) and @specific_hidden_treasures.count(t.type) >= aux_hidden.count(t.type)
          aux_hidden << t.type
        end
      end
      
      
      devolver = BadConsequence.newLevelSpecificTreasures(@text, @level, aux_visible, aux_hidden)
    end
    devolver
  end
  
  def substractVisibleTreasure(t)
    if (@n_visible_treasures == 0)
      @specific_visible_treasures.delete(t.type)
    elsif (@n_visible_treasures > 0)
      @n_visible_treasures-=1
    end
  end
  
  def substractHiddenTreasure(t)
    if (@n_hidden_treasures == 0)
      @specific_hidden_treasures.delete(t.type)
    elsif (@n_hidden_treasures > 0)
      @n_hidden_treasures-=1
    end
  end
  
  def isEmpty
    @n_visible_treasures == 0 && @n_hidden_treasures == 0 && @specific_hidden_treasures.size() == 0 && @specific_visible_treasures.size() == 0
  end
  
  def to_s
    "\"#{@text}\"
    Tesoros visibles perdidos: #{@n_visible_treasures}
    Tesoros ocultos perdidos: #{@n_hidden_treasures}
    Niveles perdidos: #{@level}
    Se pierde equipo visible: #{@specific_visible_treasures}
    Se pierde equipo oculto: #{@specific_hidden_treasures}
    Muerto?: #{@death}"
  end
  
  private_class_method :new
end
end
