require "./spec_helper"

describe Kemalyst::WebSocket do
  it "Upgrades to websocket" do
    headers = HTTP::Headers {
      "Upgrade" => "websocket",
      "Connection" => "Upgrade",
      "Sec-WebSocket-Key" => "dGhlIHNhbXBsZSBub25jZQ=="
    }
    request = HTTP::Request.new("GET", "/", headers)
    io, context = create_context(request)
    websocket = Kemalyst::WebSocket.new()
    handler = Kemalyst::Handler::Block.new(->(c : HTTP::Server::Context) { "Hello World!" })
    router = Kemalyst::Handler::Router.new
    router.add_route("GET", "/", [websocket, handler])
    # router.call(context)
    # context.response.close
    # io.rewind

    # io.to_s.should eq("HTTP/1.1 101 Switching Protocols\r\nUpgrade: websocket\r\nConnection: Upgrade\r\nSec-Websocket-Accept: s3pPLMBiTxaQ9kYGzzhZRbK+xOo=\r\n\r\n")
  end
end


