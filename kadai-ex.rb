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

URL : https://github.com/chissa0719/J1919-kadai-EX

=end

require 'dxruby'

#画面サイズ
Window.width = 1024
Window.height = 768

#デフォルト背景色
Window.bgcolor = C_GREEN

#フォントサイズ
font = Font.new(32) #MS明朝
title_font = Font.new(40)
intro_font = Font.new(25)
print_font = Font.new(20)

#画像登録
#タイトル画面背景
title_img = Image.load("images/タイトル.jpg")
#キャラ選択画面背景
chara_pick = Image.load("images/キャラ選択_背景.jpg")
#赤枠
red_frame = Image.load("images/frame.png")
#バトル下枠背景
battle_frame = Image.load("images/battle_back.png")
#セレクト
select_img = Image.load("images/select.png")
#女性キャラ1
woman1_normal = Image.load("images/chara/woman1/face_normal.png")
woman1_pinchi = Image.load("images/chara/woman1/face_pinchi.png")
woman1_tere = Image.load("images/chara/woman1/face_tere.png")
#女性キャラ2
woman2_normal = Image.load("images/chara/woman2/face_normal.png")
woman2_pinchi = Image.load("images/chara/woman2/face_pinchi.png")
#woman2_tere = Image.load("images/chara/woman2/face_tere.png")
#女性キャラ3
woman3_normal = Image.load("images/chara/woman3/face_normal.png")
woman3_pinchi = Image.load("images/chara/woman3/face_pinchi.png")
#woman1_tere = Image.load("images/chara/woman1/face_tere.png")
#男性キャラ1
man1_normal = Image.load("images/chara/man1/face_normal.png")
man1_pinchi = Image.load("images/chara/man1/face_pinchi.png")
#男性キャラ2
man2_normal = Image.load("images/chara/man2/face_normal.png")
man2cls_pinchi = Image.load("images/chara/man2/face_pinchi.png")
#男性キャラ3
man3_normal = Image.load("images/chara/man3/face_normal.png")
man3_pinchi = Image.load("images/chara/man3/face_pinchi.png")
#敵キャラ
enemy_goblin = Image.load("images/enemy/1001010401.png")
#敵アイコン
enemy_goblin_face = Image.load("images/enemy_face/face_1.png")


