# encoding: utf-8

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "prize"
require_relative "bad_consequence"
require_relative "monster"
require_relative "treasure_kind"

class PruebaNapakalaki
  @@monsters = Array.new
  
  def initialize
    @max_integer = (2**(0.size * 8 -2) -1)
  end
  
  def self.construir_monstruos1
    #1
    prize = Prize.new(2,1)
    bc = BadConsequence.newLevelSpecificTreasures('Pierdes tu armadura visible y otra oculta', 0, [TreasureKind::ARMOR], [TreasureKind::ARMOR])
    @@monsters << Monster.new('3 Byakhees de bonanza', 8,prize,bc)
    
    #2
    prize = Prize.new(1,1)
    bc = BadConsequence.newLevelSpecificTreasures('Embobados con el lindo primigenio te descartas de tu casco visible', 0, [TreasureKind::HELMET], 0)
    @@monsters << Monster.new('Tenochtitlan', 2, prize, bc)
    
    #3
    prize = Prize.new(1,1)
    bc = BadConsequence.newLevelSpecificTreasures('El primordial bostezo contagioso. Pierdes el calzado visible', 0, [TreasureKind::SHOES], 0)
    @@monsters << Monster.new('El sopor de Dunwich', 2, prize, bc)
    
    #4
    prize = Prize.new(4,1)
    bc = BadConsequence.newLevelSpecificTreasures('Te atrapan para llevarte de fiesta y te dejan caer en mitad del vuelo. Descarta 1 mano visible y 1 mano oculta', 0, [TreasureKind::ONEHAND], [TreasureKind::ONEHAND])
    @@monsters << Monster.new('Demonios de Magaluf', 2, prize, bc)
    
    #5
    prize = Prize.new(3,1)
    bc = BadConsequence.newLevelNumberOfTreasures('Pierdes todos tus tesoros visibles', 0, @max_integer, 0)
    @@monsters << Monster.new('El gorrón en el umbral', 13, prize, bc)
    
    #6
    prize = Prize.new(2,1)
    bc = BadConsequence.newLevelSpecificTreasures('Pierdes la armadura visible', 0, [TreasureKind::ARMOR], 0)
    @@monsters << Monster.new('H.P. Munchcraft', 6, prize, bc)
    
    #7
    prize = Prize.new(1,1)
    bc = BadConsequence.newLevelSpecificTreasures('Sientes bichos bajo la ropa. Descarta la armadura visible', 0, [TreasureKind::ARMOR], 0)
    @@monsters << Monster.new('Necrófago', 13, prize, bc)
    
    #8
    prize = Prize.new(3,2)
    bc = BadConsequence.newLevelNumberOfTreasures('Pierdes 5 niveles y 3 tesoros visibles', 0, 5, 3)
    @@monsters << Monster.new('El rey de rosado', 11, prize, bc)
    
    #9
    prize = Prize.new(1,1)
    bc = BadConsequence.newLevelSpecificTreasures('Toses los pulmones y pierdes 2 niveles', 2, 0, 0)
    @@monsters << Monster.new('Flecher', 2, prize, bc)
    
  end
  
  def self.construir_monstruos2
    # 10
  prize = Prize.new(2,1)
  badConsequence = BadConsequence.newDeath(
    "Estos monstruos resultan bastante superficiales y te aburren mortalmente. Estás muerto")
  @@monsters << Monster.new( "Los hondos", 8, prize, badConsequence )
  
  # 11
  prize = Prize.new(2,1)
  badConsequence = BadConsequence.newLevelSpecificTreasures(
    "Pierdes 2 niveles y 2 tesoros ocultos.", 2, 0, 2 )
  @@monsters << Monster.new( "Semillas Cthulhu", 4, prize, badConsequence )
  
  # 12
  prize = Prize.new(2,1)
  badConsequence = BadConsequence.newLevelNumberOfTreasures(
    "Te intentas escaquear. Pierdes 1 tesoro a una mano visible", 0, 1, 0 )
  @@monsters << Monster.new( "Nuevo3", 1, prize, badConsequence )
  
  # 13
  prize = Prize.new(2,1)
  badConsequence = BadConsequence.newLevelNumberOfTreasures(
    "Da mucho asquito. Pierdes 3 niveles.", 3, 0 ,0 )
  @@monsters << Monster.new( "Pollipólipo volante", 3, prize, badConsequence )
  
  # 14
  prize = Prize.new(3,1)
  badConsequence = BadConsequence.newDeath(
    "No le hace gracia que pronuncien mal su nombre. Estás muerto.")
  @@monsters << Monster.new( "Yskhtihyssg-Goth", 14, prize, badConsequence )
  
  # 15
  prize = Prize.new(3,1)
  badConsequence = BadConsequence.newDeath(
    "La familia te atrapa. Estás muerto.")
  @@monsters << Monster.new( "Familia feliz", 1, prize, badConsequence )
  
  # 16
  prize = Prize.new(2,1)
  badConsequence = BadConsequence.newLevelNumberOfTreasures(
    "La quinta directiva primaria te obliga a perder 2 niveles y 1 tesoro a dos manos visible.",
    2, 1, 0 )
  @@monsters << Monster.new( "Robbogoth", 8, prize, badConsequence )
  
  # 17
  prize = Prize.new(1,1)
  badConsequence = BadConsequence.newLevelSpecificTreasures(
    "Te asusta en la noche. Pierdes 1 casco visible.", 0, [TreasureKind::HELMET], 0 )
  @@monsters << Monster.new( "El espía sordo", 5, prize, badConsequence )
  
  # 18
  prize = Prize.new(2,1)
  badConsequence = BadConsequence.newLevelNumberOfTreasures(
    "Menudo susto te llevas. Pierdes 2 niveles y 5 tesoros visibles.",
    2, 5, 0 )
  @@monsters << Monster.new( "Tongue", 19, prize, badConsequence )
  
  # 19
  prize = Prize.new(2,1)
  badConsequence = BadConsequence.newLevelNumberOfTreasures(
    "Te faltan manos para tanta cabeza. Pierdes 3 niveles y tus tesoros visibles de las manos.",
    3, @max_integer, 0 )
  @@monsters << Monster.new( "Bicéfalo", 21, prize, badConsequence )
  end
  
  def combat_level_superior_10
    devuelve = Array.new 
    for m in @@monsters do
      if m.combat_level > 10 then
        devuelve << m
      end
    end
    devuelve
  end
  
  def solo_niveles
    devuelve = Array.new
    for m in @@monsters do
      if m.bc.level > 0 and m.bc.death != true and m.bc.n_visible_treasures == 0 and m.bc.n_hidden_treasures == 0 and m.bc.specific_hidden_treasures == 0 and m.bc.specific_visible_treasures == 0 then
        devuelve << m
      end
    end
    devuelve
  end
  
  self.construir_monstruos1
  self.construir_monstruos2
  
end

prueba = PruebaNapakalaki.new
aqui = prueba.combat_level_superior_10

aqui.each do |i|
  puts i.to_s
end