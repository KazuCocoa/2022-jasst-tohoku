require 'minitest/autorun'
require 'appium_lib_core'

class JaSSTTohoku < Minitest::Test
  def test_calculate
    core = ::Appium::Core.for capabilities: {
      platformName: :ios,
      automationName: :xcuitest,
      platformVersion: '15.0',
      deviceName: 'iPhone 12 Pro',
      browserName: :safari,
      wdaLaunchTimeout: 90_000
    }
    driver = core.start_driver server_url: 'http://localhost:4723'

    driver.get 'https://jasst.jp/symposium/jasst22tohoku.html'

    driver.wait_true { |d| driver.available_contexts.size >= 2 }
    driver.context = driver.available_contexts[-1]

    assert driver.wait_true { |d| d.current_url == 'https://jasst.jp/symposium/jasst22tohoku.html' }

    driver.quit
  end
end
