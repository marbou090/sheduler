class AddToDo extends State {
  void drawState() {
    if (ClassSetUp) {
      //キーボードの初期化
      keyshift=false;
      KeyShift=0;
      mouseKey=0;
      ResetKeybode();
      textnow="";
      Lefttext="";
      Ligthtext="";
      mouseKey=0;
      addtodo=new SubAddToDo();
      ClassSetUp=false;
    }
    Backcolor(#0F4993, #88AEDE);
    addtodo.showaddpage();
    addtodo.hozon();
  }

  State decideState() {
    if (mouseKey==1&&mouseX>25&&mouseX<70&&mouseY>20&&mouseY<65) {
      controlP5.remove("SAVE");
      controlP5.remove("BackPage");
      Sub =loadStrings("fuck.txt");
      ClassSetUp=true;
      return new Main_ToDoList();
    }
    return this;
  }
}

SubAddToDo addtodo;
class SubAddToDo {
  boolean[] kindselect=new boolean[3];//追加するTODOの種類を決定するためのフラグ
  boolean titleinput, dayinput, monthinput, memoinput;
  String labeltitle, labelmonth, labelday, labelmemo;
  String addtext;
  int y;
  //宣言
  SubAddToDo() {
    titleinput=false;
    dayinput=false;
    monthinput=false;
    memoinput=false;
    labeltitle="";
    labelmonth="";
    labelday="";
    labelmemo="";
    addtext="";
    y=0;
    for (int i=0; i<kindselect.length; i++) {
      kindselect[i]=false;
    }
    controlP5.addButton("BackPage").setLabel("<").setPosition(25, 20).setSize(45, 45);
    controlP5.addButton("SAVE").setLabel("SAVE").setPosition(400, 20).setSize(45, 45);
  }

  void hozon() {
    if (mouseX>400&&mouseX<445&&mouseY>20&&mouseY<65&&mouseKey==1) {
      mouseKey=2;
      String add[]=new String[Sub.length+1];
      for (int i=0; i<Sub.length; i++) {
        add[i]=Sub[i];
      }
      String a="";
      if (kindselect[0]) {
        a="0";
      } else if (kindselect[1]) {
        a="1";
      } else if (kindselect[2]) {
        a="2";
      }
      add[add.length-1]=a+","+str(year())+","+str((int(labelmonth))/10)+str((int(labelmonth))%10)+","+str((int(labelday))/10)+str((int(labelday))%10)+","+labeltitle+","+labelmemo;
      saveStrings("data/fuck.txt", add);
      addtodo=new SubAddToDo();
    }
  }


  //ページ描く
  void showaddpage() {
    int dayy=180+y, kindy=250+y, memoy=320+y, titley=110+y, labely=60+y;
    if (mousePressed==true&&abs(pmouseY-mouseY)>1) {
      y=y-(pmouseY-mouseY);
      println(y);
    }

    //一番上のラベル
    TopLabel("Add schedule", 45, width/2, labely);

    //日付入力
    //日
    if (!memoinput&&!dayinput&&!monthinput&&!titleinput&&mouseX>240&&mouseX<340&&mouseY>dayy&&mouseY<dayy+50) {
      if (mouseKey==1) {
        mouseKey=2;
        textinputstart=true;
        dayinput=true;
      }
      fill(255, 150);
    } else {
      fill(255, 50);
    }
    rect(240, dayy, 100, 50);
    fill(0, 200);
    textAlign(LEFT);
    textSize(28);
    fill(0);
    text(labelday, 245, dayy+35);
    if (dayinput) {
      labelday=Masterkeybode(labelday, 375);
      if (mouseX>50&&mouseX<430&&mouseY>dayy&&mouseY<dayy+300) {
        if (mouseKey==1) {
          mouseKey=2;
          dayinput=false;
        }
      }
    }

    //月
    if (!memoinput&&!dayinput&&!monthinput&&!titleinput&&mouseX>50&&mouseX<150&&mouseY>dayy&&mouseY<dayy+50) {
      if (mouseKey==1) {
        mouseKey=2;
        textinputstart=true;
        monthinput=true;
      }
      fill(255, 150);
    } else {
      fill(255, 50);
    }
    rect(50, dayy, 100, 50);
    fill(0, 200);
    textAlign(LEFT);
    textSize(28);
    fill(0);
    text(labelmonth, 55, dayy+35);
    if (monthinput) {
      labelmonth=Masterkeybode(labelmonth, 375);
      if (mouseX>50&&mouseX<150&&mouseY>dayy&&mouseY<dayy+300) {
        if (mouseKey==1) {
          mouseKey=2;
          monthinput=false;
        }
      }
    }

    //種類選択課題その他用事
    if (mouseX>50&&mouseX<150&&mouseY>kindy&&mouseY<kindy+50) {
      fill(255, 150);
    } else {
      fill(255, 50);
    }
    if (kindselect[0]==false&&kindselect[1]==false&&kindselect[2]==false&&mouseX>50&&mouseX<150&&mouseY>kindy&&mouseY<kindy+50&&mouseKey==1) {
      kindselect[0]=true;
    }
    if (kindselect[0]) {
      fill(255, 150);
    }
    rect(50, kindy, 100, 50);
    fill(0, 200);
    textAlign(LEFT);
    textSize(28);
    text("課題", 55, kindy+35);
    if (mouseX>190&&mouseX<290&&mouseY>kindy&&mouseY<kindy+50) {
      fill(255, 150);
    } else {
      fill(255, 50);
    }
    if (kindselect[0]==false&&kindselect[1]==false&&kindselect[2]==false&&mouseX>190&&mouseX<290&&mouseY>kindy&&mouseY<kindy+50&&mouseKey==1) {
      kindselect[1]=true;
    }
    if (kindselect[1]) {
      fill(255, 150);
    }
    rect(190, kindy, 100, 50);
    fill(0, 200);
    textAlign(LEFT);
    textSize(28);
    text("用事", 195, kindy+35);
    if (mouseX>330&&mouseX<430&&mouseY>kindy&&mouseY<kindy+50) {
      fill(255, 150);
    } else {
      fill(255, 50);
    }
    if (kindselect[0]==false&&kindselect[1]==false&&kindselect[2]==false&&mouseX>330&&mouseX<430&&mouseY>kindy&&mouseY<kindy+50&&mouseKey==1) {
      kindselect[2]=true;
    }
    if (kindselect[2]) {
      fill(255, 150);
    }
    rect(330, kindy, 100, 50);
    fill(0, 200);
    textAlign(LEFT);
    textSize(28);
    text("その他", 335, kindy+35);

    //メモ
    if (!memoinput&&!dayinput&&!monthinput&&!titleinput&&mouseX>50&&mouseX<430&&mouseY>memoy&&mouseY<memoy+300) {
      if (mouseKey==1) {
        mouseKey=2;
        textinputstart=true;
        memoinput=true;
      }
      fill(255, 150);
    } else {
      fill(255, 50);
    }
    rect(50, memoy, 380, 300);
    fill(0, 200);
    textAlign(LEFT);
    textSize(28);
    fill(0);
    text(labelmemo, 55, memoy+35);
    if (memoinput) {
      labelmemo=Masterkeybode(labelmemo, 375);
      if (mouseX>50&&mouseX<430&&mouseY>memoy&&mouseY<memoy+300) {
        if (mouseKey==1) {
          mouseKey=2;
          memoinput=false;
        }
      }
    }


    //タイトル入力場所
    if (!memoinput&&!dayinput&&!monthinput&&!titleinput&&mouseX>50&&mouseX<430&&mouseY>titley&&mouseY<titley+50) {
      if (mouseKey==1) {
        mouseKey=2;
        textinputstart=true;   
        titleinput=true;
      }
      fill(255, 150);
    } else {
      fill(255, 50);
    }
    rect(50, titley, 380, 50);
    fill(0);
    text(labeltitle, 60, titley+35);
    if (titleinput) {
      labeltitle=Masterkeybode(labeltitle, 375);
      fill(0);
      if (mouseX>50&&mouseX<430&&mouseY>titley&&mouseY<titley+50) {
        if (mouseKey==1) {
          mouseKey=2;
          titleinput=false;
        }
      }
    }
  }
}
