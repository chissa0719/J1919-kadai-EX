=begin
課題EX

DXRubyライブラリを使ったゲームを作成してください。

【進め方】
作成するゲームプログラムを登録するための、GitHubリポジトリ（パブリック）を作成します（名前は何でも結構です）。

次に、「簡単なゲームの作成」
https://www.eastback.co.jp/archives/dxruby/create-simple-game/
を一通りやってみてください。
※ 必要に応じて、リポジトリにadd, commit, pushを行ってください。

次に、このプログラムを元にカスタマイズを行い、自由にゲームを拡張してください。

カスタマイズの例としては、
敵の数、敵の種類、敵の動き、味方の機能、弾、ビーム、重力、得点表示、ライフ、オープニングとエンディング、
キーを押したらスタート・リスタート、ボーナスポイント、障害物、ステージクリア、ボスキャラ、などなど・・・
何でも結構です。

最終的に出来上がったプログラムは、GitHubリポジトリのmainブランチにpush(merge)してください。
終わったら、以下にGitHubリポジトリのURLを貼り付けて、このファイルを提出してください。

URL:https://github.com/chissa0719/J1919_-_kadai-EX.git

=end

require 'dxruby'

#画面サイズ
Window.width = 1024
Window.height = 768

#デフォルト背景色
Window.bgcolor = C_RED

#フォントサイズ
font = Font.new(32) #MS明朝


Window.loop do

  #マウス座標
  x = Input.mouse_pos_x  # マウスカーソルのx座標
  y = Input.mouse_pos_y  # マウスカーソルのy座標

  Window.draw_font(100, 100, "x : #{x}, y : #{y}", font) # 追加

end