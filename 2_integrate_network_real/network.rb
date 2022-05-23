#
# JaSST TohokuのURLにある文字列が含まれていることを確認する
# この場合、描画が正しくされているか、というブラウザによる描画に関しては確認できない。
# ただ、ここでは実際のURLにリクエストを送っているので実際の応答を得ることができる。
#

require 'minitest/autorun'
require 'net/http'

def JaSST開催概要?(body)
  body.force_encoding("utf-8").include? "JaSST開催概要"
end

class JaSSTTohoku < Minitest::Test
  def test_JaSST東北のWebページを開く
    uri = URI('https://jasst.jp/symposium/jasst22tohoku.html')
    res = Net::HTTP.get_response(uri)

    assert JaSST開催概要? res.body
  end
end
