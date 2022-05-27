#
# 特に外部との通信もないメソッドのテスト
#

require 'minitest/autorun'

def plus(a, b)
  return a + b
end

class JaSSTTohoku < Minitest::Test
  def test_四則演算
    assert_equal plus(1, 2), 3
  end
end
