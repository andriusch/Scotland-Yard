require 'rubygems'
require 'gosu'
require 'set'

Dir.chdir(File.join(File.dirname(__FILE__), '..'))
Dir.glob('lib/*.rb').each {|f| require f unless f == "lib/main.rb"}

WIDTH = 1024
HEIGHT = 768
LEFT_PANEL_X = WIDTH - 200

window = GameWindow.new
window.show