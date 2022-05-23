# Appiumを使い、以下の操作を行う。
#
# ユーザはJaSST Tohokuのページの最下部まで到達したら最上部に戻りたい
#
# 1. Webブラウザを開く
# 2. https://jasst.jp/symposium/jasst22tohoku.html を入力する
# 3. 最下部までスクロールする
# 4. 最上部まで戻る
#

require 'minitest/autorun'
require 'appium_lib_core'

class JaSSTTohoku < Minitest::Test
  def setup
    # iOS 15 のシミュレータ(iPhone 12 Pro)でテストを実行する
    @core = ::Appium::Core.for capabilities: {
      platformName: :ios,
      automationName: :xcuitest,
      platformVersion: '15.5',
      deviceName: 'iPhone 12 Pro',
      browserName: :safari

    }
    @driver = nil
  end

  # 実際はよりシナリオを読みやすくするなどの工夫を行うことが多い
  def test_JaSST東北のWebページを開いてスクロールする
    # Safariを起動する
    @driver = @core.start_driver server_url: 'http://localhost:4723'

    # JaSST TohokuのURLを開く
    @driver.get 'https://jasst.jp/symposium/jasst22tohoku.html'

    # Appiumの処理
    @driver.wait_true { |d| d.available_contexts.size >= 2 }
    @driver.context = @driver.available_contexts.last

    # JaSST TohokuのURLが表示されるまで待つ
    assert @driver.wait_true { |d| d.current_url == 'https://jasst.jp/symposium/jasst22tohoku.html' }

    # 最下部まですクロールする
    scroll_to_bottom

    @driver.wait { |d| d.find_element :class, 'pagetop' }.click

    # 画面に "JaSST開催概要" の要素が表示されていることを確認する
    assert @driver.wait_true { |d| d.find_element(:link_text, 'JaSST開催概要').displayed? }
  end

  def teardown
    @driver&.quit
  end

  private

  def scroll_to_bottom
    3.times { scroll }
  end

  def scroll
    return if @driver.nil?

    window = @driver.window_rect
    action_builder = @driver.action
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
end
