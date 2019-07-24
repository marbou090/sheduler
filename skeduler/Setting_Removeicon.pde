class Setting_Removeicon extends State {
  void drawState() {
    println("!!");
    if (ClassSetUp) {
      Setpos=loadStrings("data/MainManu_Circle_position.txt");
      mouseKey=2;
      for (int i=4; i<Setpos.length-1; i=i+4) {
        float x=float(Setpos[i]);
        float y=float(Setpos[i+1]);
        String date=(Setpos[i+2]);
        int cirl=int(Setpos[i+3]);
        noStroke();
        fill(#E6D5ED, 80);
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
      }
      controlP5.addButton("保存").setLabel("SAVE").setPosition(400, 20).setSize(65, 50);
      sub_remove=new sub_Removeicon();
      ClassSetUp=false;
    }
    Backcolor(#86A500, #FAFC96);

    sub_remove.Setting_Circle();
  }

  State decideState() {
    if (mouseKey==1&&mouseX>400&&mouseX<465&&mouseY>20&&mouseY<70) {
      mouseKey=2;
      controlP5.remove("保存");
      ClassSetUp=true;
      return new Setting_MainHome();
    }
    return this;
  }
}

sub_Removeicon sub_remove;
class sub_Removeicon {
  boolean Moveflag[]=new boolean[Setpos.length];
  boolean MOVE;
  boolean tmpset=true;
  sub_Removeicon() {
    MOVE=false;
  }


  void Setting_Circle() {
    for (int i=4; i<Setpos.length-1; i=i+4) {
      float x=float(Setpos[i]);
      float y=float(Setpos[i+1]);
      String date="";
      int cirl=int(Setpos[i+3]);

      noStroke();
      if (sqrt(sq(mouseX-float(Setpos[i]))+sq(mouseY-float(Setpos[i+1])))<int((Setpos[i+3]))/2) {
        fill(#FFF2FF, 200);
      } else {
        fill(#FFF2FF, 80);
      }
      ellipse(x, y, cirl, cirl);

      switch(int(Setpos[i+2])) {
      case 0://時計
        clock=new Clock();
        clock.display(x, y, cirl);
        date="時計";
        break;
      case 1://やることリスト
        image(icon003, x, y, cirl-32, cirl-32);
        date="やることリスト";
        break;
      case 2://メモ
        image(icon002, x, y, cirl-32, cirl-32);
        date="メモ";
        break;
      case 3://ツイッター
        image(icon007, x, y, cirl, cirl);
        date="ツイッター";
        break;
      case 4://学生帽
        image(icon006, x, y, cirl-32, cirl-32);
        date="Search";
        break;
      case 5://カレンダー
        image(icon001, x, y, 63, 63);
        date="カレンダー";
        break;
      case 6://設定
        image(icon005, x, y, 63, 63);
        date="設定";
        break;
      case 7:
        image(icon004, x, y, 63, 63);
        break;
      case 8:
        image(icon008, x, y, 63, 63);
        break;
      }

      if (sqrt(sq(mouseX-x)+sq(mouseY-y))<int(cirl)&&MOVE==false) {
        if (mouseKey==1) {
          mouseKey=2;
          tmpset=true;
          Moveflag[i]=true;
          MOVE=true;
        }
      }

      //削除したいサークルを選択
      if (Moveflag[i]&&MOVE) {
        mouseKey=2;
        if (tmpset) {
          controlP5.addButton("決定").setLabel("SAVE").setPosition(width/2-100, height/2-40).setSize(200, 80);
          controlP5.addButton("キャンセル").setLabel("CANCEL").setPosition(width/2-100, height/2+90).setSize(200, 80);
          tmpset=false;
        }
        fill(255, 50);
        rect(width/4, height/4, width/2, height/2, 10);
        fill(0);
        textAlign(CENTER);
        text(date+"を消去しますか？", width/2, height/2-80);


        if (!ClassSetUp&&mousePressed&&mouseX>width/2-100&&mouseX<width+100&&mouseY>height/2-40&&(mouseY<height/2+40)) {
          println("??");
          Setpos[i]=Setpos[Setpos.length-4];
          Setpos[i+1]=Setpos[Setpos.length-3];
          Setpos[i+2]=Setpos[Setpos.length-2];
          Setpos[i+3]=Setpos[Setpos.length-1];
          String addtext[]=new String [Setpos.length-4];
          for (int j=1; j<Setpos.length-4; j++) {
            println(Setpos.length-4);

            addtext[j]=Setpos[j];
          }
          saveStrings("data/MainManu_Circle_position.txt", addtext);

          //Setpos=loadStrings("MainManu_Circle_position.txt");
          Moveflag[i]=false;
          MOVE=false;
          controlP5.remove("決定");
          controlP5.remove("キャンセル");
          ClassSetUp=true;
        } else if (mouseX>width/2-100&&mouseX<width+100&&mouseY>height/2+90&&(mouseY<height/2+170)) {
          if (mousePressed) {
            controlP5.remove("決定");
            controlP5.remove("キャンセル");
            Moveflag[i]=false;
            MOVE=false;
          }
        }
      }
    }
  }
}
