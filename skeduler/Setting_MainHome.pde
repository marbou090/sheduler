//「その日のタスク」「フルで行けたら褒める」「任意の場所へのショートカット」「メモ」「ツイート」
//「天気」「設定」

class Setting_MainHome extends State {
  void drawState() {
    if (ClassSetUp) {
      Setpos=loadStrings("data/MainManu_Circle_position.txt");
      controlP5.addButton("保存").setLabel("SAVE").setPosition(400, 20).setSize(65, 50);
      controlP5.addButton("追加").setLabel("ADD").setPosition(400, 90).setSize(65, 50);
      controlP5.addButton("削除").setLabel("REMOVE").setPosition(400, 160).setSize(65, 50);
      ClassSetUp=false;
    }
    Backcolor(#86A500, #FAFC96);
    fill(#FFF2FF, 80);
    noStroke();
    ellipse(240, 640/5, 200, 200);
    Setting_Circle();
  }

  State decideState() {
    if (mouseKey==1&&mouseX>400&&mouseX<465&&mouseY>20&&mouseY<70) {
      controlP5.remove("保存");
      controlP5.remove("追加");
      controlP5.remove("削除");
      ClassSetUp=true;
      return new MainHome();
    }
    if (mouseKey==1&&mouseX>400&&mouseX<465&&mouseY>90&&mouseY<140) {
      controlP5.remove("保存");
      controlP5.remove("追加");
      controlP5.remove("削除");
      ClassSetUp=true;
      return new Setting_Addicon();
    }
    if (mouseKey==1&&mouseX>400&&mouseX<465&&mouseY>160&&mouseY<210) {
      controlP5.remove("保存");
      controlP5.remove("追加");
      controlP5.remove("削除");
      ClassSetUp=true;
      return new Setting_Removeicon();
    }
    return this;
  }
}

//class MainCircle {

void Setting_Circle() {
  boolean Moveflag[]=new boolean[Setpos.length];
  boolean MOVE=false;

  for (int i=4; i<Setpos.length-1; i=i+4) {
    float x=float(Setpos[i]);
    float y=float(Setpos[i+1]);
    String date=(Setpos[i+2]);
    int cirl=int(Setpos[i+3]);

    noStroke();
    fill(#FFF2FF, 80);
    ellipse(x, y, cirl, cirl);
    switch(int(Setpos[i+2])) {
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
    case 7:
      image(icon004, x, y, 63, 63);
      break;
    case 8:
      image(icon008, x, y, 63, 63);
      break;
    }

    //サークルの移動開始
    if (mousePressed==true&&sqrt(sq(mouseX-x)+sq(mouseY-y))<int(cirl)&&MOVE==false) {
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
      saveStrings("data/MainManu_Circle_position.txt", Setpos);

      if (mousePressed==false) {
        Moveflag[i]=false;
        MOVE=false;
      }
    }
  }
}
//}
