import controlP5.*;

//オブジェクト宣言
State state;                //画面遷移用
MainCalender maincal;       //カレンダーページ
ControlP5 controlP5;        //controlP5
TodoList todo;
//MainCircle maincir;

//各種宣言
boolean ClassSetUp;         //各クラスでのセットアップフラグ/
char[] ltxt=new String("NowLoading").toCharArray();//ロード画面用
PImage icon001, icon002, icon003, icon004, icon005, icon006, icon007, icon008;//やることリスト、ついったー、カレンダー、めも、設定,任意
PFont Font001, Font002, Font003, Font004;     //（フォントデータ）
int mouseKey = 0;           //マウス
String [] Setpos;           //円の座標をテキストにあげるための配列
String[] Sub;          //やることリストが入ってる
boolean[] selecttodo;//やることリスト一個一個のフラグ。フラグたつと、詳細表示画面に飛ぶ。
String Label;              //やることリスト詳細表示ページに飛ぶときのタイトル帯に日付保存する用
int prepage;               // 複数のページから飛んでくる可能性があるページには、きちんと前のページに戻れるようにしたいなって。
int nextpage;              //画面遷移先が複数あるときに数字で次を決めたい
int dispy, dispm, dispd;     //やることリスト詳細を表示するときに値をいれる

//キーボード類
String[] KeyBodeText;
int[] KeyBodeX;
int[] KeyBodeY;
int[] KeyBodeWidth;
int[] KeyBodeHeight;
String[] LoadFile;
int KeyType ;
String textnow, Lefttext, Ligthtext, disptext;
float mx, my;
int KeyShift, NowLine;
boolean keyshift;
boolean textinputstart;

float D=0, S=0;

boolean addi;

String []labelmemo;
String memoadd="";
//漢字変換
void setup() {
  size(480, 640);

 // labelmemo={""};
  controlP5 = new ControlP5(this);
  //変化開始

  ClassSetUp=true;


  //各々のロード
  //フォント類
  Font001 = createFont("HG創英ﾌﾟﾚｾﾞﾝｽEB", 24, true);//なんかはんなりひらがなみたいなやつかわいいのでいれたなお使用できないもよう
  Font002 =  createFont("Malgun Gothic", 24, true);//なんで漢字出てくれないの切れそう
  Font003=createFont("HGP創英ﾌﾟﾚｾﾞﾝｽEB", 24, true);//なお使用できない模様
  Font004=createFont("游ゴシック Light", 24, true);
  textFont(Font001, 24);
  textFont(Font002, 24);
  textFont(Font003, 24);
  textFont(Font004, 24);
  //テキスト類
  Setpos=loadStrings("data/MainManu_Circle_position.txt");
  Sub =loadStrings("fuck.txt");



  //画像類
  icon001=loadImage("image/カレンダー.png");
  icon002=loadImage("image/メモ.png");
  icon003=loadImage("image/羽つきペン.png");
  icon004=loadImage("image/やることリスト追加.png");//やること追加
  icon005=loadImage("image/設定.png");
  icon006=loadImage("image/メモの無料アイコン.png");//7day
  icon007=loadImage("image/twitterのアイコン素材.png");
  icon008=loadImage("image/サーチアイコン.png");

  state=new MainHome();     //画面遷移の最初に表示させる場所指定

  ResetKeybode();
  println(Numbertodo(2019, 7, 24));
}

void draw() {
  mx=mouseX;
  my=mouseY;
  smooth();
  state=state.doState();
}

abstract class State {
  State() {
  }
  State doState() {
    drawState();
    return decideState();
  }
  abstract void drawState();
  abstract State decideState();
}