#フィールド全体
class Field
  attr_accessor :enemy_level, :field_option, :turn
  def initialize
    @field_option = 0
  end
  #ステージレベル登録
  def set_enemy_level(num)
    @enemy_level = num.to_i
  end
  #フィールド状態登録(フィールド全体毒、封印など)※重複しない
  def set_field_option(num)
    @field_option = num
  end
  #turnを1進める
  def turn_cnt
    @turn += 1
  end
  #戦闘開始
  def new_battle
    @turn = 1 #最初は1ターン目
  end
  #バトル表示(基本)
  def print_battle(hero,enemy,field)
    #文字
    font = Font.new(32) #MS明朝
    battle_font = Font.new(26)
    command_font = Font.new(28)
    print_font = Font.new(20)
    for_magic_font = Font.new(15)
    #ターン
    #Window.draw_font(10,10,"#{@turn} ターン目", font, color:[255,0,0,0])
    #左枠
    Window.draw_box_fill(131,  460, 311, 730, C_WHITE, z=1)
    Window.draw_box_fill(136,  465, 306, 725, C_BLACK, z=2)
    #右枠
    Window.draw_box_fill(321,  460, 891, 730, C_WHITE, z=1)
    Window.draw_box_fill(326,  465, 886, 725, C_BLACK, z=2)
    #文字表示
    Window.draw_font(177,485,"こうどう", battle_font, fontcolor:[255,255,255],z:3)
    Window.draw_font(172,545,"たたかう", command_font, fontcolor:[255,255,255],z:3)
    Window.draw_font(173,605,"ぼうぎょ", command_font, fontcolor:[255,255,255],z:3)
    Window.draw_font(183,665,"にげる",   command_font, fontcolor:[255,255,255],z:3)
    #キャラアイコン
    #女性キャラ1
    woman1_normal = Image.load("images/chara/woman1/face_normal.png")
    woman1_pinchi = Image.load("images/chara/woman1/face_pinchi.png")
    woman1_tere = Image.load("images/chara/woman1/face_tere.png")
    #女性キャラ2
    woman2_normal = Image.load("images/chara/woman2/face_normal.png")
    woman2_pinchi = Image.load("images/chara/woman2/face_pinchi.png")
    #女性キャラ3
    woman3_normal = Image.load("images/chara/woman3/face_normal.png")
    woman3_pinchi = Image.load("images/chara/woman3/face_pinchi.png")
    #男性キャラ1
    man1_normal = Image.load("images/chara/man1/face_normal.png")
    man1_pinchi = Image.load("images/chara/man1/face_pinchi.png")
    #男性キャラ2
    man2_normal = Image.load("images/chara/man2/face_normal.png")
    man2cls_pinchi = Image.load("images/chara/man2/face_pinchi.png")
    #男性キャラ3
    man3_normal = Image.load("images/chara/man3/face_normal.png")
    man3_pinchi = Image.load("images/chara/man3/face_pinchi.png")
    #セレクト
    select_img = Image.load("images/select.png")
    #レベル
    Window.draw_font(470,505,"Lv. #{hero.level}", print_font, color:[255,255,255,255],z:4)
    #バー色塗り
    tmp_max = hero.need_exp / 10
    for i in 1..10 #10分割
      if hero.exp >= (i * tmp_max)
        Window.draw_box_fill(535+(28 * (i-1)),  510, 535+(28 * (i-1))+28, 520, C_BLUE, z=4) #バー
      end
    end
    if hero.level != 99
      Window.draw_box_fill(530,  505, 820, 525, C_WHITE, z=4) #大枠
      #経験値計算
      #exp_calc(hero,enemy,field)      
      #バー色塗り
      tmp_max = hero.need_exp / 10
      for i in 1..10 #10分割
        if hero.exp >= (i * tmp_max)
          Window.draw_box_fill(535+(28 * (i-1)),  510, 535+(28 * (i-1))+28, 520, C_BLUE, z=4) #バー
        end
      end
    else #レベル最大時、Maxで表示
      Window.draw_box_fill(530,  505, 820, 525, C_WHITE, z=4) #大枠
      Window.draw_box_fill(535,  510, 815, 520, C_BLUE, z=4) #バー
    end
    #特性
    Window.draw_font(470,553,"特性 : ", print_font, color:[255,255,255,255],z:4)
    #キャラごとに場合分け
    if hero.hero_type == 0 #天使
      Window.draw(356,490,woman1_normal,z=4)
      Window.draw_font(378,610,"【天使】", for_magic_font, color:[255,255,255,255],z:4)
      Window.draw_font(530,553,"一定確率でターン開始時にHP回復", print_font, color:[255,255,255,255],z:4)
    elsif hero.hero_type == 1 #迷い人
      Window.draw(356,490,woman2_normal,z=4)
      Window.draw_font(370,610,"【迷い人】", for_magic_font, color:[255,255,255,255],z:4)
      Window.draw_font(530,553,"敵の攻撃を回避する確率が高い", print_font, color:[255,255,255,255],z:4)
    elsif hero.hero_type == 2 #魔法研究者
      Window.draw(356,490,woman3_normal,z=4)
      Window.draw_font(356,610,"【魔法研究者】", for_magic_font, color:[255,255,255,255],z:4)
      Window.draw_font(530,553,"MPと頭脳が高く、魔法攻撃の威力が高い", print_font, color:[255,255,255,255],z:4)
    elsif hero.hero_type == 3 #勇者
      Window.draw(356,490,man1_normal,z=4)
      Window.draw_font(376,610,"【勇者】", for_magic_font, color:[255,255,255,255],z:4)
      Window.draw_font(530,553,"攻撃が高く、クリティカル率が高い", print_font, color:[255,255,255,255],z:4)
    elsif hero.hero_type == 4 #信仰者
      Window.draw(356,490,man2_normal,z=4)
      Window.draw_font(370,610,"【信仰者】", for_magic_font, color:[255,255,255,255],z:4)
      Window.draw_font(530,553,"先制を取りやすく、お金の獲得量が多い", print_font, color:[255,255,255,255],z:4)
    elsif hero.hero_type == 5 #旅人
      Window.draw(356,490,man3_normal,z=4)
      Window.draw_font(378,610,"【旅人】", for_magic_font, color:[255,255,255,255],z:4)
      Window.draw_font(530,553,"取得する経験値が大幅に増加する", print_font, color:[255,255,255,255],z:4)
    end 
    #能力表示
    Window.draw_font(490,601,"HP : #{hero.hp} / #{hero.hp_max}", print_font, color:[255,255,255,255],z:4)
    Window.draw_font(670,601,"MP : #{hero.mp} / #{hero.mp_max}", print_font, color:[255,255,255,255],z:4)
    Window.draw_font(475,641,"ちから :  #{hero.power}", print_font, color:[255,255,255,255],z:4)
    Window.draw_font(605,641,"ずのう :  #{hero.brain}", print_font, color:[255,255,255,255],z:4)
    Window.draw_font(745,641,"まもり :  #{hero.def}", print_font, color:[255,255,255,255],z:4)
    Window.draw_font(474,681,"かいひ :  #{hero.avoid}", print_font, color:[255,255,255,255],z:4)
    Window.draw_font(607,681,"そくど :  #{hero.speed}", print_font, color:[255,255,255,255],z:4)
    Window.draw_font(740,681,"かいしん :  #{hero.cri}", print_font, color:[255,255,255,255],z:4)
    #敵の名前
    if enemy.type == 1 && enemy.hp > 0
      Window.draw_font(455,50,"【ゴブリン】", battle_font, color:[255,0,0,0],z:3)
    end
  end
  #「敵を倒した！」表示
  def finished_battle(hero,enemy,field)
    Window.loop do
      #背景を描画
      title_img = Image.load("images/タイトル.jpg")
      Window.draw_morph(0,0,1024,0,1024,768,0,768,title_img)
      #敵を描画
      #enemy.print_enemy
      #バトル枠表示
      field.print_battle(hero,enemy,field)
      #「たたかう」枠
      #Window.draw_box(162, 535, 284, 583, C_WHITE, z=5)
      #マウス座標取得
      x = Input.mouse_pos_x  # マウスカーソルのx座標
      y = Input.mouse_pos_y  # マウスカーソルのy座標
      #表示枠
      Window.draw_box_fill(370,  350, 630, 440, C_YELLOW, z=8) #大枠
      Window.draw_box_fill(375,  355, 625, 435, C_BLACK, z=9) #内枠
      font = Font.new(32) #MS明朝
      title_font = Font.new(40)
      intro_font = Font.new(25)
      print_font = Font.new(20)
      Window.draw_font(431,382,"敵を倒した！", intro_font, color:[255,255,255,255],z:10)
      if Input.mousePush?(M_LBUTTON)
        break
      end
    end
  end
  #経験値計算
  def exp_calc(hero,enemy,field)
    title_img = Image.load("images/タイトル.jpg")
    exp_cnt = 0
    is_levelup = nil #レベルアップしたか
    old_level = hero.level.to_s.rjust(2) #取得前のレベル
    old_power = hero.power.to_s.rjust(3)
    old_hp = hero.hp_max.to_s.rjust(3)
    old_mp = hero.mp_max.to_s.rjust(3)
    old_def = hero.def.to_s.rjust(3)
    old_speed = hero.speed.to_s.rjust(3)
    old_brain = hero.brain.to_s.rjust(3)
    #旅人は経験値の取得量が多い
    if hero.hero_type == 5
      enemy.exp *= 2
    end
    loop do
      hero.exp += enemy.exp
      if hero.exp >= hero.need_exp
        hero.exp -= hero.need_exp
        hero.need_exp *= 1.5
        hero.need_exp = hero.need_exp.to_i
        #ステータス増加
        hero.hp_max += rand(2..7)
        hero.hp = hero.hp_max
        hero.mp_max += 5
        hero.mp = hero.mp_max
        hero.power += rand(3..5)
        hero.def += rand(3..5)
        hero.speed += rand(2..5)
        hero.brain += rand(2..5)
        #増加値調整
        if hero.hero_type == 1
          hero.power -= 3
          hero.def += 3
        elsif hero.hero_type == 2
          hero.mp_max += rand(2..5)
          hero.mp = hero.mp_max
          hero.brain += rand(4..8)
          hero.power -= 2
        elsif hero.hero_type == 3
          hero.power += rand(3..7)
        elsif hero.hero_type == 4
          hero.speed += rand(5..10)
        end
        hero.level += 1
        is_levelup = true
      else
        break
      end
      exp_cnt += 1
    end
    new_level = hero.level #取得後のレベル
    new_power = hero.power.to_s.rjust(3)
    new_hp = hero.hp_max.to_s.rjust(3)
    new_mp = hero.mp.to_s.rjust(3)
    new_def = hero.def.to_s.rjust(3)
    new_speed = hero.speed.to_s.rjust(3)
    new_brain = hero.brain.to_s.rjust(3)
    #レベルアップ表示
    if is_levelup != nil
      #クリック待ち
      Window.loop do
        #背景を描画
        Window.draw_morph(0,0,1024,0,1024,768,0,768,title_img)
        #敵を描画
        #enemy.print_enemy
        #バトル枠表示
        field.print_battle(hero,enemy,field)
        #マウス座標取得
        x = Input.mouse_pos_x  # マウスカーソルのx座標
        y = Input.mouse_pos_y  # マウスカーソルのy座標
        #表示枠
        Window.draw_box_fill(470,  240, 820, 500, C_YELLOW, z=8) #大枠
        Window.draw_box_fill(475,  245, 815, 495, C_BLACK, z=9) #内枠
        #表示中身
        print_font = Font.new(20)
        Window.draw_font(532,265,"Level UP！", print_font,z:10)
        Window.draw_font(523,305,"  HP  UP！", print_font,z:10)
        Window.draw_font(522,335,"  MP  UP！", print_font,z:10)
        Window.draw_font(524,365,"ちから UP！", print_font,z:10)
        Window.draw_font(523,395,"ずのう UP！", print_font,z:10)
        Window.draw_font(527,425,"まもり UP！", print_font,z:10)
        Window.draw_font(527,455,"そくど UP！", print_font,z:10)
        #数字(取得前)
        Window.draw_font(667,265,"#{old_level}", print_font,z:10)
        Window.draw_font(663,305,"#{old_hp}", print_font,z:10)
        Window.draw_font(663,335,"#{old_mp}", print_font,z:10)
        Window.draw_font(663,365,"#{old_power}", print_font,z:10)
        Window.draw_font(663,395,"#{old_brain}", print_font,z:10)
        Window.draw_font(663,425,"#{old_def}", print_font,z:10)
        Window.draw_font(663,455,"#{old_speed}", print_font,z:10)
        #矢印
        Window.draw_font(713,265,"->", print_font,z:10)
        Window.draw_font(713,305,"->", print_font,z:10)
        Window.draw_font(713,335,"->", print_font,z:10)
        Window.draw_font(713,365,"->", print_font,z:10)
        Window.draw_font(713,395,"->", print_font,z:10)
        Window.draw_font(713,425,"->", print_font,z:10)
        Window.draw_font(713,455,"->", print_font,z:10)
        #数字(取得後)
        Window.draw_font(760,265,"#{new_level}", print_font,z:10)
        Window.draw_font(749,305,"#{new_hp}", print_font,z:10)
        Window.draw_font(749,335,"#{new_mp}", print_font,z:10)
        Window.draw_font(749,365,"#{new_power}", print_font,z:10)
        Window.draw_font(749,395,"#{new_brain}", print_font,z:10)
        Window.draw_font(749,425,"#{new_def}", print_font,z:10)
        Window.draw_font(749,455,"#{new_speed}", print_font,z:10)
        #クリックしたら
        if Input.mousePush?(M_LBUTTON)
          break
        end
      end
    end
  end
  #ターン表示
  def print_turn(hero,enemy,field)
    Window.loop do
    print_font = Font.new(26)
    turn_font = Font.new(18)
    #背景を描画
    title_img = Image.load("images/タイトル.jpg")
    Window.draw_morph(0,0,1024,0,1024,768,0,768,title_img)
    #敵を描画
    enemy.print_enemy
    #バトル枠表示
    field.print_battle(hero,enemy,field)
    #マウス座標取得
    x = Input.mouse_pos_x  # マウスカーソルのx座標
    y = Input.mouse_pos_y  # マウスカーソルのy座標
    #枠表示
    Window.draw_box_fill(230,  150, 780, 350, C_YELLOW, z=8) #大枠(目標)
    Window.draw_box_fill(235,  155, 775, 345, C_BLACK, z=9) #内枠(目標)
    #表示
    trn = @turn.to_s.rjust(3)
    #キャラアイコン
    #女性キャラ1
    woman1_normal = Image.load("images/chara/woman1/face_normal.png")
    #女性キャラ2
    woman2_normal = Image.load("images/chara/woman2/face_normal.png")
    #女性キャラ3
    woman3_normal = Image.load("images/chara/woman3/face_normal.png")
    #男性キャラ1
    man1_normal = Image.load("images/chara/man1/face_normal.png")
    #男性キャラ2
    man2_normal = Image.load("images/chara/man2/face_normal.png")
    #男性キャラ3
    man3_normal = Image.load("images/chara/man3/face_normal.png")
    #敵アイコン
    enemy_goblin_face = Image.load("images/enemy_face/face_1.png")
    #アイコン表示
    Window.draw_font(425,180,"#{trn}  ターン目", print_font,color:[255,255,255,255],z:10)
    Window.draw_font(470,225,"行動順", turn_font,color:[255,255,255,255],z:10)
    if hero.hero_type == 0
      Window.draw_morph(370,258,440,258,440,328,370,328,woman1_normal,z:15)
    end
    #矢印
    Window.draw_font(486,280,"->", print_font,z:10)
    #敵アイコン表示
    if enemy.type == 1
      Window.draw_morph(545,258,615,258,615,328,545,328,enemy_goblin_face,z:15)
    end
    #クリックしたら
    if Input.mousePush?(M_LBUTTON)
      break
    end
    end
  end
