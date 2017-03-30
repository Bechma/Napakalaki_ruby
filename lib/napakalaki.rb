# encoding: utf-8

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.


require_relative "monster"
require_relative "card_dealer"
require_relative "combat_result"
require_relative "player"
require_relative "cultist"
require_relative "cultist_player"
require "singleton"
module NapakalakiGame

class Napakalaki
  include Singleton
  attr_reader :current_player, :current_monster
  
  def initialize
    @current_player = nil
    @players = Array.new
    @dealer = CardDealer.instance
    @current_monster = nil
  end
  
  def developCombat
    dev = @current_player.combat(@current_monster)
    @dealer.giveMonsterBack(@current_monster)
    c = nil
    
    if dev == CombatResult::LOSEANDCONVERT
      c = CultistPlayer.new(@current_player, @dealer.nextCultist)
      
      i=0
      while ( i < @players.size)
        if @players[i].enemy == @current_player
          @players[i].enemy = c
        end
        if @players[i] == @current_player
          @players[i] = c
        end
        i+=1
      end
      
      @current_player = c
      
    end
    
    dev
  end
  
  def discardVisibleTreasures(treasures)
    treasures.each do |t|
      @current_player.discardVisibleTreasure(t)
      @dealer.giveTreasureBack(t)
    end
  end
  
  def discardHiddenTreasures(treasures)
    treasures.each do |t|
      @current_player.discardHiddenTreasure(t)
      @dealer.giveTreasureBack(t)
    end
  end
  
  def makeTreasuresVisible(treasures)
    treasures.each do |t|
      @current_player.makeTreasureVisible(t)
    end
  end
  
  def initGame(names)
    initPlayers(names)
    setEnemies
    @dealer.initCards
    nextTurn
  end
  
  def nextTurn
    stateOK = nextTurnAllowed
    if stateOK
      @current_monster = @dealer.nextMonster
      @current_player = nextPlayer
      @current_player.initTreasures if @current_player.dead
    end
    stateOK
  end
  
  def endOfGame(result)
    result == CombatResult::WINGAME
  end
  
  def getCurrentMonster()
    @current_monster
  end
  
  def getCurrentPlayer()
    @current_player
  end
  
  private
  def initPlayers(names)
    names.each do |i|
      @players << Player.new(i)
    end
  end
  
  def nextPlayer
    if @current_player == nil
      @current_player = @players[(rand @players.size)]
    else
      for i in 0..@players.size
        if @players[i] == @current_player
          @current_player = @players[(i+1)%@players.size]
          break
        end
      end
    end
    @current_player
  end
  
  def nextTurnAllowed
    if @current_player == nil 
      return true
    end
    @current_player.validState
  end
  
  def setEnemies
    i = 0
    until i == @players.size
      num = (rand @players.size)
      if num != i
        @players[i].enemy = @players[num]
        i+=1
      end
    end
  end
  
  
  
end
end