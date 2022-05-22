require 'minitest/autorun'
require 'webmock/minitest'
require 'net/http'

def JaSST開催概要?(body)
  body.force_encoding("utf-8").include? "JaSST開催概要"
end

class JaSSTTohoku < Minitest::Test
  def test_通信受信
    stub_request(:get, "http://localhost:8080/symposium/jasst22tohoku.html")
      .to_return(status: 200, body: "JaSST開催概要" )

    uri = URI("http://localhost:8080/symposium/jasst22tohoku.html")
    res = Net::HTTP.get_response(uri)

    assert JaSST開催概要? res.body
  end
end
