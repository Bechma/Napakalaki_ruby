# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "treasure"
require_relative "card_dealer"
require_relative "combat_result"
require_relative "dice"
module NapakalakiGame

class Player
  attr_reader :name, :level, :dead, :can_i_steal, :hidden_treasures, :visible_treasures
  attr_writer :enemy
  MAXLEVEL = 10
  
  def initialize(nombre)
    @name = nombre
    @level = 1
    @dead = true
    @can_i_steal = true
    @enemy
    @hidden_treasures = Array.new
    @visible_treasures = Array.new
    @pending_bad_consequence
  end
  
  def canISteal
    @can_i_steal
  end
  
  def to_s
    " #{@name} nivel: #{@level}"
  end
  
  def getVisibleTreasures
    @visible_treasures
  end
  
  def getHiddenTreasures
    @hidden_treasures
  end
  
  def combat(m)
    my_level = combat_level
    monster_level = m.combat_level
    resultado = nil
    
    if @can_i_steal
      dice = Dice.instance
      number = dice.nextNumber
      if number < 3
        enemyLevel = @enemy.send :combat_level
        monster_level += enemyLevel
      end
      
      if my_level > monster_level
        applyPrize(m)
        if @level >= MAXLEVEL
          resultado = CombatResult::WINGAME
        else
          resultado = CombatResult::WIN
        end
      else
        applyBadConsequence(m)
        resultado = CombatResult::LOSE
      end
    end
    resultado
  end
  
  def makeTreasureVisible(t)
    if canMakeTreasureVisible(t)
      @visible_treasures << t
      @hidden_treasures.delete(t)
    end
  end
  
  def discardVisibleTreasure(t)
    @visible_treasures.delete(t)
    if @pending_bad_consequence != nil
      @pending_bad_consequence.substractVisibleTreasure(t) unless @pending_bad_consequence.isEmpty
    end
    dieIfNoTreasures
  end
  
  def discardHiddenTreasure(t)
    @hidden_treasures.delete(t)
    if @pending_bad_consequence != nil
      @pending_bad_consequence.substractHiddenTreasure(t) unless @pending_bad_consequence.isEmpty
    end
    dieIfNoTreasures
  end
  
  def validState
    if @pending_bad_consequence.nil?
      return @hidden_treasures.size <= 4
    end
    @pending_bad_consequence.isEmpty and @hidden_treasures.size <= 4
  end
  
  def initTreasures
    dealer = CardDealer.instance
    dice = Dice.instance
    bringToLife
    @hidden_treasures << dealer.nextTreasure
    number = dice.nextNumber
    if number > 1
      @hidden_treasures << dealer.nextTreasure
      @hidden_treasures << dealer.nextTreasure if number == 6
    end
    
  end
  
  def stealTreasure
    treasure = nil
    if @can_i_steal
      if @enemy.send :canYouGiveMeATreasure
        treasure = @enemy.send :giveMeATreasure
        @hidden_treasures << treasure
        haveStolen
      end
    end
    treasure
  end
  
  def discardAllTreasures
    h = Array.new(@hidden_treasures)
    v = Array.new(@visible_treasures)
    dealer = CardDealer.instance
    
    h.each do |t|
      dealer.giveTreasureBack(t)
      discardHiddenTreasure(t)
    end
    
    v.each do |t|
      dealer.giveTreasureBack(t)
      discardVisibleTreasure(t)
    end
    
  end
  
  
  private
  def bringToLife
    @dead = false
  end
  
  def combat_level
    devolver = @level
    
    for i in @visible_treasures do
      devolver += i.bonus
    end
    
    devolver
  end
  
  def incrementLevels(l)
    if(@level + l >= MAXLEVEL)
      @level = MAXLEVEL;
    else
      @level += l;
    end
  end
  
  def decrementLevels(l)
    if( @level - l < 1)
      @level = 1;
    else
      @level -= l;
    end
  end
  
  def applyPrize(m)
    incrementLevels(m.getLevelsGained)
    treasures = m.getTreasuresGained
    if treasures > 0
      dealer = CardDealer.instance
      for i in 1..treasures
        @hidden_treasures << dealer.nextTreasure
      end
    end
  end
  
  def applyBadConsequence(m)
    bc = m.bc
    decrementLevels(bc.level)
    pending_bad = bc.adjustToFitTreasureLists(@visible_treasures, @hidden_treasures)
    setPendingBadConsequence(pending_bad)
  end
  
  def canMakeTreasureVisible(t)
    devolver = true
    case t.type
    when TreasureKind::ARMOR, TreasureKind::HELMET, TreasureKind::SHOE
      for i in @visible_treasures
        if i.type == t.type
          devolver = false
          break
        end
      end
      devolver
      
    when TreasureKind::ONEHAND
      contador = 0;
      for x in @visible_treasures
        if x.type == t.type
          contador+=1
        elsif x.type == TreasureKind::BOTHHANDS
          contador+=BadConsequence::MAXTREASURES
        end
      end
      devolver = contador < 2
      
    when TreasureKind::BOTHHANDS
      contador = 0
      for y in @visible_treasures
        if(y.type == t.type or y.type == TreasureKind::ONEHAND)
          contador+=1
        end
      end
      devolver = contador == 0
    end
    
    devolver
  end
  
  def howManyVisibleTreasures(t)
    devolver = 0
    for i in @visible_treasures
      if i.type == t
        devolver += 1
      end
    end
    devolver
  end
  
  def dieIfNoTreasures
    @dead = true if @visible_treasures.size == 0 and @hidden_treasures.size == 0
  end
  
  def giveMeATreasure
    @hidden_treasures[(rand @hidden_treasures.size)]
  end
  
  def canYouGiveMeATreasure
    return @hidden_treasures.size > 0
  end
  
  def haveStolen
    @can_i_steal = false
  end
  
  def setPendingBadConsequence(b)
    @pending_bad_consequence = b
  end
  
end
end