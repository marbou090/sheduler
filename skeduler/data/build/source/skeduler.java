import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import controlP5.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class skeduler extends PApplet {



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
String[] Sub=null;          //やることリストが入ってる
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
int KeyType = 1;
String textnow, settletext, text;
float mx, my;
int KeyShift;
boolean keyshift;

public void setup() {
  
  controlP5 = new ControlP5(this);
  ClassSetUp=true;


  //各々のロード
  //フォント類
  Font001 = createFont("HG創英ﾌﾟﾚｾﾞﾝｽEB", 24, true);//なんかはんなりひらがなみたいなやつかわいいのでいれた
  Font002 =  createFont("Malgun Gothic", 24, true);//なんで漢字出てくれないの切れそう
  Font003=createFont("HGP創英ﾌﾟﾚｾﾞﾝｽEB", 24, true);
  Font004=createFont("游ゴシック Light", 24, true);
  textFont(Font001, 24);
  textFont(Font002, 24);
  textFont(Font003, 24);
  textFont(Font004, 24);
  //テキスト類
  Setpos=loadStrings("MainManu_Circle_position.txt");
  Sub =loadStrings("fuck.txt");

  //画像類
  icon001=loadImage("カレンダー.png");
  icon002=loadImage("メモ.png");
  icon003=loadImage("やることリスト.png");
  icon004=loadImage("枠つきの羽根ペンのアイコン素材 (1).png");
  icon005=loadImage("設定.png");
  icon006=loadImage("手帳のアイコン素材.png");
  icon007=loadImage("twitterのフリーアイコン素材.png");
  icon008=loadImage("サーチアイコン.png");
 
  state=new MainHome();     //画面遷移の最初に表示させる場所指定
  
  ResetKeybode();
}

public void draw() {
  mx=mouseX;
  my=mouseY;
  smooth();
  state=state.doState();
}

abstract class State {
  State() {
  }
  public State doState() {
    drawState();
    return decideState();
  }
  public abstract void drawState();
  public abstract State decideState();
}
class AddToDo extends State {
  public void drawState() {
    if (ClassSetUp) {
      //キーボードの初期化
      keyshift=false;
      KeyShift=0;
      mouseKey=0;
      ResetKeybode();
      textnow="";
      settletext="";
      text="";
      mouseKey=0;

      addtodo=new SubAddToDo();
      ClassSetUp=false;
    }
    Backcolor(0xff0F4993, 0xff88AEDE);
    addtodo.showaddpage();
  }
  public State decideState() {
    if (mouseKey==1&&mouseX>25&&mouseX<70&&mouseY>20&&mouseY<65) {
      controlP5.remove("BackPage");
      ClassSetUp=true;
      return new Main_ToDoList();
    }
    return this;
  }
}

SubAddToDo addtodo;
class SubAddToDo {
  boolean[] kindselect=new boolean[3];//追加するTODOの種類を決定するためのフラグ
  boolean textinput;
  SubAddToDo() {
    textinput=false;
    for (int i=0; i<kindselect.length; i++) {
      kindselect[i]=false;
    }
    controlP5.addButton("BackPage").setLabel("<").setPosition(25, 20).setSize(45, 45);
  }

  public void showaddpage() {
    TopLabel("Add schedule", 45, width/2, 60);

    //日付入力
    //月

    if (mouseX>50&&mouseX<180&&mouseY>180&&mouseY<230) {
      fill(255, 150);
    } else {
      fill(255, 50);
    }
    rect(50, 180, 100, 50);
    //日
    if (mouseX>240&&mouseX<340&&mouseY>180&&mouseY<230) {
      fill(255, 150);
    } else {
      fill(255, 50);
    }
    rect(240, 180, 100, 50);

    //種類選択課題その他用事
    if (mouseX>50&&mouseX<150&&mouseY>250&&mouseY<300) {
      fill(255, 150);
    } else {
      fill(255, 50);
    }
    if (kindselect[0]==false&&kindselect[1]==false&&kindselect[2]==false&&mouseX>50&&mouseX<150&&mouseY>250&&mouseY<300&&mouseKey==1) {
      kindselect[0]=true;
    }
    if (kindselect[0]) {
      fill(255, 150);
    }
    rect(50, 250, 100, 50);
    fill(0, 200);
    textAlign(LEFT);
    textSize(28);
    text("課題", 55, 285);
    if (mouseX>190&&mouseX<290&&mouseY>250&&mouseY<300) {
      fill(255, 150);
    } else {
      fill(255, 50);
    }
    if (kindselect[0]==false&&kindselect[1]==false&&kindselect[2]==false&&mouseX>190&&mouseX<290&&mouseY>250&&mouseY<300&&mouseKey==1) {
      kindselect[1]=true;
    }
    if (kindselect[1]) {
      fill(255, 150);
    }
    rect(190, 250, 100, 50);
    fill(0, 200);
    textAlign(LEFT);
    textSize(28);
    text("用事", 195, 285);
    if (mouseX>330&&mouseX<430&&mouseY>250&&mouseY<300) {
      fill(255, 150);
    } else {
      fill(255, 50);
    }
    if (kindselect[0]==false&&kindselect[1]==false&&kindselect[2]==false&&mouseX>330&&mouseX<430&&mouseY>250&&mouseY<300&&mouseKey==1) {
      kindselect[2]=true;
    }
    if (kindselect[2]) {
      fill(255, 150);
    }
    rect(330, 250, 100, 50);
    fill(0, 200);
    textAlign(LEFT);
    textSize(28);
    text("その他", 335, 285);

    //メモ
    if (mouseX>50&&mouseX<430&&mouseY>380&&mouseY<680) {
      fill(255, 150);
    } else {
      fill(255, 50);
    }
    rect(50, 320, 380, 300);
    fill(0, 200);
    textAlign(LEFT);
    textSize(28);
    text("メモを入力する", 55, 355);


    //タイトル入力場所
    if (mouseX>50&&mouseX<430&&mouseY>110&&mouseY<160) {
      fill(255, 150);
    } else {
      fill(255, 50);
    }
    if (mouseKey==1&&mouseX>50&&mouseX<430&&mouseY>110&&mouseY<160) {
      mousePressed=false;
      textinput=true;
    }
    if (textinput==true) {
      //controlP5.addButton("BackPage").setLabel("SAVE").setPosition(25, 20).setSize(45, 45);
      rect(50, 110, 380, 50);
      fill(0, 200);
      textAlign(LEFT);
      textSize(28);
      text(keybode(), 55, 145);
      println(mouseKey);
      if (mousePressed==true&&mouseX>50&&mouseX<430&&mouseY>110&&mouseY<160) {
        println("-----!!!");
        Backcolor(0xff0F4993, 0xff88AEDE);
        textinput=false;
      }
    }
    if (textinput==false) {
      rect(50, 110, 380, 50);
      fill(0, 200);
      textAlign(LEFT);
      textSize(28);
      text("タイトルを入力する", 55, 145);
    }
  }
}
/*このページに来るときに先にカレンダーの外枠だけ描いておくと楽だなぁ。
 たぶんそのときについでに曜日とかもやってあげれば楽だなぁ
 このページではどっかしら（右上）とかに予定追加のやつおいておく
 そいで「日付選択してない状態でそこ押したら任意の日にち（空っぽ）に予定追加」
 日付選択をしていたら「選択している日にちを入力した状態で予定追加」
 をする。ようにできたらな。
 「予定」「toDo」「その他」で色わける
 とぅーどぅーのクラス作ってそこに飛ばしたほうが早いなしねしねしねしねしね
 ちゃんとフルで出席できたら王冠表示しねしねしね
 */

class Calender extends State {
  public void drawState() {
    if(ClassSetUp){
            maincal=new MainCalender(0, 0);
      ClassSetUp=false;
    }
    int c1=0xff58004E;
    int c2=0xffFCD9B2;
    Backcolor(c1, c2);
    maincal.do_calender(year(), month());//常に今の表示してる月を出す
  }

  public State decideState() {//このページから離れるときにねくすと～を０に戻しておく。
    for (int i=0; i<Sub.length; i++) {
      if ( selecttodo[i]==true) {
        mouseKey=0;
        println("さすが");
        controlP5.remove("BackPage");
        controlP5.remove("hoge");
        controlP5.remove("nextCalender");
        prepage=1;
        ClassSetUp=true;
        return new thisdayTodo();//やることリストの詳細を表示する
      }
    }
    if (mouseKey==1&&mouseX>10&&mouseX<60&&mouseY>30&&mouseY<80) {
      mouseKey=0;
      controlP5.remove("BackPage");
      controlP5.remove("hoge");
      controlP5.remove("nextCalender");
      ClassSetUp=true;
      return new MainHome();
    }

    return this;
  }
}

class MainCalender {

  //変数
  int Nextyear;
  int Nextmonth;
  // public int Nextday;

  //コンストラクタ
  MainCalender(int Nextyear_, int Nextmonth_) {
    mouseKey=0;
    selecttodo=new boolean[Sub.length];
    for (int i=0; i<Sub.length; i++) {
      selecttodo[i]=false;
    }
    controlP5.addButton("BackPage").setLabel("<").setPosition(10, 30).setSize(50, 50);
    controlP5.addButton("nextCalender").setLabel("<").setPosition(width/2-90, 75).setSize(30, 30);
    controlP5.addButton("hoge").setLabel(">").setPosition(width/2+70, 75).setSize(30, 30);
    Nextyear=Nextyear_;
    Nextmonth=Nextmonth_;
  }



  //日付入力でカレンダーを描く
  public void do_calender(int Y, int M) {
    int y, m;
    nextCalender();
    y=Y+Nextyear;
    m=M+Nextmonth;
    if (m<1) {
      y=y-1;
      Nextyear=Nextyear-1;
      Nextmonth=(12-M);
      m=M+Nextmonth;
    }
    if (m>12) {
      y=y+1;
      Nextyear++;
      Nextmonth=-(M-1);
      m=M+Nextmonth;
    }

    int week=zeller(y, m, 1);//今日この日が何曜日か決めている
    int days=getDaysofMonth(y, m);//今月の日数


    //一番上に年と月を表示
    // strokeWeight(10);
    textAlign(CENTER);
    textFont(Font004,40);
    fill(255,160);
    text(y+"年", width/2, (height-5)/10);
    textSize(30);
    text(m+"月", width/2, (height-5)/10+40);
    textAlign(LEFT);

    //日付表示

    for (int i=1; i<days+1; i++) {//ここに一緒に課題や締切あったら色上にかぶせる等の処理も乗せる
      int today=day();
      int todaymonth=month();
      int todayyear=year();
      fill(255, 99);
      rect((i+week-1)%7*((width-10)/7)+7, ((i+week-1)/7+2)*((height-5)/8)-40, 60, 70);
      
      if (i==today&&m==todaymonth&&y==todayyear) {// 「今日」なら青字。たぶんここいじれば今日の日とか選択した日の強調表示できる
        fill(0, 0, 255);
      } else {// 「今日」でないなら黒字
        fill(0, 0, 0);
        int h=zeller(y, m, i);
        if (h==0&&i!=today) { // 日曜は赤字
          fill(255, 0, 0);
        }
      }
      String dd=(" "+i);
      
      textSize(20);
      textAlign(LEFT, BASELINE);
      dd=dd.substring(dd.length()-2);//文字列を右寄せっぽくする
      text(dd, (i+week-1)%7*((width-10)/7)+10, ((i+week-1)/7+2)*((height-5)/8)-10);


      //その日にタスクがあればラベルと一緒にはるよ
      for (int h=0; h<Sub.length; h++) {
        if ((TODO(Sub[h], y, m, i)!="null")) {

          int task=PApplet.parseInt(Sub[h].substring(0, 1));
          if (task==0) {
            fill(0, 0, 255, 60);
            rect((i+week-1)%7*((width-10)/7)+10, ((i+week-1)/7+2)*((height-5)/8)+7, 48, 17);
            fill(0);
            textSize(15);
            textAlign(LEFT, CENTER);
            text("課題", (i+week-1)%7*((width-10)/7)+15, ((i+week-1)/7+2)*((height-5)/8)+12);
          } else if (task==1) {
            fill(0, 255, 0, 60);
            rect((i+week-1)%7*((width-10)/7)+10, ((i+week-1)/7+2)*((height-5)/8)+7, 48, 17);
            fill(0);
            textSize(15);
            textAlign(LEFT, CENTER);
            text("その他", (i+week-1)%7*((width-10)/7)+15, ((i+week-1)/7+2)*((height-5)/8)+12);
          } else if (task==2) {
            fill(255, 0, 0, 60);
            rect((i+week-1)%7*((width-10)/7)+10, ((i+week-1)/7+2)*((height-5)/8)+7, 48, 17);
            fill(0);
            textSize(15);
            textAlign(LEFT, CENTER);
            text("用事", (i+week-1)%7*((width-10)/7)+15, ((i+week-1)/7+2)*((height-5)/8)+12);
          }
        }
      }

      //上にマウスきたら色少しだけ変えるよ
      if (mouseX>(i+week-1)%7*((width-10)/7)+7&&mouseX<(i+week-1)%7*((width-10)/7)+67&&mouseY> ((i+week-1)/7+2)*((height-5)/8)-40&& mouseY<((i+week-1)/7+2)*((height-5)/8)+30) {
        fill(0, 30);
        rect((i+week-1)%7*((width-10)/7)+7, ((i+week-1)/7+2)*((height-5)/8)-40, 60, 70);
        for (int t=0; t<Sub.length; t++) {
          if (mouseKey==1&&mouseX>(i+week-1)%7*((width-10)/7)+7&&mouseX<(i+week-1)%7*((width-10)/7)+67&&mouseY> ((i+week-1)/7+2)*((height-5)/8)-40&& mouseY<((i+week-1)/7+2)*((height-5)/8)+30) {
            Label=m+" 月 "+i+" 日 ";
            dispy=y;
            dispm=m;
            dispd=i;
            selecttodo[t]=true;
          }
        }
      }
    }
  }


  //ツェラーの公式で曜日の計算
  private int zeller(int y, int m, int d) {
    int h;
    if (m<3) {
      m+=12;
      y--;
    }
    h=(d+(m+1)*26/10+(y%100)+(y%100)/4+y/400-2*y/100)%7;
    h-=1;
    if (h<0) h+=7;
    return h;//これがその年その月その日の曜日（日曜が０で土曜が６）
  }

  // うるう年の判別
  private boolean isLeapYear(int y) {
    if (y%400==0) {
      return true;
    } else if (y%100==0) {
      return false;
    } else if (y%4==0) {
      return true;
    }
    return false;
  }

  // うるう年を考慮して「今月」の日数を求める
  private int getDaysofMonth( int y, int m) {
    final int daysOfMonth[]={31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    int days=daysOfMonth[m-1];
    if (m==2 && isLeapYear(y)) {
      days++;
    }
    return days;
  }

  //クリックしたら次の月を表示させる
  public void nextCalender() {
    boolean nextMonth=false;//次の月にいく、年にいく、前の月に戻る、年に戻る
    boolean nextYear=false;
    boolean backMonth=false;
    boolean backYear=false;
    if (mouseKey==1&&mouseX>width/2-90&&mouseX<width/2-60&&mouseY>75&&mouseY<105) {//ボタンがクリックされたらネクスト～のやつを＋１にして次のカレンダーを表示させる
      backMonth=true;
      mouseKey=0;
    }
    if (backMonth) {
      Nextmonth=Nextmonth-1;
      backMonth=false;
    }
    if (mouseKey==1&&mouseX>width/2+70&&mouseX<width/2+100&&mouseY>75&&mouseY<105) {//ボタンがクリックされたらネクスト～のやつを＋１にして次のカレンダーを表示させる
      nextMonth=true;
      mouseKey=0;
    }
    if (nextMonth) {
      Nextmonth=Nextmonth+1;
      nextMonth=false;
    }
  }
}
class DetaildayTodo extends State {
  public void drawState() {
    if (ClassSetUp) {
      subdetail=new detailday();
      ClassSetUp=false;
    }
    Backcolor(0xff0F4993, 0xff88AEDE);
    if (DetailTODO(dispy, dispm, dispd)!="null") {
      subdetail.showaddpage(dispy, dispm, dispd);
    }
  }
  public State decideState() {
    if (mouseKey==1&&mouseX>25&&mouseX<70&&mouseY>20&&mouseY<65) {
      controlP5.remove("BackPage");
      ClassSetUp=true;
      return new Main_ToDoList();
    }
    if (DetailTODO(dispy, dispm, dispd)=="null") {
      ClassSetUp=true;
      return new Main_Nextday7_ToDoList();
    }
    return this;
  }
}

detailday subdetail;
class detailday {
  boolean[] kindselect=new boolean[3];//追加するTODOの種類を決定するためのフラグ

  detailday() {
    for (int i=0; i<kindselect.length; i++) {
      kindselect[i]=false;
    }
    controlP5.addButton("BackPage").setLabel("<").setPosition(25, 20).setSize(45, 45);
  }

  public void showaddpage(int y, int m, int d) {
    TopLabel("Details of ToDo", 45, width/2, 60);
    Subdetailtodokind( y, m, d);
    DetailTODO(y, m, d);

    //タイトル入力場所
    if (mouseX>50&&mouseX<430&&mouseY>110&&mouseY<160) {
      fill(255, 150);
    } else {
      fill(255, 50);
    }
    rect(50, 110, 380, 50);
    fill(0, 200);
    textAlign(LEFT);
    textSize(28);
    text(DetailTODO(y, m, d), 55, 145);

    //日付入力
    //月
    fill(255, 50);
    rect(50, 180, 100, 50);
    //日
    fill(255, 50);
    rect(240, 180, 100, 50);

    //種類選択課題その他用事
    if (0==(Subdetailtodokind( y, m, d))) {
      fill(255, 150);
    } else {
      fill(255, 50);
    }
    rect(50, 250, 100, 50);
    fill(0, 200);
    textAlign(LEFT);
    textSize(28);
    text("課題", 55, 285);
    if (1==(Subdetailtodokind( y, m, d))) {
      fill(255, 150);
    } else {
      fill(255, 50);
      rect(190, 250, 100, 50);
      fill(0, 200);
      textAlign(LEFT);
      textSize(28);
      text("用事", 195, 285);
      if (2==(Subdetailtodokind( y, m, d))) {
        fill(255, 150);
      } else {
        fill(255, 50);
      }
      rect(330, 250, 100, 50);
      fill(0, 200);
      textAlign(LEFT);
      textSize(28);
      text("その他", 335, 285);

      //メモ
      fill(255, 50);
      rect(50, 320, 380, 300);
      fill(0, 200);
      textAlign(LEFT);
      textSize(28);
      text(DetailTODOmemo(y, m, d), 55, 355);
    }
  }
}
class MainHome extends State {
  public void drawState() {
    if (ClassSetUp) {
      
      ClassSetUp=false;
    }
    Backcolor(0xffFD9DFF,0xff62C6D8);
    // background(255);

    noStroke();
    float X=240;
    float Y=640/5;
    float stop=PI/((360/24)*hour());
    fill(0xffB7B7B7,100);
    arc(X, Y, 230, 230, -PI/2, stop);
    fill(0xffE6D5ED,180);
    ellipse(X, Y, 200, 200);
    textAlign(CENTER);
    textFont(Font004, 50);
    fill(0);//これ消すと日付等が表示されなくなりますよ気をつけて！ばかちゃん
    text(hour()+" : "+minute(), 240, 640/5);
    textFont(Font002, 24);
    text(month()+"月"+day()+"日", 240, 640/5+45);
    Draw_Circle();
  }

  public State decideState() {
    for (int i=4; i<Setpos.length; i=i+4) {
      if (ClassSetUp==false&&mouseKey==1&&sqrt(sq(mouseX-PApplet.parseFloat(Setpos[i]))+sq(mouseY-PApplet.parseFloat(Setpos[i+1])))<PApplet.parseInt(Setpos[i+3])) {
        ClassSetUp=true; 
        switch(PApplet.parseInt(Setpos[i+2])) {
        case 0://時計
          break;
        case 1://やることリスト
          return new Main_ToDoList();

        case 2://メモ
          return new Main_Memo();

        case 3://ツイッター
          return new Twitter();

        case 4://学生帽
          return new Main_Subject();

        case 5://カレンダー
          return new Calender();

        case 6://設定
          return new Main_Setting();
        }
      }
    }

    return this;
  }
}
float angle = 0.0f; //角度
public void Draw_Circle() {

  for (int i=4; i<Setpos.length; i=i+4) {
    float x=PApplet.parseFloat(Setpos[i]);
    float y=PApplet.parseFloat(Setpos[i+1]);
    int date=PApplet.parseInt(Setpos[i+2]);
    int cirl=PApplet.parseInt(Setpos[i+3]);

    angle+=0.01f;
    if (date%2!=0) {
      x = x+2*cos(-angle); //x座標の計算
      y = y+2*sin(-angle); //y座標の計算
    } else {
      x = x+2*cos(angle); //x座標の計算
      y = y+2*sin(angle); //y座標の計算
    }
    if (sqrt(sq(mouseX-PApplet.parseFloat(Setpos[i]))+sq(mouseY-PApplet.parseFloat(Setpos[i+1])))<PApplet.parseInt(Setpos[i+3])) {
      fill(241, 194, 252, 190);
    } else {
      fill(241, 194, 252, 110);
    }
    noStroke();
    ellipse(x, y, cirl, cirl);
    imageMode(CENTER);
    switch(PApplet.parseInt(Setpos[i+2])) {
    case 0://時計
      clock=new Clock();
      clock.display(x, y, cirl);
      break;
    case 1://やることリスト
      image(icon003, x, y, cirl-32, cirl-32);
      break;
    case 2://メモ
      image(icon002, x, y, cirl-32, cirl-32);
      break;
    case 3://ツイッター
      image(icon007, x, y, cirl, cirl);
      break;
    case 4://学生帽
      image(icon006, x, y, cirl-32, cirl-32);
      break;
    case 5://カレンダー
      image(icon001, x, y, 63, 63);
      break;
    case 6://設定
      image(icon005, x, y, 63, 63);
      break;
    }
  }
}

Clock clock;
class Clock {//アナログのくるくるする時計ちゃん
  Clock() {

    stroke(0);
    smooth();
    frameRate(30);
  }
  public void display(float x, float y, int cir) {//メインメニューのサークル４、５の座標打ち込んでそこにうんたら。半径も。
    //background(255);
    float s = second();
    float m = minute();
    float h = hour() % 12;

    pushMatrix();
    translate(x, y);
    ellipse(0, 0, cir, cir);


    noFill();
    stroke(0);
    /*
     pushMatrix();
     translate(i, j);
     rotate(PI / 6);
     ellipse(0, 0, 10, 20);
     popMatrix();
     */
    //秒針
    pushMatrix();
    rotate(radians(s*(360/60)));
    strokeWeight(1);
    line(0, 0, 0, -cir/2);
    popMatrix();



    //分針
    pushMatrix();
    rotate(radians(m*(360/60)));
    strokeWeight(2);
    line(0, 0, 0, -cir/2);
    popMatrix();



    //時針
    pushMatrix();
    rotate(radians(h*(360/12)));
    strokeWeight(4);
    line(0, 0, 0, -cir/3);
    popMatrix();

    popMatrix();
  }
}
/*
void backcolor() {
  color colorA= color(#FD9DFF);
  color colorB = color(#62C6D8);
  float dr = (red(colorB) - red(colorA))/height;
  float dg = (green(colorB) - green(colorA))/height;
  float db = (blue(colorB) - blue(colorA))/height;

 for(float w = 0; w < width; w += 5){
　float r = map(w, 0, width, red(c1), red(c2));
　float g = map(w, 0, width, green(c1), green(c2));
　float b = map(w, 0, width, blue(c1), blue(c2));
    fill(r, g, b);
    rect(w, 0, 5, height);
}
}
*/
//クリック
public void mousePressed() {
  if (mouseButton == LEFT) mouseKey = 1;
}

//離す
public void mouseReleased() {
  if (mouseButton == LEFT) mouseKey = 0;
}

//(これは年、日でいれてサブストリングで日付判断する等するよってことですうけるね
public String TODO(String deta, int y, int m, int d) {
  if (y==PApplet.parseInt(deta.substring(3, 7))&&m==PApplet.parseInt(deta.substring(9, 10))&&d==PApplet.parseInt(deta.substring(11, 13))) {
    String show[]=split(deta, ",");
    return show[4]; //ここでその日のやることデータを吐き出す。
  } else {
    return "null";
  }
}

public String DetailTODO(int y, int m, int d) {//これがぬるを吐く＝＝その日にタスクはない
  String Disp="";
  for (int t=0; t<Sub.length; t++) {
    if (y==PApplet.parseInt(Sub[t].substring(3, 7))&&m==PApplet.parseInt(Sub[t].substring(9, 10))&&d==PApplet.parseInt(Sub[t].substring(11, 13))) {
      String show[]=split(Sub[t], ",");
      Disp=show[4]; //ここでその日のやることデータを吐き出す。
    } else {
      Disp="null";
    }
  }
  return Disp;
}

public String DetailTODOmemo(int y, int m, int d) {//これがぬるを吐く＝＝その日にタスクはない
  String Disp="";
  for (int t=0; t<Sub.length; t++) {
    if (y==PApplet.parseInt(Sub[t].substring(3, 7))&&m==PApplet.parseInt(Sub[t].substring(9, 10))&&d==PApplet.parseInt(Sub[t].substring(11, 13))) {
      String show[]=split(Sub[t], ",");
      Disp=show[5]; //ここでその日のやることデータの詳しいメモを表示する。詳しいめもを！！！！！！！！！！！！！！！！！
    } else {
      Disp="null";
    }
  }
  return Disp;
}

public int Subdetailtodokind(int y,int m,int d){//タスクの種類を吐き出す
  int disp=100;
    for (int t=0; t<Sub.length; t++) {
    if (y==PApplet.parseInt(Sub[t].substring(3, 7))&&m==PApplet.parseInt(Sub[t].substring(9, 10))&&d==PApplet.parseInt(Sub[t].substring(11, 13))) {
      String show[]=split(Sub[t], ",");
      disp=PApplet.parseInt(show[0]); //ここでその日のやることデータを吐き出す。
    } else {
      disp=4;
    }
  }
  return disp;
}

//一番上のタイトルの帯を表示
public void TopLabel(String title, int size, int x, int y) {
  fill(255); 
  textAlign(CENTER); 
  //textSize(size); 
  textFont(Font004, size);
  text(title, x, y); //そしてテキストを上から重ねry
}

//グラデーションを作るよ
public void Backcolor(int c1, int c2) {
  noStroke();
  for (float w = 0; w < height; w += 5) {
    float r = map(w, 0, height, red(c1), red(c2));
    float g = map(w, 0, height, green(c1), green(c2));
    float b = map(w, 0, height, blue(c1), blue(c2));
    fill(r, g, b);
    rect(0, w, height, 5);
  }
}


public String keybode(){
  
   noStroke();
    fill(255);
    rect(0,380,480,680);
  //入力
  for (int i = 0; i < KeyBodeText.length; i++) {
    if (KeyBodeText[i] != "" && KeyBodeText[i] != null) {
      // fill(BarColorSub);
      if (mx > KeyBodeX[i] && mx < KeyBodeX[i]+KeyBodeWidth[i] && my > KeyBodeY[i]+380&& my < KeyBodeY[i]+380+KeyBodeHeight[i]) {
        //fill(BarColor, 100);
        text=settletext+textnow;
        if (mouseKey == 1) {
          mouseKey=2;
          switch(KeyBodeText[i]) {
          case "Shift":
            KeyShift = KeyShift + 1;
            if (KeyShift%2!=0) {
              KeyType=1;
              keyshift=true;
            } else {
              KeyType=0;
              keyshift=false;
            }
            break;
          case "全":
            break;
          case "半":
            break;
          case ">":
            //NowLine = NowLine + 1;
            //if (NowLine > KeyBodeDraw.length()) NowLine = KeyBodeDraw.length();
            break;
          case "<":
            // NowLine = NowLine - 1;
            //if (NowLine < 0) NowLine = 0;
            break;
          case "<<":
            break;
          case "SP":
            textnow=textnow+" ";
            break;
          case "Ent":
            settletext=settletext+textnow;
            textnow="";
            break;
          case "del":
            if (textnow=="") {
              settletext=settletext.substring(0, (settletext.length()-1));
            } else if (textnow.length()==1) {
              textnow="";
            } else {
              textnow=textnow.substring(0, (textnow.length()-1));
            }
            break;
          }
          // mouseKey = 0;
        }
      }
    }
  }

  for (int i=0; i<LoadFile.length; i++) {
   
    
    //今の、入力の表示

    if (mousePressed==true&&i<27&&mouseX>KeyBodeX[i]&&mouseX<KeyBodeX[i]+KeyBodeWidth[i]&&mouseY>KeyBodeY[i]+380&&mouseY<KeyBodeY[i]+380+KeyBodeHeight[i]) {
      textnow=textnow+KeyBodeText[i];
      mousePressed=false;
    }

    //キーボード描きますよ
    
    if (mouseX>KeyBodeX[i]&&mouseX<KeyBodeX[i]+KeyBodeWidth[i]&&mouseY>KeyBodeY[i]+380&&mouseY<KeyBodeY[i]+380+KeyBodeHeight[i]) {
      fill(0, 0, 255, 200);
    } else {
      fill(0, 0, 255, 51);
    }
    if (keyshift==true) {
      diskeybode(UppercaseLetter(KeyBodeText[i]), KeyBodeX[i], KeyBodeY[i]+380, KeyBodeWidth[i], KeyBodeHeight[i]);//;
    } else {
      diskeybode(KeyBodeText[i], KeyBodeX[i], KeyBodeY[i]+380, KeyBodeWidth[i], KeyBodeHeight[i]);
    }
  }

  if (KeyType==1) {
    int TextPos = 0;
    int TextLength = 1;
    String a = "";
    while (TextPos < textnow.length()) {
      String ForRome = textnow.substring(TextPos, TextPos+TextLength);//変換対象
      String AfterConversion = ConvertToRomaji(ForRome);
       if (AfterConversion.equals(ForRome)) {//変換がなかった
        if (TextLength > 6 || TextPos+TextLength == textnow.length()) {  //これ以上変換にかけても見つかる見込みがない
          a = a + textnow.substring(TextPos, TextPos+1);
          TextPos = TextPos + 1;
          TextLength = 1;
        } else {  //まだ可能性がある
          TextLength = TextLength + 1;
        }
      } else {//変換があった
        a = a + AfterConversion;
        TextPos = TextPos + ForRome.length();
        TextLength = 1;
      }
    }
    textnow = a;
  } else {
  }
 text=settletext+textnow;
 return text;
  //描画に送る
  //KeyBodeDrawF = KeyBodeDraw.substring(0, NowLine) + KeyBodeUnsettled + KeyBodeDraw.substring(NowLine, KeyBodeDraw.length());
}


public void ResetKeybode() {
  //キーボードのロード（初期化含む）
  LoadFile = loadStrings("keybode.txt");//データはこれに入っているぞ
  KeyBodeText = new String[LoadFile.length];//なかみ
  KeyBodeX = new int[LoadFile.length];//ざひょー
  KeyBodeY = new int[LoadFile.length];//ざひょー
  KeyBodeWidth = new int[LoadFile.length];//はば
  KeyBodeHeight = new int[LoadFile.length];//たかさ
  for (int i = 0; i < LoadFile.length; i++) {
    String Temp[] = split(LoadFile[i], ",");
    KeyBodeText[i] = Temp[0];
    KeyBodeX[i] = PApplet.parseInt(Temp[1]);
    KeyBodeY[i] = PApplet.parseInt(Temp[2]);
    KeyBodeWidth[i] = PApplet.parseInt(Temp[3]);
    KeyBodeHeight[i] = PApplet.parseInt(Temp[4]);
  }
  // NowLine = 0;
}

public void diskeybode(String text, int x, int y, int insx, int insy) {
  noStroke();
  rect(x, y, insx, insy, 8);
  textAlign(LEFT, CENTER);
  textSize(18);
  fill(0);
  text(text, x+insx/2, y+insy/2);
}


public String UppercaseLetter(String p1) {
  String s = p1;
  if (p1.equals("a")) s = "A";
  if (p1.equals("b")) s = "B";
  if (p1.equals("c")) s = "C";
  if (p1.equals("d")) s = "D";
  if (p1.equals("e")) s = "E";
  if (p1.equals("f")) s = "F";
  if (p1.equals("g")) s = "G";
  if (p1.equals("h")) s = "H";
  if (p1.equals("i")) s = "I";
  if (p1.equals("j")) s = "J";
  if (p1.equals("k")) s = "K";
  if (p1.equals("l")) s = "L";
  if (p1.equals("m")) s = "M";
  if (p1.equals("n")) s = "N";
  if (p1.equals("o")) s = "O";
  if (p1.equals("p")) s = "P";
  if (p1.equals("q")) s = "Q";
  if (p1.equals("r")) s = "R";
  if (p1.equals("s")) s = "S";
  if (p1.equals("t")) s = "T";
  if (p1.equals("u")) s = "U";
  if (p1.equals("v")) s = "V";
  if (p1.equals("w")) s = "W";
  if (p1.equals("x")) s = "X";
  if (p1.equals("y")) s = "Y";
  if (p1.equals("z")) s = "Z";
  if (p1.equals(".")) s = ":";
  if (p1.equals("-")) s = "+";
  if (p1.equals("/")) s = "*";
  if (p1.equals("\"")) s = "#";

  return s;
}


public String ConvertToRomaji(String p1) {
  String s = "";
  //※もともと別の方法で使っていたものだからs = s + n は s = n でおｋ
  //さすがにコメントは書かないぞ？
  if (p1.equals("a")) s = s + "あ";
  else if (p1.equals("i")) s = s + "い";
  else if (p1.equals("u")) s = s + "う";
  else if (p1.equals("e")) s = s + "え";
  else if (p1.equals("o")) s = s + "お";
  else if (p1.equals("ka")) s = s + "か";
  else if (p1.equals("ki")) s = s + "き";
  else if (p1.equals("ku")) s = s + "く";
  else if (p1.equals("ke")) s = s + "け";
  else if (p1.equals("ko")) s = s + "こ";
  else if (p1.equals("sa")) s = s + "さ";
  else if (p1.equals("si")) s = s + "し";
  else if (p1.equals("su")) s = s + "す";
  else if (p1.equals("se")) s = s + "せ";
  else if (p1.equals("so")) s = s + "そ";
  else if (p1.equals("ta")) s = s + "た";
  else if (p1.equals("ti")) s = s + "ち";
  else if (p1.equals("tu")) s = s + "つ";
  else if (p1.equals("te")) s = s + "て";
  else if (p1.equals("to")) s = s + "と";
  else if (p1.equals("na")) s = s + "な";
  else if (p1.equals("ni")) s = s + "に";
  else if (p1.equals("nu")) s = s + "ぬ";
  else if (p1.equals("ne")) s = s + "ね";
  else if (p1.equals("no")) s = s + "の";
  else if (p1.equals("ha")) s = s + "は";
  else if (p1.equals("hi")) s = s + "ひ";
  else if (p1.equals("hu")) s = s + "ふ";
  else if (p1.equals("he")) s = s + "へ";
  else if (p1.equals("ho")) s = s + "ほ";
  else if (p1.equals("ma")) s = s + "ま";
  else if (p1.equals("mi")) s = s + "み";
  else if (p1.equals("mu")) s = s + "む";
  else if (p1.equals("me")) s = s + "め";
  else if (p1.equals("mo")) s = s + "も";
  else if (p1.equals("ya")) s = s + "や";
  else if (p1.equals("yi")) s = s + "い";
  else if (p1.equals("yu")) s = s + "ゆ";
  else if (p1.equals("ye")) s = s + "いぇ";
  else if (p1.equals("yo")) s = s + "よ";
  else if (p1.equals("ra")) s = s + "ら";
  else if (p1.equals("ri")) s = s + "り";
  else if (p1.equals("ru")) s = s + "る";
  else if (p1.equals("re")) s = s + "れ";
  else if (p1.equals("ro")) s = s + "ろ";
  else if (p1.equals("wa")) s = s + "わ";
  else if (p1.equals("wi")) s = s + "うぃ";
  else if (p1.equals("wu")) s = s + "う";
  else if (p1.equals("we")) s = s + "うぇ";
  else if (p1.equals("wo")) s = s + "を";
  else if (p1.equals("za")) s = s + "ざ";
  else if (p1.equals("zi")) s = s + "じ";
  else if (p1.equals("zu")) s = s + "ず";
  else if (p1.equals("ze")) s = s + "ぜ";
  else if (p1.equals("zo")) s = s + "ぞ";    
  else if (p1.equals("ga")) s = s + "が";
  else if (p1.equals("gi")) s = s + "ぎ";
  else if (p1.equals("gu")) s = s + "ぐ";
  else if (p1.equals("ge")) s = s + "げ";
  else if (p1.equals("go")) s = s + "ご";
  else if (p1.equals("da")) s = s + "だ";
  else if (p1.equals("di")) s = s + "ぢ";
  else if (p1.equals("du")) s = s + "づ";
  else if (p1.equals("de")) s = s + "で";
  else if (p1.equals("do")) s = s + "ど";
  else if (p1.equals("ba")) s = s + "ば";
  else if (p1.equals("bi")) s = s + "び";
  else if (p1.equals("bu")) s = s + "ぶ";
  else if (p1.equals("be")) s = s + "べ";
  else if (p1.equals("bo")) s = s + "ぼ";
  else if (p1.equals("pa")) s = s + "ぱ";
  else if (p1.equals("pi")) s = s + "ぴ";
  else if (p1.equals("pu")) s = s + "ぷ";
  else if (p1.equals("pe")) s = s + "ぺ";
  else if (p1.equals("po")) s = s + "ぽ";
  else if (p1.equals("nn")) s = s + "ん";
  else if (p1.equals("fa")) s = s + "ふぁ";
  else if (p1.equals("fi")) s = s + "ふぃ";
  else if (p1.equals("fu")) s = s + "ふ";
  else if (p1.equals("fe")) s = s + "ふぇ";
  else if (p1.equals("fo")) s = s + "ふぉ";
  else if (p1.equals("la")) s = s + "ぁ";
  else if (p1.equals("li")) s = s + "ぃ";
  else if (p1.equals("lu")) s = s + "ぅ";
  else if (p1.equals("le")) s = s + "ぇ";
  else if (p1.equals("lo")) s = s + "ぉ";
  else if (p1.equals("ltu")) s = s + "っ";
  else if (p1.equals("lwa")) s = s + "ゎ";
  else if (p1.equals("lyo")) s = s + "ょ";
  else if (p1.equals("lyu")) s = s + "ゅ";
  else if (p1.equals("lya")) s = s + "ゃ";
  else if (p1.equals("xa")) s = s + "ぁ";
  else if (p1.equals("xi")) s = s + "ぃ";
  else if (p1.equals("xu")) s = s + "ぅ";
  else if (p1.equals("xe")) s = s + "ぇ";
  else if (p1.equals("xo")) s = s + "ぉ";
  else if (p1.equals("xtu")) s = s + "っ";
  else if (p1.equals("xwa")) s = s + "ゎ";
  else if (p1.equals("xyo")) s = s + "ょ";
  else if (p1.equals("xyu")) s = s + "ゅ";
  else if (p1.equals("xya")) s = s + "ゃ";
  else if (p1.equals("zya")) s = s + "じゃ";
  else if (p1.equals("zyi")) s = s + "じ";
  else if (p1.equals("zyu")) s = s + "じゅ";
  else if (p1.equals("zye")) s = s + "じぇ";
  else if (p1.equals("zyo")) s = s + "じょ";
  else if (p1.equals("sha")) s = s + "しゃ";
  else if (p1.equals("shi")) s = s + "し";
  else if (p1.equals("shu")) s = s + "しゅ";
  else if (p1.equals("she")) s = s + "しぇ";
  else if (p1.equals("sho")) s = s + "しょ";
  else if (p1.equals("sya")) s = s + "しゃ";
  else if (p1.equals("syi")) s = s + "しぃ";
  else if (p1.equals("syu")) s = s + "しゅ";
  else if (p1.equals("sye")) s = s + "しぇ";
  else if (p1.equals("syo")) s = s + "しょ";
  else if (p1.equals("qa")) s = s + "くぁ";
  else if (p1.equals("qi")) s = s + "くぃ";
  else if (p1.equals("qu")) s = s + "く";
  else if (p1.equals("qe")) s = s + "くぇ";
  else if (p1.equals("qo")) s = s + "くぉ";
  else if (p1.equals("ca")) s = s + "か";
  else if (p1.equals("ci")) s = s + "し";
  else if (p1.equals("cu")) s = s + "く";
  else if (p1.equals("ce")) s = s + "せ";
  else if (p1.equals("co")) s = s + "こ";
  else if (p1.equals("ja")) s = s + "じゃ";
  else if (p1.equals("ji")) s = s + "じ";
  else if (p1.equals("ju")) s = s + "じゅ";
  else if (p1.equals("je")) s = s + "じぇ";
  else if (p1.equals("jo")) s = s + "じょ";
  else if (p1.equals("jya")) s = s + "じゃ";
  else if (p1.equals("jyi")) s = s + "じぃ";
  else if (p1.equals("jyu")) s = s + "じゅ";
  else if (p1.equals("jye")) s = s + "じぇ";
  else if (p1.equals("jyo")) s = s + "じょ";
  else if (p1.equals("kya")) s = s + "きゃ";
  else if (p1.equals("kyi")) s = s + "きぃ";
  else if (p1.equals("kyu")) s = s + "きゅ";
  else if (p1.equals("kye")) s = s + "きぇ";
  else if (p1.equals("kyo")) s = s + "きょ";
  else if (p1.equals("nya")) s = s + "にゃ";
  else if (p1.equals("nyi")) s = s + "にぃ";
  else if (p1.equals("nyu")) s = s + "にゅ";
  else if (p1.equals("nye")) s = s + "にぇ";
  else if (p1.equals("nyo")) s = s + "にょ";
  else if (p1.equals("-")) s = s + "ー";
  else if (p1.equals("kk")) s = s + "っk";
  else if (p1.equals("ss")) s = s + "っs";
  else if (p1.equals("tt")) s = s + "っt";
  else if (p1.equals("hh")) s = s + "っh";
  else if (p1.equals("mm")) s = s + "っm";
  else if (p1.equals("yy")) s = s + "っy";
  else if (p1.equals("rr")) s = s + "っr";
  else if (p1.equals("ww")) s = s + "っw";
  else if (p1.equals("gg")) s = s + "っg";
  else if (p1.equals("zz")) s = s + "っz";
  else if (p1.equals("dd")) s = s + "っd";
  else if (p1.equals("bb")) s = s + "っb";
  else if (p1.equals("pp")) s = s + "っp";
  else if (p1.equals("ff")) s = s + "っf";
  else if (p1.equals("rya")) s = s + "りゃ";
  else if (p1.equals("ryi")) s = s + "りぃ";
  else if (p1.equals("ryu")) s = s + "りゅ";
  else if (p1.equals("rye")) s = s + "りぇ";
  else if (p1.equals("ryo")) s = s + "りょ";
  else if (p1.equals("dya")) s = s + "ぢゃ";
  else if (p1.equals("dyi")) s = s + "ぢぃ";
  else if (p1.equals("dyu")) s = s + "ぢゅ";
  else if (p1.equals("dye")) s = s + "ぢぇ";
  else if (p1.equals("dyo")) s = s + "ぢょ";
  else if (p1.equals("gya")) s = s + "ぎゃ";
  else if (p1.equals("gyi")) s = s + "ぎぃ";
  else if (p1.equals("gyu")) s = s + "ぎゅ";
  else if (p1.equals("gye")) s = s + "ぎぇ";
  else if (p1.equals("gyo")) s = s + "ぎょ";
  else if (p1.equals("va")) s = s + "ヴぁ";
  else if (p1.equals("vi")) s = s + "ヴぃ";
  else if (p1.equals("vu")) s = s + "ヴ";
  else if (p1.equals("ve")) s = s + "ヴぇ";
  else if (p1.equals("vo")) s = s + "ヴぉ";
  else if (p1.equals("tya")) s = s + "ちゃ";
  else if (p1.equals("tyi")) s = s + "ちぃ";
  else if (p1.equals("tyu")) s = s + "ちゅ";
  else if (p1.equals("tye")) s = s + "ちぇ";
  else if (p1.equals("tyo")) s = s + "ちょ";
  else if (p1.equals("tha")) s = s + "てゃ";
  else if (p1.equals("thi")) s = s + "てぃ";
  else if (p1.equals("thu")) s = s + "てゅ";
  else if (p1.equals("the")) s = s + "てゅ";
  else if (p1.equals("tho")) s = s + "てょ";
  else if (p1.equals("twa")) s = s + "とぁ";
  else if (p1.equals("twi")) s = s + "とぃ";
  else if (p1.equals("twu")) s = s + "とぅ";
  else if (p1.equals("twe")) s = s + "とぇ";
  else if (p1.equals("two")) s = s + "とぉ";
  else if (p1.equals("wha")) s = s + "うぁ";
  else if (p1.equals("whi")) s = s + "うぃ";
  else if (p1.equals("whu")) s = s + "う";
  else if (p1.equals("whe")) s = s + "うぇ";
  else if (p1.equals("who")) s = s + "うぉ";  
  else if (p1.equals("hya")) s = s + "ひゃ";
  else if (p1.equals("hyi")) s = s + "ひぃ";
  else if (p1.equals("hyu")) s = s + "ひゅ";
  else if (p1.equals("hye")) s = s + "ひぇ";
  else if (p1.equals("hyo")) s = s + "ひょ";
  else s = s + p1;

  return s;
}
class Main_Memo extends State {
  public void drawState() {
    if(ClassSetUp){
      ClassSetUp=false;
    }
  }
  public State decideState() {
    return this;
  }
}
class Main_Nextday7_ToDoList extends State {
  public void drawState() {
    if (ClassSetUp) {
      todo=new TodoList();
      ClassSetUp=false;
      textFont(Font002, 24);
    }
    Backcolor(0xff0F4993, 0xff88AEDE);
    todo.day7_ListDraw();
  }

  public State decideState() {
    //ホームのページ戻る
    if (mouseKey==1&&(mouseX>25&&mouseX<70&&mouseY>15&&mouseY<60)) {
      mouseKey=0;
      controlP5.remove("BackPage");
      ClassSetUp=true;
      return new Main_ToDoList();
    }
    for (int i=0; i<Sub.length; i++) {
      if ( selecttodo[i]==true) {
        controlP5.remove("BackPage");
        println("さすが");
        prepage=0;
        ClassSetUp=true;
        return new DetaildayTodo();//やることリストの詳細を表示する
      }
    }
    return this;
  }
}

//String Main="2019,07,16,AAA;2019,07,16,BBB;2019,07,17,CCC;2019,07,18,DDD;2019,07,18,EEE"; 


//String Main="2019,07,16,AAA;2019,07,16,BBB;2019,07,17,CCC;2019,07,18,DDD;2019,07,18,EEE"; 
//String Sub[]=split(Main, ";"); 
//

class TodoList {
  //宣言
  String[] todotitle={"TUR : TODAY : ", "FRI : TOMORROW : ", "SAT : ", "SUN : ", "MON : ", "TUR : ", "WED : "}; 
  ArrayList<String> SAV=new ArrayList<String>(); 
  int y; 
  int nexttitlehigh; 
  int titlehigh; 
  int texthigh; 
  int[]number=new int[Sub.length]; 

  TodoList() {
    mouseKey=0;
    selecttodo=new boolean[Sub.length];
    controlP5.addButton("BackPage").setLabel("<").setPosition(25, 15).setSize(45, 45); 
    for (int i=0; i<Sub.length; i++) {
      number[i]=0; 
      selecttodo[i]=false;
    }
    nexttitlehigh=0; 
    titlehigh=70+nexttitlehigh; 
    texthigh=titlehigh+60; 
    y=0;
  }

  public void day7_ListDraw() {
    int n=0; 
    int s=0; 
    for (int t=0; t<Sub.length; t++) {
      for (int i=0; i<todotitle.length; i++) {
        if (number[t]>=Sub.length||TODO(Sub[t], year(), month(), day()+i)=="null") {
          SAV.add("予定は何もないです寂しい");
        }
        if (TODO(Sub[t], year(), month(), day()+i)!="null") {
          number[t]++; 
          SAV.add(TODO(Sub[t], year(), month(), day()+i));
        }
      }
    }
    if (mousePressed==true&&abs(pmouseY-mouseY)>1) {
      y=y-(pmouseY-mouseY);
    }
    for (int j=0; j<SAV.size(); j++) {
      for (int t=0; t<Sub.length; t++) {
        //fill(204, 255); //
        if (titlehigh+y+20<90) {
          y=0;
        }
        fill(255, 99);
        noStroke(); 
        rect(0, titlehigh+y, 480, 30); 
        fill(0); 
        textAlign(LEFT); 
        textSize(15); 
        int daydis=day()+j; //日にち表示テキスト
        text(todotitle[j]+month()+" / "+daydis, width/20, titlehigh+y+20); 
        if (mouseY> texthigh+y+t*40-30&&mouseY<texthigh+10+y+t*40) {//選択されるよ
          noStroke(); 
          fill(0, 0, 180, 50); 
          rect(0, texthigh+y+t*40-30, width, 40); 
          if (mouseKey==1&&mouseY> texthigh+y+t*40-30&&mouseY<texthigh+10+y+t*40) {
            Label=month()+" 月 "+daydis+" 日 ";
            dispy=year();
            dispm=month();
            dispd=daydis;
            println(dispy,dispm,dispd);
            selecttodo[t]=true;
          }
        }
        //本命のtodoテキスト表示
        textSize(25); 
        fill(255); 
        String BAR=SAV.get(n);
        text(BAR, width/9, texthigh+y+t*40, 0); 
        stroke(200); //0で黒２５５で白
        line(0, texthigh+10+y+t*40, 480, texthigh+10+y+t*40); 
        n++; 
        s++; 
        if (s==number[t]) {
          nexttitlehigh=texthigh+10+(s-1)*40-70; 
          titlehigh=70+nexttitlehigh; 
          texthigh=titlehigh+60; 
          s=0;
        }
      }
    }
    n=0; 
    nexttitlehigh=0; 
    titlehigh=70+nexttitlehigh; 
    texthigh=titlehigh+60; 
    for (int i=0; i<Sub.length; i++) {
      number[i]=0;
    }
    SAV=new ArrayList<String>();

    TopLabel("Next 7 Days", 30, width/2, 50);//一番上のそのページのタイトル帯
  }
}
class Main_Setting extends State {
  public void drawState() {
    background(255);
  }
  public State decideState() {
    return new Setting_MainHome();
  }
}
class Main_Subject extends State {
  public void drawState() {
    background(255);
  }
  public State decideState() {
    return this;
  }
}
class Main_ToDoList extends State {
  public void drawState() {
    int[]select={50, 125, 260, 125, 50, 335, 260, 335};
    String[]texttle={"Add schedule", "Search", "Latest schedule", "Schedule list"};
    PImage[]icon={icon004, icon008, icon003, icon006};
    if (ClassSetUp) {
      mouseKey=0;
      nextpage=7;
      ClassSetUp=false;
    }
    Backcolor(0xff0F4993, 0xff88AEDE);
    controlP5.addButton("BackPage").setLabel("<").setPosition(25, 20).setSize(45, 45); 
    TopLabel("To Do List", 50, width/2, 60);
    //imageMode(CENTER);
    for (int i=0; i<select.length; i=i+2) {
      if (mouseX>select[i]&&mouseX<select[i]+175&&mouseY>select[i+1]&&mouseY<select[i+1]+175) {
        fill(255, 160);
      } else {
        fill(255, 99);
      }
      if (mouseKey==1&&mouseX>select[i]&&mouseX<select[i]+175&&mouseY>select[i+1]&&mouseY<select[i+1]+175) {
        nextpage=i/2;
      }
      rect(select[i], select[i+1], 175, 175, 30);
      image(icon[i/2], select[i]+88, select[i+1]+75, 100, 100);
      textSize(25);
      fill(255);
      text(texttle[i/2], select[i]+88, select[i+1]+160);
    }
  }

  public State decideState() {
    if (mouseKey==1&&mouseX>25&&mouseX<70&&mouseY>20&&mouseY<65) {
      controlP5.remove("BackPage");
      ClassSetUp=true;
      return new MainHome();
    }
    if (nextpage!=7) {
      controlP5.remove("BackPage");
      ClassSetUp=true;
      switch(nextpage) {
      case 0:
        return new AddToDo();
      case 1:
        return new SearchToDo();
      case 2:
        return new Main_Nextday7_ToDoList();
      case 3:
        return new Sub_ToDoList();
      }
    }
    return this;
  }
}
class SearchToDo extends State {
  public void drawState() {
    if (ClassSetUp) {
      subsearch=new SubSearchToDo();
      ClassSetUp=false;
    }
    Backcolor(0xff0F4993, 0xff88AEDE);
    subsearch.showsearchpage();
  }
  public State decideState() {
    if (mouseKey==1&&mouseX>25&&mouseX<70&&mouseY>20&&mouseY<65) {
      controlP5.remove("BackPage");
      ClassSetUp=true;
      return new Main_ToDoList();
    }
    return this;
  }
}

SubSearchToDo subsearch;
class SubSearchToDo {
  SubSearchToDo() {
    controlP5.addButton("BackPage").setLabel("<").setPosition(25, 20).setSize(45, 45);
  }


  public void showsearchpage() {
    TopLabel("Search", 45, width/2, 60);
  }
}
//「その日のタスク」「フルで行けたら褒める」「任意の場所へのショートカット」「メモ」「ツイート」
//「天気」「設定」

class Setting_MainHome extends State {
  public void drawState() {
    if (ClassSetUp) {
      controlP5.addButton("保存").setLabel("SAVE").setPosition(400, 20).setSize(65, 50);
      ClassSetUp=false;
    }
    Backcolor(0xff581315, 0xffF2B14E);

    //設定の保存
    //text("保存", 440, 20);

    //サークルの削除（ゴミ箱場所作って、そこと半径が重なったらぽい）

    /*設定の追加
     
     */
    fill(0xffE6D5ED, 80);
    noStroke();
    ellipse(240, 640/5, 200, 200);

    Setting_Circle();
  }

  public State decideState() {
    if (mouseKey==1&&mouseX>400&&mouseX<465&&mouseY>20&&mouseY<70) {
      controlP5.remove("保存");
      ClassSetUp=true;
      return new MainHome();
    }
    return this;
  }
}

//class MainCircle {

public void Setting_Circle() {
  boolean Moveflag[]=new boolean[Setpos.length];
  boolean MOVE=false;

  for (int i=4; i<Setpos.length; i=i+4) {
    float x=PApplet.parseFloat(Setpos[i]);
    float y=PApplet.parseFloat(Setpos[i+1]);
    String date=(Setpos[i+2]);
    int cirl=PApplet.parseInt(Setpos[i+3]);


    fill(0xffE6D5ED, 80);
    ellipse(x, y, cirl, cirl);
    switch(PApplet.parseInt(Setpos[i+2])) {
    case 0://時計
      clock=new Clock();
      clock.display(x, y, cirl);
      break;
    case 1://やることリスト
      image(icon003, x, y, cirl-32, cirl-32);
      break;
    case 2://メモ
      image(icon002, x, y, cirl-32, cirl-32);
      break;
    case 3://ツイッター
      image(icon007, x, y, cirl, cirl);
      break;
    case 4://学生帽
      image(icon006, x, y, cirl-32, cirl-32);
      break;
    case 5://カレンダー
      image(icon001, x, y, 63, 63);
      break;
    case 6://設定
      image(icon005, x, y, 63, 63);
      break;
    }

    //サークルの移動開始
    if (mousePressed==true&&sqrt(sq(mouseX-x)+sq(mouseY-y))<PApplet.parseInt(cirl)&&MOVE==false) {
      Moveflag[i]=true;
      MOVE=true;
    }

    if (Moveflag[i]==true&&MOVE==true) {

      x=mouseX;//+(mouseX-SetX);しょうがないので一旦これで放置あとで頑張ってね
      y=mouseY;//+(mouseY-SetY);
      Setpos[i]=str(x);
      Setpos[i+1]=str(y);
      Setpos[i+2]=date;
      Setpos[i+3]=str(cirl);
      saveStrings("MainManu_Circle_position.txt", Setpos);

      if (mousePressed==false) {
        Moveflag[i]=false;
        MOVE=false;
      }
    }
  }
}
//}
class Sub_ToDoList extends State {
  public void drawState() {
    if (ClassSetUp) {
      sublist=new SubToDoList();
      ClassSetUp=false;
    }
    Backcolor(0xff0F4993, 0xff88AEDE);
    sublist.showList();
  }
  public State decideState() {
    if (mouseKey==1&&mouseX>25&&mouseX<70&&mouseY>20&&mouseY<65) {
      controlP5.remove("BackPage");
      ClassSetUp=true;
      return new Main_ToDoList();
    }
    return this;
  }
}

SubToDoList sublist;
class SubToDoList {
  SubToDoList() {
    controlP5.addButton("BackPage").setLabel("<").setPosition(25, 20).setSize(45, 45);
  }

  public void showList() {
    TopLabel("Schedule list", 45, width/2, 60);
  }
}
class thisdayTodo extends State {
  public void drawState() {
    if (ClassSetUp) {
      detail=new Detailtodo();
      println(dispy,dispm,dispd);
      ClassSetUp=false;
    }
    Backcolor(0xff07545A, 0xff02D4E5);
    controlP5.addButton("BackPage").setLabel("<").setPosition(25, 15).setSize(45, 45);
    TopLabel(Label, 40, width/2, 55);//一番上のそのページのタイトル帯
    detail.detaildisp(dispy, dispm, dispd);
  }
  public State decideState() {
    if (mouseKey==1&&(mouseX>25&&mouseX<70&&mouseY>15&&mouseY<60)) {
      mouseKey=0;
      controlP5.remove("BackPage");
      ClassSetUp=true;
      if (prepage==0) {
        return new Main_ToDoList();
      } else if (prepage==1) {
        return new Calender();
      }
    }
    return this;
  }
}

Detailtodo detail;
class Detailtodo {

  int nexttitlehigh; 
  int titlehigh; 
  int texthigh; 
  int n;

  Detailtodo() {
    nexttitlehigh=0; 
    titlehigh=70+nexttitlehigh; 
    texthigh=titlehigh+60; 
    n=0;
  }

  public void detaildisp(int f, int m, int d) {
    float y=0;
    if (mousePressed==true&&abs(pmouseY-mouseY)>1) {
      y=y-(pmouseY-mouseY);
    }
    if (titlehigh+y+20<90) {
      y=0;
    }
    if (DetailTODO(f, m, d)!="null") {
      fill(255, 99);
      noStroke(); 
      rect(0, titlehigh+y+30, 480, 40); 
      fill(0); 
      textAlign(LEFT); 
      textSize(15); 

      //本命のtodoテキスト表示
      textSize(25); 
      fill(255); 
      //String BAR=Sub[t];
      text(DetailTODO(f, m, d), width/9, texthigh+y+n*40, 0); 
      stroke(200); //0で黒２５５で白
      line(0, texthigh+10+y+n*40, 480, texthigh+10+y+n*40);
      /*
      nexttitlehigh=0; 
       titlehigh=70+nexttitlehigh; 
       texthigh=titlehigh+60;
       n++;
       */
    } else {
      //本命のtodoテキスト表示

      fill(255, 99);
      noStroke(); 
      rect(0, width/5, 480, 45); 
      textSize(25); 
      fill(255); 
      textAlign(LEFT, BOTTOM); 
      text("予定はないです", width/9, texthigh+y+n*40, 0); 
      stroke(200); //0で黒２５５で白
      line(0, width/5, 480, width/5);
    }
  }
}
class Twitter extends State {
  public void drawState() {
    if(ClassSetUp){
    link( "http://twitter.com/home?status");
    ClassSetUp=false;
    }
    background(255);
  }
  public State decideState() {
    return new MainHome();
  }
}
  public void settings() {  size(480, 640); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "skeduler" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
