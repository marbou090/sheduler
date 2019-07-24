class Setting_Addicon extends State {
  void drawState() {
    if (ClassSetUp) {
      sub_icon=new sub_settingicon();
      addi=false;
      controlP5.addButton("BackPage").setLabel("<").setPosition(15, 15).setSize(45, 45); 
      textFont(Font004, 30);
      ClassSetUp=false;
    }
    Backcolor(#86A500, #FAFC96);
    sub_icon.addicon();
  }

  State decideState() {
    if (mouseKey==1&&(mouseX>25&&mouseX<70&&mouseY>15&&mouseY<60)) {
      controlP5.remove("BackPage");
      ClassSetUp=true;
      return new Setting_MainHome();
    }
    if (addi) {
      controlP5.remove("BackPage");
      ClassSetUp=true;
      return new Setting_MainHome();
    }
    return this;
  }
}

sub_settingicon sub_icon;
class sub_settingicon {
  int x1, x2, y, f;
  sub_settingicon() {
    x1=width/4+30;
    x2=width/4*3-30;
    y=100;
    f=0;
  }

  void addicon() {
    textAlign(CENTER);
    noStroke();

    if (mousePressed==true&&abs(pmouseY-mouseY)>1) {
      f=f-(pmouseY-mouseY);
    }


    fill(255, 100);
    dispselect( x1, y+f, icon001, "Calender", 5);

    fill(255, 100);
    dispselect( x2, y+f, icon003, "To Do List", 1);


    fill(255, 100);
    dispselect( x1, y+200+f, icon004, "Add to do", 7);

    fill(255, 100);
    dispselect( x2, y+200+f, icon008, "Search", 8);

    fill(255, 100);
    dispselect( x1, y+400+f, icon006, "Next 7 day", 4);

    fill(255, 100);
    dispselect( x2, y+400+f, icon002, "Memo", 2);

    fill(255, 100);
    dispselect( x1, y+600+f, icon007, "Twitter", 3);
  }

  void dispselect( int x, int r, PImage img, String tex, int kind) {
    if (mouseX>x-80&&mouseX<x+80&&mouseY>r-80&&mouseY<r+110) {
      if (!addi&&mouseKey==1) {
        String [] addict=new String [Setpos.length+4];
        for (int i=0; i<Setpos.length; i++) {
          addict[i]=Setpos[i];
        }
        addict[Setpos.length]=str(width/2);
        addict[Setpos.length+1]=str(height/2);
        addict[Setpos.length+2]=str(kind);
        addict[Setpos.length+3]=str(100);
        saveStrings("data/MainManu_Circle_position.txt", addict);
        mouseKey=2;
        addi=true;
      }
      fill(255, 150);
    } else {
      fill(255, 100);
    }
    rect(x-80, r-80, 160, 190, 10);
    image(img, x, r, 120, 120);
    fill(0);
    text(tex, x, r+100);
  }
}