end

#主人公
class Hero
  attr_accessor :hero_type, :level, :hp, :power, :brain, :avoid, :def, :cri, :hp_max, :mp, :mp_max, :speed, :exp, :money, :need_exp
  def initialize
    @level = 1
    @exp = 0
    @money = 10
    @need_exp = 10
  end
  #主人公タイプ登録
  def set_hero_level(num)
    @hero_type = num.to_i
  end
  #ステータス設定
  def set_status
    #HP
    @hp = 100 + (rand(0.1..0.5) * 20) #100 + (2 ~ 10)
    #MP
    @mp = 10
    #ステータス調整
    if @hero_type == 2 #魔法研究者はmpが高い
      @mp *= 2
    end
    #ちから
    @power = (rand(0.5..0.9) * 50) / 2 #12 ~ 22
    #ステータス調整
    if @hero_type == 1 #迷い人は攻撃が低め
      @power *= 0.6
    elsif @hero_type == 3 #勇者は攻撃が高い
      @power *= 1.5
    end
    #ずのう
    @brain = (rand(0.5..0.9) * 50) / 2 #12 ~ 22
    #ステータス調整
    if @hero_type == 2 #魔法研究者は頭脳が高い
      @brain *= 2
    end
    #回避率
    @avoid = 10
    #ステータス調整
    if @hero_type == 1 #迷い人は回避率が高い
      @avoid = 40
    end
    #ぼうぎょ
    @def = 10 + rand(1..10)
    #ステータス調整
    if @hero_type == 2 #魔法研究者は防御が高い
      @def *= 0.7
    end
    #クリティカル
    @cri = 10
    #ステータス調整
    if @hero_type == 3 #勇者はクリティカル率が高い
      @cri = 30
    end
    #速度
    @speed = 10 + rand(1..5)
    #ステータス調整
    if @hero_type == 4 #信仰者は速度が高い
      @speed += 20
    end
    #旅人は初期ステータス低め
    if @hero_type == 5
      @hp *= 0.7
      @mp *= 0.7
      @power *= 0.7
      @brain *= 0.7
      @def *= 0.7
      @speed *= 0.7
    end
    #整数処理
    @hp = @hp.to_i
    @hp_max = @hp
    @mp = @mp.to_i
    @mp_max = @mp
    @power = @power.to_i
    @brain = @brain.to_i
    @def = @def.to_i
    @speed = @speed.to_i
  end
  #わざ表示
  def print_skill
    print_font = Font.new(20)
    Window.draw_font(475,541,"通常攻撃 : MP 0", print_font, color:[255,255,255,255],z:8)
    Window.draw_font(655,541," 強攻撃  : MP 1", print_font, color:[255,255,255,255],z:8)
  end
  #自分の攻撃のダメージ計算
  def calc_damage(hero,enemy,field,pat,num) #攻撃パターン(0:物理、1:魔法)
    print_font = Font.new(20)
    select_img = Image.load("images/select.png")
    #クリティカルが出たか
    is_cri = nil
    if pat == 0 #物理攻撃(通常攻撃、強攻撃)
      dmg = rand(hero.power..hero.power*1.5) - enemy.def
      if num == 1 #強攻撃
        dmg *= 1.5
      end
    elsif pat == 1 #魔法攻撃
      dmg = rand(hero.brain..hero.brain*1.5) - enemy.brain
    end
    #クリティカル計算
    cri = rand(1..10)
    if hero.hero_type != 3
      if cri == 1
        dmg *= 2
        is_cri = true
      end
    elsif hero.hero_type == 3
      if cri == 1 || cri == 2 || cri == 3
        dmg *= 2
        is_cri = true
      end
    end
    #敵の防御または頭脳が上回った場合は0にする
    if dmg < 0
      dmg = 0
    end
    #整数化
    dmg = dmg.to_i
    #減少
    enemy.hp -= dmg
    #表示
    font = Font.new(32) #MS明朝
    print_time = 0
    Window.loop do
        #背景を描画
        title_img = Image.load("images/タイトル.jpg")
        Window.draw_morph(0,0,1024,0,1024,768,0,768,title_img)
        #敵を描画
        enemy.print_enemy
        #バトル枠表示
        field.print_battle(hero,enemy,field)
        #「たたかう」枠
        Window.draw_box(162, 535, 284, 583, C_WHITE, z=5)
        #マウス座標取得
        x = Input.mouse_pos_x  # マウスカーソルのx座標
        y = Input.mouse_pos_y  # マウスカーソルのy座標
        #選択枠
        Window.draw_box_fill(460, 465, 886, 725, C_BLACK, z=6) #黒で塗りつぶす
        #HPとMP
        Window.draw_font(490,491,"HP : #{hero.hp} / #{hero.hp_max}", print_font, color:[255,255,255,255],z:7)
        Window.draw_font(670,491,"MP : #{hero.mp} / #{hero.mp_max}", print_font, color:[255,255,255,255],z:7)
        #キャラごとに表示
        hero.print_skill
        #わざ選択枠
        if pat == 0 && num == 0 #通常攻撃
          Window.draw_box(465, 531, 630, 571, C_WHITE, z=8)
        elsif pat == 0 && num == 1 #強攻撃
          Window.draw_box(645, 531, 810, 571, C_WHITE, z=8)
        end
        dmg_img = Image.load("images/damage.png")
        Window.draw_morph(300,200,500,200,500,400,300,400,dmg_img,z:14)
        #font = Font.new(32) #MS明朝
        dmg = dmg.to_s.rjust(3)
        #クリティカル表示
        #is_cri = true
        if is_cri == true
          Window.draw_font(315,220,"クリティカル！", font, color:[255,255,255,0],z:16)
        end
        Window.draw_font(375,280,"#{dmg}", font, color:[255,255,255,255],z:15)
        #クリックしたら
        if print_time >= 20
          break
        end
        print_time += 1
    end
  end
