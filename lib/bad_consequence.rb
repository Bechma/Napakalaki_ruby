# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "treasure_kind"
module NapakalakiGame
  class BadConsequence
    attr_reader :text, :level
    MAXTREASURES=10

    def initialize(aText, someLevels)
      @text = aText
      @level  = someLevels
    end

=begin
    def to_s
      "\"#{@text}\"
      Tesoros visibles perdidos: #{@n_visible_treasures}
      Tesoros ocultos perdidos: #{@n_hidden_treasures}
      Niveles perdidos: #{@level}
      Se pierde equipo visible: #{@specific_visible_treasures}
      Se pierde equipo oculto: #{@specific_hidden_treasures}
      Muerto?: #{@death}"
    end
=end
  end
end
