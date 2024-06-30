/**
 * 
 * LiquidFunProcessing | 著作権 2017 Thomas Diewald - www.thomasdiewald.com
 * 
 * https://github.com/diwi/LiquidFunProcessing.git
 * 
 * Processing用のBox2d / LiquidFunライブラリ。
 * MITライセンス: https://opensource.org/licenses/MIT
 * 
 */


import com.thomasdiewald.liquidfun.java.DwWorld;

import org.jbox2d.collision.shapes.CircleShape;
import org.jbox2d.collision.shapes.PolygonShape;
import org.jbox2d.common.Vec2;
import org.jbox2d.dynamics.Body;
import org.jbox2d.dynamics.BodyDef;
import org.jbox2d.dynamics.BodyType;
import org.jbox2d.dynamics.FixtureDef;
import org.jbox2d.particle.ParticleGroupDef;
import org.jbox2d.particle.ParticleType;

import processing.core.*;
import processing.opengl.PGraphics2D;


  //
  // 詳細な例
  // このライブラリの他のすべての例も、ここで示されている構造とまったく同じです。
  // 
  // セットアップ:
  //   1) 初期化
  //      新しいワールドが作成され、ボディ/ジョイント/粒子がこのワールドに追加されます
  // 
  // 描画:
  //   1) 更新
  //      ワールドが更新されます（物理シミュレーションステップ）
  //      ボディ、ジョイント、粒子はすべて内部で更新されます
  //   2) レンダリング
  //
  //
  // 参照: 
  // 
  // - jBox2d リファレンス:
  //   http://thomasdiewald.com/processing/libraries/jbox2d-2.3.0/doc/index.html
  
  // - LiquidFunProcessing リファレンス:
  //   http://thomasdiewald.com/processing/libraries/liquidfun/reference/index.html
  //
  //
  // チュートリアル:
  //
  // - Box2D チュートリアル:
  //   http://www.iforce2d.net/b2dtut/
  //
  // - LiquidFun ガイド:
  //   http://google.github.io/liquidfun/Programmers-Guide/html/index.html
  //
  //
  //
  // コントロール:
  //
  // LMB         ... ボディをドラッグ
  // LMB + SHIFT ... 弾を発射
  // MMB         ... 粒子を追加
  // RMB         ... 粒子を削除
  // 'r'         ... リセット
  // 't'         ... 物理更新/一時停止
  // 'f'         ... デバッグ描画の切り替え
  //
  

  // ウィンドウの寸法
  int viewport_w = 1280;
  int viewport_h = 720;
  // ウィンドウの位置
  int viewport_x = 230;
  int viewport_y = 0;
  
  // プログラムフローを制御するためのいくつかの状態変数
  boolean UPDATE_PHYSICS = true;  // キー 't' ... 有効/無効
  boolean USE_DEBUG_DRAW = false; // キー 'f' ... 有効/無効

  // メインのワールドオブジェクト、すべてのボディ/ジョイント/粒子/マウスアクションなどが含まれています。
  DwWorld world;
  
  
  public void settings(){
    // P2D レンダラー（OpenGL）
    size(viewport_w, viewport_h, P2D);
    // いくつかのMSAAアンチエイリアシング
    smooth(8); 
  }
  
  
  public void setup(){ 
    surface.setLocation(viewport_x, viewport_y);
    
    // シーンを初期化、キー 'r' が押されると reset() も呼び出されます
    reset();
    
    frameRate(30);
  }
  
  
  // （重要）新しいワールドを作成する前に常に既存のワールドを解放します
  // これにより、DwWorldによって管理されるすべてのリソース（粒子のレンダリングに使用されるOpenGLバッファなど）が解放されます。
  public void release(){
    if(world != null) world.release(); world = null;  
  }
  
  
  public void reset(){
    // 新しいワールドを作成する前に古いリソースを解放
    release();
    
    // 新しいBox2dワールドを作成、スケールは20
    world = new DwWorld(this, 20);

    // シーンを作成:剛体、粒子など...
        initScene();
  }
  
  
  public void draw(){
    
    // 物理シミュレーションを更新
    if(UPDATE_PHYSICS){
      
      // ワールドに動的にボディを追加
      addBodies();
      
      // 次の更新ステップ
      world.update();
      
      // 次の更新ステップをより細かく制御したい場合は、次のようにしてください
      // world.update(timestep, iter_velocity, iter_position);
    }

    // キャンバスはボディ/ジョイント/粒子のレンダリングの対象です。
    // この例では、単なる主要なPGraphics "this.g" ですが、ポストプロセッシングが適用されている場合はオフスクリーンレンダリング対象になります。
    PGraphics2D canvas = (PGraphics2D) this.g;
    
    // 背景
    canvas.background(32);
    
    // 現在の行列をプッシュ
    canvas.pushMatrix();
    
    // Box2dマトリックスを適用
    // Box2dワールドには独自の座標系（原点、スケール）があり、この例ではDwWorldの初期化時に自動的に設定されます。
    // カスタムの変換も設定できます（リファレンスを参照）：
    // - world.transform.setCamera(x, y, scale);
    // - world.transform.setScreen(dim_x, dim_y, scale, origin_x, origin_y)
    // - ... など
    world.applyTransform(canvas);
    
    // 弾が発射された場合（LMB + SHIFT + マウスドラッグ）、弾は自動的に
    // world.bodiesシーングラフに追加され、内部で管理されます。
    // ただし、スポーンアニメーションは実際にはBox2dエンティティではなく、
    // したがって独自のレンダーコールが必要です。... または完全に無視できます。
    world.drawBulletSpawnTrack(canvas);
    
    // すべてのボディ/ジョイント/粒子をレンダリング
    if(USE_DEBUG_DRAW){
      
      // デバッグ描画は開発中にすべてを描画する非常に便利な方法です。
      // 次のフラグが使用できます：
      //   DebugDraw.e_shapeBit            ... 形状を描画
      //   DebugDraw.e_jointBit            ... ジョイントを描画
      //   DebugDraw.e_aabbBit             ... 直交軸に対魅力的なボックスを描画
      //   DebugDraw.e_pairBit             ... 接続されたオブジェクトのペアを描画
      //   DebugDraw.e_centerOfMassBit     ... 質量中心フレームを描画
      //   DebugDraw.e_dynamicTreeBit      ... ダイナミックツリーを描画
      //   DebugDraw.e_wireframeDrawingBit ... ワイヤーフレームのみを描画
      //     
      //   world.debug_draw.setFlags(DebugDraw.e_shapeBit | DebugDraw.e_jointBit);
      
      //   world.debug_draw.appendFlags(flags);
      //   world.debug_draw.clearFlags(flags);
      
      world.displayDebugDraw(canvas);
      // DwDebugDraw.display(canvas, world); // 代替方法
      
    } else {
      
      // Box2dワールドの一部であるすべてのボディ/ジョイント/粒子のデフォルトのレンダリング。
      world.display(canvas);
      
      // 代替として、ボディ/ジョイントおよび粒子を別々にレンダリングできます
      // world.bodies.display(canvas);    // ... ボディとジョイントをレンダリング
      // world.particles.display(canvas); // ... 粒子をレンダリング
      
      // より分離が必要な場合は、デフォルトのworld.bodiesシーングラフの隣に
      // カスタムDwBodyGroupインスタンスを使用できます。

      // 粒子は、例を参照してください
      // liquidfun_ParticleRenderGroups*
    }
    
    
    // 行列を復元
    canvas.popMatrix();
    
    
    // 情報、ウィンドウのタイトル
    int num_bodies    = world.getBodyCount();
    int num_particles = world.getParticleCount();
    String txt_fps = String.format(getClass().getName()+ " [ボディ: %d]  [粒子: %d]  [fps %6.2f]", num_bodies, num_particles, frameRate);
    surface.setTitle(txt_fps);
  }
  


  
  //////////////////////////////////////////////////////////////////////////////
  // ユーザーインタラクション
  //////////////////////////////////////////////////////////////////////////////

  public void keyReleased(){
    if(key == 'r') reset();
    if(key == 't') UPDATE_PHYSICS = !UPDATE_PHYSICS;
    if(key == 'f') USE_DEBUG_DRAW = !USE_DEBUG_DRAW;
  }
  

  
  //////////////////////////////////////////////////////////////////////////////
  // シーンのセットアップ
  //////////////////////////////////////////////////////////////////////////////

  public void initScene() {
    
    // 推奨される読み物：
    //
    // http://www.iforce2d.net/b2dtut/bodies
    // http://www.iforce2d.net/b2dtut/fixtures
    //
    // http://google.github.io/liquidfun/Programmers-Guide/html/md__chapter06__bodies.html
    // http://google.github.io/liquidfun/Programmers-Guide/html/md__chapter07__fixtures.html
    //
    
    // Box2dには独自の座標系があります。
    float screen_scale = world.transform.screen_scale;
    float bdimx = world.transform.box2d_dimx;
    float bdimy = world.transform.box2d_dimy;
    float bhick = 20 / screen_scale;

    // 静的な地面のボディを作成
    { 
      
      // 1.0) 新しいボディを作成 
      //      ボディは基本的に抽象的な物理的属性の集まりです：
      //      速度（角速度、線形速度）、位置、質量など...
      //      http://www.iforce2d.net/b2dtut/bodies
      
      // 1.1) BodyDef 
      //      新しいボディを作成するために必要なすべての情報を含みます
      BodyDef bd = new BodyDef();

      // 1.2) 実際のボディを作成
      Body ground = world.createBody(bd);

      
      
      
      // 2.0) このボディ用のフィクスチャを作成
      //      ボディには形状、密度などの他の物理的プロパティが必要です。
      //      http://www.iforce2d.net/b2dtut/fixtures
      
      // 2.1) 形状を作成
      PolygonShape sd = new PolygonShape();
      
      // ... この場合はボックスの形をした多角形形状
      sd.setAsBox(bdimx/4f, bhick/2f, new Vec2(8, 10), 0);
      
      // 2.2) このボディのフィクスチャを作成
      //      密度は0に設定されており、これによりこのボディが静的になります（質量がゼロです）
      ground.createFixture(sd, 0);
 
      // ... 別のボックス、別の位置
      sd.setAsBox(bdimx/4f, bhick/2f, new Vec2(-8, 2), 0);
      
      // 2.3) このボディの別のフィクスチャを作成
      //      密度は0に設定されており、これによりこのボディが静的になります（質量がゼロです）
      ground.createFixture(sd, 0);
      
      
      
      // 3.0) レンダリングのためにボディをシーングラフに追加
      world.bodies.add(ground, true, color(0), !true, color(0), 1f);
    }
    
    
    
    
    
    // 粒子を作成
    {
      // 1) シミュレーションのための粒子の設定
      world.setParticleRadius(0.15f);
      world.setParticleDamping(1);
      // world.setParticle...(...);
      
      // 2) レンダリングのための粒子の設定
      world.particles.param.tex_sprite   = null;
      world.particles.param.falloff_exp1 = 4f;
      world.particles.param.falloff_exp2 = 1f;
      world.particles.param.falloff_mult = 1f;
      world.particles.param.radius_scale = 1f;
      world.particles.param.color_mult   = 1f;
      
      // マウスで生成された粒子に対するカスタムの色を設定
      world.mouse_spawn_particles.group_def.setColor(color(64,255,0));
      
      
      
      // 3) 粒子（または粒子グループ）を作成
      
      // 粒子が生成される形状
      PolygonShape pshape = new PolygonShape();
      
      // 粒子（グループ）の定義
      ParticleGroupDef pd = new ParticleGroupDef();  
      pd.shape = pshape;
      pd.flags = 0
         | ParticleType.b2_waterParticle
         | ParticleType.b2_viscousParticle
//         | ParticleType.b2_colorMixingParticle
//         | ParticleType.b2_powderParticle
//         | ParticleType.b2_springParticle
//         | ParticleType.b2_tensileParticle
         ;
      
      float sx = bdimx * 0.10f;
      float sy = bdimy * 0.25f;
      
      // 形状を設定
      pshape.setAsBox(sx, sy, new Vec2(-sx, bdimy), 0);
      // 色を設定
      pd.setColor(color(0, 64, 255));
      // 新しい粒子グループを作成
      world.createParticleGroup(pd);
      
      // 形状を設定
      pshape.setAsBox(sx, sy, new Vec2(+sx, bdimy), 0);
      // 色を設定
      pd.setColor(color(255, 64, 0));
      // 新しい粒子グループを作成
      world.createParticleGroup(pd);
    }
    
    
  }
  
  
  
  
  
  // ボディカウンター、色の遷移を作成するため
  int body_count = 0;
  

  public void addBodies(){
    // 20フレームごとに新しいボディを追加
    if(frameCount % 20 == 0){
      addBody();
    }
  }
  
  public void addBody(){
    
    // 推奨される読み物：
    //
    // http://www.iforce2d.net/b2dtut/bodies
    // http://www.iforce2d.net/b2dtut/fixtures
    
    
    // Box2dには独自の座標系があります。
    float screen_scale = world.transform.screen_scale;
    float bdimx = world.transform.box2d_dimx;
    float bdimy = world.transform.box2d_dimy;
    float bhick = 20 / screen_scale;
    
    
    // ボディの位置とサイズ
    float x = 0;
    float y = bdimy;
    float w = random(0.5f, 2.2f);
    float h = random(0.5f, 1.2f);
    
    // 新しいBodyDefinitionを作成
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(x, y);
    
    // BodyDefを使用して新しいボディを作成
    Body body = world.createBody(bd);
    
    
    // 新しいFixtureDefinitionを作成
    FixtureDef fd = new FixtureDef();
    fd.density = 1f;
    fd.friction = 0.1f;
    fd.restitution = 0.2f;
    
    // このFixtureのために円形またはボックス形状をランダムに選択
    if (random(1) < 0.5) {
      PolygonShape pshape = new PolygonShape();
      pshape.setAsBox(w, h, new Vec2(0, 0), random(TWO_PI));
      fd.shape = pshape;
    } else {
      CircleShape cshape = new CircleShape();
      cshape.m_p.set(0, 0);
      cshape.m_radius = w / 2f;
      fd.shape = cshape;
    }
 
    // FixtureDefを使用して新しいFixtureを作成
    body.createFixture(fd);

    // HSBカラーモードに設定
    colorMode(HSB, 360, 100, 100);

    // カラーコンポーネントを作成
    float r = body_count % 360;
    float g = 100;
    float b = 100;
    
    // ボディをレンダリングのためのシーングラフに追加
    world.bodies.add(body, true, color(r, g, b), true, color(r, g, b * 0.5f), 1f);
    
    // カラーモードをRGBにリセット
    colorMode(RGB, 255);
    
    // カウンタを増やす
    body_count++;
}
