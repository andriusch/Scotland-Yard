require 'rubygems'
require 'gosu'
require 'set'

require 'board'
require 'GUI/component'
require 'GUI/form'
require 'GUI/transport_form'
require 'GUI/win_form'
require 'GUI/clickable'
require 'player'
require 'criminal'
require 'cursor'
require 'game_window'
require 'log'
require 'routes'
require 'status'
require 'coords'

Dir.chdir(File.join(File.dirname(__FILE__), '..'))

WIDTH = 1024
HEIGHT = 768
LEFT_PANEL_X = WIDTH - 200
STATUS_Y = 200

srand

window = GameWindow.new
window.show