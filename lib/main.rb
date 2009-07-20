require 'rubygems'
require 'gosu'
require 'game_window'
require 'board'
require 'player'

Dir.chdir(File.join(File.dirname(__FILE__), '..'))
LEFT_PANEL_WIDTH = 100

window = GameWindow.new
window.show