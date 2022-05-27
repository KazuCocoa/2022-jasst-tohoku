#
# JaSST TohokuのURLを得たときに何らかの処理をするメソッドがテスト対象。
# 実際のサーバーから値を取得してくるのでは時間がかかる、ネットワーク状況によっては取得できない場合がある。
# テスト対象の中身の処理を確認したいので、URLからは何らかの結果が返ってきたテイでテストする。
#

require 'minitest/autorun'
require 'webmock/minitest'
require 'net/http'

# テスト対象
# 何らかのテストしたい処理がある
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
