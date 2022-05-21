require 'minitest/autorun'
require 'appium_lib_core'

class JaSSTTohoku < Minitest::Test
  def setup
    @core = ::Appium::Core.for capabilities: {
      platformName: :ios,
      automationName: :xcuitest,
      platformVersion: '15.0',
      deviceName: 'iPhone 12 Pro',
      browserName: :safari,
      wdaLaunchTimeout: 90_000
    }
    @driver = nil
  end

  def teardown
    @driver&.quit
  end

  # 実際はよりシナリオを読みやすくするなどの工夫を行うことが多い
  def test_JaSST東北のWebページを開いてスクロールする
    @driver = @core.start_driver server_url: 'http://localhost:4723'

    @driver.get 'https://jasst.jp/symposium/jasst22tohoku.html'

    @driver.wait_true { |d| @driver.available_contexts.size >= 2 }
    @driver.context = @driver.available_contexts[-1]

    assert @driver.wait_true { |d| d.current_url == 'https://jasst.jp/symposium/jasst22tohoku.html' }

    3.times { w3c_scroll @driver }

    @driver.context = 'NATIVE_APP'

    @driver.wait { |d| d.find_element :accessibility_id, 'PAGE TOP' }.click

    e = @driver.wait { |d| d.find_element :accessibility_id, 'JaSST開催概要' }
    assert @driver.wait_true { e.displayed? }
  end
end

def w3c_scroll(driver)
  window = driver.window_rect
  action_builder = driver.action
  input = action_builder.pointer_inputs[0]
  action_builder
    .move_to_location(window.width / 2, window.height * 8 / 10)
    .pointer_down(:left)
    .pause(input, 0.2)
    .move_to_location(window.width / 2, window.height / 10)
    .pause(input, 0.2)
    .release
    .perform
end
