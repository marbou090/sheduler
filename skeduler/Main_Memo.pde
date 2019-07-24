class Main_Memo extends State {
  void drawState() {
    if (ClassSetUp) {
      controlP5.addButton("BackPage").setLabel("<").setPosition(25, 20).setSize(45, 45); 
      controlP5.addButton("SAVE").setLabel("SAVE").setPosition(400, 20).setSize(45, 45);
      labelmemo=loadStrings("memo.txt");
      ResetKeybode();
      textnow="";
      Lefttext="";
      Ligthtext="";
      for (int i=1; i<labelmemo.length; i++) {
        memoadd=memoadd+labelmemo[i];
      }
      ClassSetUp=false;
    }
    color c1=#58004E;
    color c2=#FCD9B2;
    Backcolor(c1, c2);





    //タイトル入力場所
    if (!titleinput&&mouseX>50&&mouseX<430&&mouseY>100&&mouseY<600) {
      if (mouseKey==1) {
        mouseKey=2;
        textinputstart=true;   
        titleinput=true;
      }
      fill(255, 150);
    } else {
      fill(255, 50);
    }
    rect(50, 100, 380, 500);
    textAlign(LEFT);
    textSize(28);
    fill(0);
    text(memoadd, 60, 110+35);
    if (titleinput) {
      memoadd=Masterkeybode(memoadd, 375);
      fill(0);
      if (mouseX>400&&mouseX<445&&mouseY>20&&mouseY<65&&mouseKey==1) {
        if (mouseKey==1) {
          mouseKey=2;
          String add[]=new String[labelmemo.length+1];
          for (int i=0; i<labelmemo.length; i++) {
            add[i]=labelmemo[i];
          }
          add[add.length-1]=memoadd;
          saveStrings("memo.txt", add);
          titleinput=false;
        }
      }
    }



    TopLabel("MEMO", 50, width/2, 60);
  }
  State decideState() {
    if (mouseKey==1&&mouseX>25&&mouseX<70&&mouseY>20&&mouseY<65) {
      controlP5.remove("BackPage");
      controlP5.remove("SAVE");
      ClassSetUp=true;
      return new MainHome();
    }
    return this;
  }
}