end

#敵
class Enemy
  attr_accessor :hp, :type, :power, :brain, :def, :avoid, :speed, :exp
  def initialize
    @hp = -1
    @exp = 0
  end
  #敵タイプ抽選
  def set_enemy
    @type = rand(1..1)
  end
  #敵描画
  def print_enemy
    if @type == 1 #ゴブリン
      enemy_goblin = Image.load("images/enemy/1001010401.png")
      Window.draw(370,100,enemy_goblin)
    end
  end
  #ステータス設定
  def set_status(stage_level)
    #HP
    @hp = ((stage_level * 40)) + (@type * (rand(2..5) * 10)) 
    #ちから
    if stage_level >= 2
      @power = (stage_level * 10) * (@type * 0.5) + (rand(1..5) * 5) + ((stage_level - 1) * 10)
    else
      @power = (stage_level * 10) * (@type * 0.5) + (rand(1..5) * 5)
    end
    #まもり
    @def = 2 + (rand(1..3) * @type * 2) + ((stage_level - 1) * 5)
    #ずのう
    tmp_start = 2 + @type
    @brain = rand(@type..@type*2) + ((stage_level - 1) * 5)
    #かいひ
    @avoid = 10
    #そくど
    @speed = 5 + (rand(1..5) * @type) + (stage_level - 1)
    #経験値
    @exp = rand(1..10) + (@type * 15) + ((stage_level - 1) * 15)
    #整数調整
    @hp = @hp.to_i
    @power = @power.to_i
    @def = @def.to_i
    @brain = @brain.to_i
    @speed = @speed.to_i
    @exp = @exp.to_i
  end
  #HPチェック用
  def check_hp
    return @hp
  end
  def debug
    font = Font.new(32) #MS明朝
    Window.draw_font(400, 200, "hp : #{@hp}, power : #{@power}", font, color:[0,0,0],z:11)
    Window.draw_font(400, 240, "def : #{@def}, speed : #{@speed}", font, color:[0,0,0],z:11)
    Window.draw_font(400, 280, "brain : #{@brain}, exp : #{@exp}", font, color:[0,0,0],z:11)
  end
