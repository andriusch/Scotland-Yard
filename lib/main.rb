require 'rubygems'
require 'gosu'
require 'set'

require 'board'
require 'component'
require 'form'
require 'transport_form'
require 'clickable'
require 'transport_button'
require 'player'
require 'criminal'
require 'cursor'
require 'game_window'
require 'log'
require 'routes'
require 'status'

Dir.chdir(File.join(File.dirname(__FILE__), '..'))

WIDTH = 1024
HEIGHT = 768
LEFT_PANEL_X = WIDTH - 200
STATUS_Y = 165

srand

window = GameWindow.new
window.show