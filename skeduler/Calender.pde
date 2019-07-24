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
  void drawState() {
    if (ClassSetUp) {
      maincal=new MainCalender(0, 0);
      ClassSetUp=false;
    }
    color c1=#58004E;
    color c2=#FCD9B2;
    Backcolor(c1, c2);
    maincal.do_calender(year(), month());//常に今の表示してる月を出す
  }

  State decideState() {//このページから離れるときにねくすと～を０に戻しておく。
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
    textFont(Font004, 40);
    fill(255, 160);
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

        if ((TODO(Sub[h], y, m, i)!="")) {
          int task=int(Sub[h].substring(0, 1));
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
  void nextCalender() {
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
