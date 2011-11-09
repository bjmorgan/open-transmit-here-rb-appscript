#!/opt/local/bin/ruby
# November 8, 2011
# Script to extract server name and current path from a Terminal window, and open the same directory in Transmit

require 'appscript'

terminal = Appscript.app("/Applications/Utilities/Terminal.app")
transmit = Appscript.app("/Applications/Transmit.app")
whose = Appscript.its

window_title = terminal.windows[0].tabs[1].custom_title.get # e.g. morgan@kittel:~/TiO2-B/PBE/2Li/Li_Ca/opt/super

server = /@([A-Za-z]*)/.match(window_title)[1] # match e.g. kittel
path = /\:([^^]*)/.match(window_title)[1] # match e.g. ~/TiO2-B/PBE/2Li/Li_Ca/opt/super

transmit.activate
transmit.make(:new => :document)
tab = transmit.documents[0].current_tab

my_fave = transmit.favorites[whose.name.eq(server)].items[1].get
tab.connect(:to => my_fave)
tab.remote_browser.change_location(:to_path => path)
