class DetaildayTodo extends State {
  void drawState() {
    if (ClassSetUp) {
      subdetail=new detailday();
      ClassSetUp=false;
    }
    Backcolor(#0F4993, #88AEDE);
    if (DetailTODO(dispy, dispm, dispd)!="null") {
      subdetail.showaddpage(dispy, dispm, dispd);
    }
  }
  
  State decideState() {
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

  void showaddpage(int y, int m, int d) {
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
