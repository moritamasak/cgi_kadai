require 'webrick' 

server = WEBrick::HTTPServer.new({
  :DocumentRoot => '.',
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
  :Port => '3000',
})
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}

server.mount('/test', WEBrick::HTTPServlet::ERBHandler, 'test.html.erb')

server.mount('/indicate.cgi', WEBrick::HTTPServlet::CGIHandler, 'indicate.rb')

server.mount('/goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya.rb')

server.mount('/', WEBrick::HTTPServlet::ERBHandler, 'kadai.html.erb')

server.mount('/give_for.cgi', WEBrick::HTTPServlet::CGIHandler, 'give_for.rb')

server.mount('/quality.cgi', WEBrick::HTTPServlet::CGIHandler, 'quality.rb')

server.start