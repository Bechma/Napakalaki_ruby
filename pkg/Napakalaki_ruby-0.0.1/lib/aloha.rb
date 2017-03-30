# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class Aloha
  @@max = 3
  
  def initialize
    @@max = 3
  end
  
  def self.max
    @@max
  end
end

p Aloha.max