# jasst-tohoku

デモ環境

## 準備

### Appiumのインストール

```
$ npm install -g appium@next
```

(`npm`コマンドのインストールは検索してみてください)

### Appiumを起動する

```
$ appium
```

## 実行

### 1_ui_test_appium

macOSが必要です

```
$ cd 1_ui_test_appium
$ bundle install
$ bundle exec ruby appium.rb
```

### 2_integrate_network_real

```
$ cd 2_integrate_network_real
$ bundle install
$ bundle exec ruby network.rb
```

### 3_unit_network_stub

```
$ cd 3_unit_network_stub
$ bundle install
$ bundle exec ruby network.rb
```


### 4_unit

```
$ cd 4_unit
$ bundle install
$ bundle exec ruby test.rb
```
