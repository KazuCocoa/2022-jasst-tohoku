require 'minitest/autorun'
require 'net/http'

def http_header_check(hedaer)

end

def JaSST開催概要?(body)
  body.force_encoding("utf-8").include? "JaSST開催概要"
end

class JaSSTTohoku < Minitest::Test
  def test_通信受信
    uri = URI('https://jasst.jp/symposium/jasst22tohoku.html')
    res = Net::HTTP.get_response(uri)

    assert JaSST開催概要? res.body
  end
end
