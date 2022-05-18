require 'minitest/autorun'

def plus(a, b)
  return a + b
end

class JaSSTTohoku < Minitest::Test
  def test_calculate
    assert_equal plus(1, 2), 3
  end
end
