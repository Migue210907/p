#encoding:utf-8

require_relative '../dice'
require_relative '../directions'
require_relative '../orientation'
require_relative '../game_character'
require_relative '../weapon'
require_relative '../shield'
require_relative '../game_state'
require_relative '../monster'
require_relative '../player'
require_relative '../labyrinth'
require_relative '../game'

require_relative '../UI/text_ui'
require_relative '../Controller/controller'

module Main

  def self.main
    game = Irrgarten::Game.new(2)
    view = UI::TextUI.new
    controller = Controller::Controller.new(game, view)

    controller.play
  end

end

Main.main