end

#オブジェクト生成
field = Field.new
hero = Hero.new
enemy = Enemy.new

Window.loop do
  #タイトル画面
  Window.loop do

    #背景を描画
    Window.draw_morph(0,0,1024,0,1024,768,0,768,title_img)

    #マウス座標取得
    x = Input.mouse_pos_x  # マウスカーソルのx座標
    y = Input.mouse_pos_y  # マウスカーソルのy座標

    #マウス座標表示
    #Window.draw_font(100, 100, "x : #{x}, y : #{y}", font)

    #コマンド選択背景
    Window.draw_box_fill(390, 390, 630, 710, C_WHITE, z=2)
    Window.draw_box_fill(395, 395, 625, 705, C_BLACK, z=3)

    #コマンド選択
    Window.draw_font(435, 430, "はじめる", title_font, color:[255,255,255,255],z:4)
    Window.draw_font(430, 530, "エクストラ", title_font, color:[255,255,255,255],z:4)
    Window.draw_font(452, 630, "おわる", title_font, color:[255,255,255,255],z:4)

    #はじめる
    if x >= 435 && x <= 595 && y >= 430 && y <= 470
      #コマンド選択画像
      Window.draw_box(425, 420, 590, 480, C_WHITE, z=4)
      if Input.mousePush?(M_LBUTTON)
        break
      end
    end

    #エクストラ
    if x >= 430 && x <= 630 && y >= 530 && y <= 570
      #コマンド選択画像
      Window.draw_box(420, 520, 605, 580, C_WHITE, z=4)
      if Input.mousePush?(M_LBUTTON)
        exit(0)
      end
    end

    #おわる
    if x >= 452 && x <= 572 && y >= 630 && y <= 670
      #コマンド選択画像
      Window.draw_box(442, 620, 571, 680, C_WHITE, z=4)
      if Input.mousePush?(M_LBUTTON)
        exit(0)
      end
    end

  end

  #初期キャラ設定
  #{見た目->最低でも各性別から1人入るようにランダム、名前->入力式、役職(特性)など}
  #{ステータスは役職ごとの一定範囲内で乱数}
  #{レベル制、お金あり}

  #変数等準備
  is_select_num = nil #どのキャラが選択されたか

  #選択画面
  Window.loop do

    #背景を描画
    Window.draw_morph(0,0,1024,0,1024,768,0,768,chara_pick)

    #下の枠
    Window.draw_box_fill(80, 580, 946, 730, C_WHITE, z=0)

    #キャラの顔
    Window.draw_morph(80,80,280,80,280,280,80,280,woman1_normal)
    Window.draw_morph(420,80,620,80,620,280,430,280,woman2_normal)
    Window.draw_morph(760,80,960,80,960,280,760,280,woman3_normal)
    Window.draw_morph(80,350,280,350,280,550,80,550,man1_normal)
    Window.draw_morph(420,350,620,350,620,550,430,550,man2_normal)
    Window.draw_morph(760,350,960,350,960,550,760,550,man3_normal)

    #マウス座標取得
    x = Input.mouse_pos_x  # マウスカーソルのx座標
    y = Input.mouse_pos_y  # マウスカーソルのy座標
 
    #マウス座標表示
    #Window.draw_font(100, 100, "x : #{x}, y : #{y}", font) 

    #カーソルが合った場合
    if x >= 80 && x <= 280 && y >= 80 && y <= 280 #左上
      Window.draw_font(110, 600, "【天使】", intro_font, color:[255,0,0], z:1)
      Window.draw_font(110, 640, "ターンごとに一定確率でHPを回復できます。", intro_font, color:[0,0,0], z:2)
      Window.draw_font(110, 680, "ステータスのバランスが良く、初心者向きです。", intro_font, color:[0,0,0], z:3)
      Window.draw_morph(80,80,280,80,280,280,80,280,red_frame)
      if Input.mousePush?(M_LBUTTON)
        is_select_num = 0 #天使
        break
      end
    elsif x >= 420 && x <= 620 && y >= 80 && y <= 280 #上段真ん中
      Window.draw_font(110, 600, "【迷い人】", intro_font, color:[255,0,0], z:1)
      Window.draw_font(110, 640, "回避確率が非常に高く、防御力が高めです。", intro_font, color:[0,0,0], z:2)
      Window.draw_font(110, 680, "攻撃はやや低めのため、序盤は苦戦するかもしれません。", intro_font, color:[0,0,0], z:3)
      Window.draw_morph(420,80,620,80,620,280,430,280,red_frame)
      if Input.mousePush?(M_LBUTTON)
        is_select_num = 1 #迷い人
        break
      end
    elsif x >= 760 && x <= 960 && y >= 80 && y <= 280 #右上
      Window.draw_font(110, 600, "【魔法研究者】", intro_font, color:[255,0,0], z:1)
      Window.draw_font(110, 640, "MPと頭脳がとても高く、魔法に特化しています。", intro_font, color:[0,0,0], z:2)
      Window.draw_font(110, 680, "その分、物理的な攻撃には弱いので、注意が必要です。", intro_font, color:[0,0,0], z:3)
      Window.draw_morph(760,80,960,80,960,280,760,280,red_frame)
      if Input.mousePush?(M_LBUTTON)
        is_select_num = 2 #魔法研究者
        break
      end
    elsif x >= 80 && x <= 280 && y >= 350 && y <= 550 #左下
      Window.draw_font(110, 600, "【勇者】", intro_font, color:[255,0,0], z:1)
      Window.draw_font(110, 640, "クリティカル率が非常に高く、攻撃力も高いです。", intro_font, color:[0,0,0], z:2)
      Window.draw_font(110, 680, "ステータスはやや攻撃寄りですが、バランス型です。", intro_font, color:[0,0,0], z:3)
      Window.draw_morph(80,350,280,350,280,550,80,550,red_frame)
      if Input.mousePush?(M_LBUTTON)
        is_select_num = 3 #勇者
        break
      end
    elsif x >= 420 && x <= 620 && y >= 350 && y <= 550 #下段真ん中
      Window.draw_font(110, 600, "【信仰者】", intro_font, color:[255,0,0], z:1)
      Window.draw_font(110, 640, "神からの啓示で、先制を取りやすくなります。", intro_font, color:[0,0,0], z:2)
      Window.draw_font(110, 680, "また、お金のドロップ量が比較的高めに設定されています。", intro_font, color:[0,0,0], z:3)
      Window.draw_morph(420,350,620,350,620,550,430,550,red_frame)
      if Input.mousePush?(M_LBUTTON)
        is_select_num = 4 #信仰者
        break
      end
    elsif x >= 760 && x <= 960 && y >= 350 && y <= 550 #右下
      Window.draw_font(110, 600, "【旅人】", intro_font, color:[255,0,0], z:1)
      Window.draw_font(110, 640, "長年の討伐経験から、経験値の取得率が高くなっています。", intro_font, color:[0,0,0], z:2)
      Window.draw_font(110, 680, "ただし、初期ステータスは低めに設定されています。", intro_font, color:[0,0,0], z:3)
      Window.draw_morph(760,350,960,350,960,550,760,550,red_frame)
      if Input.mousePush?(M_LBUTTON)
        is_select_num = 5 #旅人
        break
      end
    else #デフォルト
      Window.draw_font(110, 600, "【キャラ選択】", intro_font, color:[255,0,0], z:1)
      Window.draw_font(110, 640, "戦闘中のキャラの見た目を選択できます。", intro_font, color:[0,0,0], z:2)
      Window.draw_font(110, 680, "キャラには固有の役職と能力があり、様々な作戦を取ることができます。", intro_font, color:[0,0,0], z:3)
    end

  end

  #主人公タイプ設定
  hero.set_hero_level(is_select_num)

  #変数等準備
  diff_level = 0

  #選択画面
  Window.loop do

    #背景を描画
    Window.draw_morph(0,0,1024,0,1024,768,0,768,chara_pick)

    #下の枠
    Window.draw_box_fill(80, 580, 946, 730, C_WHITE, z=0)

    #マウス座標取得
    x = Input.mouse_pos_x  # マウスカーソルのx座標
    y = Input.mouse_pos_y  # マウスカーソルのy座標
 
    #マウス座標表示
    #Window.draw_font(100, 100, "x : #{x}, y : #{y}", font) 

    #3つの枠
    Window.draw_box_fill(360,  80, 660, 190, C_GREEN, z=1)
    Window.draw_box_fill(360,  250, 660, 360, C_BLUE, z=1)
    Window.draw_box_fill(360,  420, 660, 530, C_RED, z=1)

    #白四角
    Window.draw_box_fill(370,  90, 650, 180, C_WHITE, z=2)
    Window.draw_box_fill(370,  260, 650, 350, C_WHITE, z=2)
    Window.draw_box_fill(370,  430, 650, 520, C_WHITE,  z=2)

    #表示
    Window.draw_font(431, 120, "かんたん", title_font, color:[0,240,0], z:3)
    Window.draw_font(431, 290, "へいぼん", title_font, color:[0,0,240], z:3)
    Window.draw_font(432, 460, "きびしい", title_font, color:[240,0,0], z:3)

    #カーソル判定表示
    if x >= 360 && x <= 660 && y >= 80 && y <= 190
      Window.draw_font(110, 600, "【かんたん】", intro_font, color:[0,240,0], z:1)
      Window.draw_font(110, 640, "敵の攻撃力と最大HPが低下します。", intro_font, color:[0,0,0], z:2)
      Window.draw_font(110, 680, "初心者向けの難易度です。", intro_font, color:[0,0,0], z:3)
      if Input.mousePush?(M_LBUTTON)
        diff_level = 1 #かんたん
        break
      end
    elsif x >= 360 && x <= 660 && y >= 250 && y <= 360
      Window.draw_font(110, 600, "【へいぼん】", intro_font, color:[0,0,240], z:1)
      Window.draw_font(110, 640, "敵は全員標準状態に設定されます。", intro_font, color:[0,0,0], z:2)
      Window.draw_font(110, 680, "1度はプレイされた方向けの難易度です。", intro_font, color:[0,0,0], z:3)  
      if Input.mousePush?(M_LBUTTON)
        diff_level = 2 #へいぼん
        break
      end
    elsif x >= 360 && x <= 660 && y >= 420 && y <= 530
      Window.draw_font(110, 600, "【きびしい】", intro_font, color:[240,0,0], z:1)
      Window.draw_font(110, 640, "敵の攻撃力と最大HPが大幅に増加します。", intro_font, color:[0,0,0], z:2)
      Window.draw_font(110, 680, "熟練者でもかなり厳しい難易度です。", intro_font, color:[0,0,0], z:3)  
      if Input.mousePush?(M_LBUTTON)
        diff_level = 3 #きびしい
        break
      end
    else
      Window.draw_font(110, 600, "【難易度選択】", intro_font, color:[255,0,0], z:1)
      Window.draw_font(110, 640, "このゲームの難易度を選択できます。", intro_font, color:[0,0,0], z:2)
      Window.draw_font(110, 680, "キャラに合わせた難易度を選択することも大切です。", intro_font, color:[0,0,0], z:3)  
    end

    #難易度登録
    field.set_enemy_level(diff_level)

  end

  #バトル本番
  #{ターン制コマンドバトル・一定確率で商人->貯めたお金でバトル}
  #{たたかう(商品を買う)、にげる}
  #{逃げる...敵または商人からチェンジ}

  #ターンをリセット
  #field.new_battle

  #主人公を生成
  hero.set_status

  #field.new_battle
  #enemy.set_enemy
  #enemy.set_status(diff_level)

  #Window.close

  #「逃げる」フラグ
  is_escaped = nil

  #「ぼうぎょ」コマンド
  is_def = nil
  before_def = 0

  first = true

  Window.update

  #メインループ
  Window.loop do
    
    if enemy.hp <= 0
      #hero.exp += enemy.exp
      #is_escaped = nil
      if is_escaped != true && first != true#逃げたときは経験値が入らない
        #Window.update
        field.finished_battle(hero,enemy,field)
        Window.update
        field.exp_calc(hero,enemy,field)
        Window.update
      end
      first = nil
      field.new_battle
      enemy.set_enemy
      enemy.set_status(diff_level)
    end

    #速度比較
    #debug
    hero.speed += 100
    if hero.speed >= enemy.speed #自分が先制
      #ターン表示
      field.print_turn(hero,enemy,field)
      #自分のターン
      #選択画面
      Window.loop do
        #コマンド選択後か
        is_selected = nil
        #逃げたか
        is_escaped = nil
        #背景を描画
        Window.draw_morph(0,0,1024,0,1024,768,0,768,title_img)
        #敵を描画
        enemy.print_enemy
        #マウス座標取得
        x = Input.mouse_pos_x  # マウスカーソルのx座標
        y = Input.mouse_pos_y  # マウスカーソルのy座標
        #こうどう選択枠
        #バトル枠表示
        field.print_battle(hero,enemy,field)
        #コマンド枠
        if x >= 172 && x <= 284 && y >= 545 && y <= 573 #こうげき
          Window.draw_box(162, 535, 284, 583, C_WHITE, z=5)
          if Input.mousePush?(M_LBUTTON)
            #内容選択
            Window.loop do
              #背景を描画
              Window.draw_morph(0,0,1024,0,1024,768,0,768,title_img)
              #debug
              enemy.debug
              #敵を描画
              enemy.print_enemy
              #バトル枠表示
              field.print_battle(hero,enemy,field)
              #マウス座標取得
              x = Input.mouse_pos_x  # マウスカーソルのx座標
              y = Input.mouse_pos_y  # マウスカーソルのy座標
              #たたかう選択枠
              Window.draw_box(162, 535, 284, 583, C_WHITE, z=5)
              #選択枠
              Window.draw_box_fill(460, 465, 886, 725, C_BLACK, z=6) #黒で塗りつぶす
              #HPとMP
              Window.draw_font(490,491,"HP : #{hero.hp} / #{hero.hp_max}", print_font, color:[255,255,255,255],z:7)
              Window.draw_font(670,491,"MP : #{hero.mp} / #{hero.mp_max}", print_font, color:[255,255,255,255],z:7)
              #キャラごとに表示
              hero.print_skill
              #わざ選択枠
              #Window.draw_font(475,541,"通常攻撃 : MP 0", print_font, color:[255,255,255,255],z:8)
              #Window.draw_font(655,541," 強攻撃  : MP 1", print_font, color:[255,255,255,255],z:8)
              if x >= 475 && x <= 625 && y >= 541 && y <= 561 #通常攻撃
                Window.draw_box(465, 531, 630, 571, C_WHITE, z=8)
                if Input.mousePush?(M_LBUTTON)
                  is_selected = true
                  hero.calc_damage(hero,enemy,field,0,0)
                  break
                end
              elsif x >= 655 && x <= 805 && y >= 541 && y <= 561 #強攻撃
                Window.draw_box(645, 531, 810, 571, C_WHITE, z=8)
                if Input.mousePush?(M_LBUTTON)
                  hero.mp -= 1
                  is_selected = true
                  hero.calc_damage(hero,enemy,field,0,1)
                  break
                end
              end
            end
          end
        elsif x >= 173 && x <= 285 && y >= 605 && y <= 633 #ぼうぎょ
          Window.draw_box(163, 595, 275, 643, C_WHITE, z=5)
          if Input.mousePush?(M_LBUTTON)
            before_def = hero.def
            hero.def *= 2 #防御2倍
            is_def = true
            break
          end
        elsif x >= 183 && x <= 267 && y >= 665 && y <= 693 #にげる
          Window.draw_box(173, 655, 275, 703, C_WHITE, z=5)
          if Input.mousePush?(M_LBUTTON)
            enemy.hp = 0 #敵を消去
            is_escaped = true #逃げた
            break
          end
        end
        #こうどう内容まで選択されていたらbreak
        if is_selected != nil
          break
        end
      end
      #敵の行動
    else #相手の先制
      #敵の行動
      #自分の行動
    end

    #防御UPを解除
    if is_def == true
      hero.def = before_def
      is_def = nil
    end

    #ターンを進める
    field.turn_cnt

  end

end
