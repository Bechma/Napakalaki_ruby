# encoding: UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require "singleton"
require_relative "monster"
require_relative "treasure"
module NapakalakiGame

class CardDealer
  include Singleton
  
  def initialize
    @unused_monsters = Array.new
    @used_monsters = Array.new
    @unused_treasures = Array.new
    @used_treasures = Array.new
  end
  
  
  def nextTreasure
    if @unused_treasures.empty?
      @unused_treasures.concat @used_treasures
      shuffleTreasures
      @used_treasures.clear
    end
    m = @unused_treasures[0]
    @unused_treasures.delete(m)
    m
  end
  
  def nextMonster
    if @unused_monsters.empty?
      @unused_monsters.concat @used_monsters
      shuffleMonsters
      @used_monsters.clear
    end
    m = @unused_monsters[0]
    @unused_monsters.delete(m)
    m
  end
  
  def giveTreasureBack(t)
    @used_treasures << t
  end
  
  def giveMonsterBack(m)
    @used_monsters << m
  end
  
  def initCards
    initMonsterCardDeck
    initTreasureCardDeck
    shuffleMonsters
    shuffleTreasures
  end
  
  
  private
  def initMonsterCardDeck
    #1
    prize = Prize.new(2,1)
    bc = BadConsequence.newLevelSpecificTreasures('Pierdes tu armadura visible y otra oculta', 0, [TreasureKind::ARMOR], [TreasureKind::ARMOR])
    @unused_monsters << Monster.new('3 Byakhees de bonanza', 8,prize,bc)
    
    #2
    prize = Prize.new(1,1)
    bc = BadConsequence.newLevelSpecificTreasures('Embobados con el lindo primigenio te descartas de tu casco visible', 0, [TreasureKind::HELMET], [])
    @unused_monsters << Monster.new('Tenochtitlan', 2, prize, bc)
    
    #3
    prize = Prize.new(1,1)
    bc = BadConsequence.newLevelSpecificTreasures('El primordial bostezo contagioso. Pierdes el calzado visible', 0, [TreasureKind::SHOE], [])
    @unused_monsters << Monster.new('El sopor de Dunwich', 2, prize, bc)
    
    #4
    prize = Prize.new(4,1)
    bc = BadConsequence.newLevelSpecificTreasures('Te atrapan para llevarte de fiesta y te dejan caer en mitad del vuelo. Descarta 1 mano visible y 1 mano oculta', 0, [TreasureKind::ONEHAND], [TreasureKind::ONEHAND])
    @unused_monsters << Monster.new('Demonios de Magaluf', 2, prize, bc)
    
    #5
    prize = Prize.new(3,1)
    bc = BadConsequence.newLevelNumberOfTreasures('Pierdes todos tus tesoros visibles', 0, BadConsequence::MAXTREASURES, [])
    @unused_monsters << Monster.new('El gorrón en el umbral', 13, prize, bc)
    
    #6
    prize = Prize.new(2,1)
    bc = BadConsequence.newLevelSpecificTreasures('Pierdes la armadura visible', 0, [TreasureKind::ARMOR], [])
    @unused_monsters << Monster.new('H.P. Munchcraft', 6, prize, bc)
    
    #7
    prize = Prize.new(1,1)
    bc = BadConsequence.newLevelSpecificTreasures('Sientes bichos bajo la ropa. Descarta la armadura visible', 0, [TreasureKind::ARMOR], [])
    @unused_monsters << Monster.new('Necrófago', 13, prize, bc)
    
    #8
    prize = Prize.new(3,2)
    bc = BadConsequence.newLevelNumberOfTreasures('Pierdes 5 niveles y 3 tesoros visibles', 5, 3, 0)
    @unused_monsters << Monster.new('El rey de rosado', 11, prize, bc)
    
    #9
    prize = Prize.new(1,1)
    bc = BadConsequence.newLevelNumberOfTreasures('Toses los pulmones y pierdes 2 niveles', 2, 0, 0)
    @unused_monsters << Monster.new('Flecher', 2, prize, bc)
    
    # 10
    prize = Prize.new(2,1)
    badConsequence = BadConsequence.newDeath(
    "Estos monstruos resultan bastante superficiales y te aburren mortalmente. Estás muerto", true)
    @unused_monsters << Monster.new( "Los hondos", 8, prize, badConsequence )
  
    # 11
    prize = Prize.new(2,1)
    badConsequence = BadConsequence.newLevelNumberOfTreasures(
    "Pierdes 2 niveles y 2 tesoros ocultos.", 2, 0, 2 )
    @unused_monsters << Monster.new( "Semillas Cthulhu", 4, prize, badConsequence )
  
    # 12
    prize = Prize.new(2,1)
    badConsequence = BadConsequence.newLevelSpecificTreasures(
    "Te intentas escaquear. Pierdes 1 tesoro a una mano visible", 0, [TreasureKind::ONEHAND], 0 )
    @unused_monsters << Monster.new( "Dameargo", 1, prize, badConsequence )
  
    # 13
    prize = Prize.new(2,1)
    badConsequence = BadConsequence.newLevelNumberOfTreasures(
    "Da mucho asquito. Pierdes 3 niveles.", 3, 0 ,0 )
    @unused_monsters << Monster.new( "Pollipólipo volante", 3, prize, badConsequence )
  
    # 14
    prize = Prize.new(3,1)
    badConsequence = BadConsequence.newDeath(
    "No le hace gracia que pronuncien mal su nombre. Estás muerto.", true)
    @unused_monsters << Monster.new( "Yskhtihyssg-Goth", 14, prize, badConsequence )
  
    # 15
    prize = Prize.new(3,1)
    badConsequence = BadConsequence.newDeath(
    "La familia te atrapa. Estás muerto.", true)
    @unused_monsters << Monster.new( "Familia feliz", 1, prize, badConsequence )
  
    # 16
    prize = Prize.new(2,1)
    badConsequence = BadConsequence.newLevelSpecificTreasures(
    "La quinta directiva primaria te obliga a perder 2 niveles y 1 tesoro a dos manos visible.",
    2, [TreasureKind::BOTHHANDS], [] )
    @unused_monsters << Monster.new( "Robbogoth", 8, prize, badConsequence )
  
    # 17
    prize = Prize.new(1,1)
    badConsequence = BadConsequence.newLevelSpecificTreasures(
    "Te asusta en la noche. Pierdes 1 casco visible.", 0, [TreasureKind::HELMET], [] )
    @unused_monsters << Monster.new( "El espía sordo", 5, prize, badConsequence )
  
    # 18
    prize = Prize.new(2,1)
    badConsequence = BadConsequence.newLevelNumberOfTreasures(
    "Menudo susto te llevas. Pierdes 2 niveles y 5 tesoros visibles.",
    2, 5, 0 )
    @unused_monsters << Monster.new( "Tongue", 19, prize, badConsequence )
  
    # 19
    prize = Prize.new(2,1)
    badConsequence = BadConsequence.newLevelSpecificTreasures(
    "Te faltan manos para tanta cabeza. Pierdes 3 niveles y tus tesoros visibles de las manos.",
    3, [TreasureKind::BOTHHANDS], [] )
    @unused_monsters << Monster.new( "Bicéfalo", 21, prize, badConsequence )
  end
  
  def initTreasureCardDeck
    @unused_treasures << Treasure.new("¡Sí, mi amo!", 4, TreasureKind::HELMET)
    @unused_treasures << Treasure.new("Botas de investigación", 3, TreasureKind::SHOE)
    @unused_treasures << Treasure.new("Capucha de Cthulhu", 3, TreasureKind::HELMET)
    @unused_treasures << Treasure.new("A prueba de babas", 2, TreasureKind::ARMOR)
    @unused_treasures << Treasure.new("Botas de lluvia ácida", 1, TreasureKind::BOTHHANDS)
    @unused_treasures << Treasure.new("Casco minero", 2, TreasureKind::HELMET)
    @unused_treasures << Treasure.new("Ametralladora ACME", 4, TreasureKind::BOTHHANDS)
    @unused_treasures << Treasure.new("Camiseta de la ETSIIT", 1, TreasureKind::ARMOR)
    @unused_treasures << Treasure.new("Clavo de raíl ferroviario", 3, TreasureKind::ONEHAND)
    @unused_treasures << Treasure.new("Cuchillo de sushi arcano", 2, TreasureKind::ONEHAND)
    @unused_treasures << Treasure.new("Fez alópodo", 3, TreasureKind::HELMET)
    @unused_treasures << Treasure.new("Hacha prehistórica", 2, TreasureKind::ONEHAND)
    @unused_treasures << Treasure.new("El aparato del Pr. Tesla", 4, TreasureKind::ARMOR)
    @unused_treasures << Treasure.new("Gaita", 4, TreasureKind::BOTHHANDS)
    @unused_treasures << Treasure.new("Insecticida", 2, TreasureKind::ONEHAND)
    @unused_treasures << Treasure.new("Escopeta de 3 cañones", 4, TreasureKind::BOTHHANDS)
    @unused_treasures << Treasure.new("Garabato místico", 2, TreasureKind::ONEHAND)
    @unused_treasures << Treasure.new("La rebeca metálica", 2, TreasureKind::ARMOR)
    @unused_treasures << Treasure.new("Lanzallamas", 4, TreasureKind::BOTHHANDS)
    @unused_treasures << Treasure.new("Necro-comicón", 1, TreasureKind::ONEHAND)
    @unused_treasures << Treasure.new("Necronomicón", 5, TreasureKind::BOTHHANDS)
    @unused_treasures << Treasure.new("Linterna a 2 manos", 3, TreasureKind::BOTHHANDS)
    @unused_treasures << Treasure.new("Necro-gnomicón", 2, TreasureKind::ONEHAND)
    @unused_treasures << Treasure.new("Necrotelecom", 2, TreasureKind::HELMET)
    @unused_treasures << Treasure.new("Mazo de los antiguos", 3, TreasureKind::ONEHAND)
    @unused_treasures << Treasure.new("Necro-playboycón", 3, TreasureKind::ONEHAND)
    @unused_treasures << Treasure.new("Porra preternatural", 2, TreasureKind::ONEHAND)
    @unused_treasures << Treasure.new("Shogulador", 1, TreasureKind::BOTHHANDS)
    @unused_treasures << Treasure.new("Varita de atizamiento", 3, TreasureKind::ONEHAND)
    @unused_treasures << Treasure.new("Tentácula de pega", 2, TreasureKind::HELMET)
    @unused_treasures << Treasure.new("Zapato deja-amigos", 1, TreasureKind::SHOE)
  end
  
  def shuffleTreasures
    @unused_treasures.shuffle!
  end
  
  def shuffleMonsters
    @unused_monsters.shuffle!
  end
  
end
end