class thisdayTodo extends State {
  void drawState() {
    if (ClassSetUp) {
      detail=new Detailtodo();
      controlP5.addButton("BackPage").setLabel("<").setPosition(25, 15).setSize(45, 45);
      controlP5.addButton("ADDTODO").setLabel("ADD").setPosition(420, 15).setSize(45, 45);
      ClassSetUp=false;
    }
    Backcolor(#07545A, #02D4E5);
    TopLabel(Label, 40, width/2, 55);//一番上のそのページのタイトル帯
    detail.detaildisp(dispy, dispm, dispd);
  }
  State decideState() {
    if (mouseKey==1&&(mouseX>25&&mouseX<70&&mouseY>15&&mouseY<60)) {
      mouseKey=0;
      controlP5.remove("BackPage");
      controlP5.remove("ADDTODO");
      ClassSetUp=true;
      if (prepage==0) {
        return new Main_ToDoList();
      } else if (prepage==1) {
        return new Calender();
      }
    } else if (mouseKey==1&&mouseX>420&&mouseX<465&&mouseY>15&&mouseY<60) {
      mouseKey=0;
      controlP5.remove("BackPage");
      controlP5.remove("ADDTODO");
      ClassSetUp=true;
      return new AddToDo();
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
  int h=0;
  float y=0;
  void detaildisp(int f, int g, int e) {
    int Nexthigh=0;
    if (mousePressed==true&&abs(pmouseY-mouseY)>1) {
      y=y-(pmouseY-mouseY);
    }

    for (int s=0; s<2; s++) {
      int r=f;
      int m=g;
      int d=e;

      ArrayList<String>addList=new ArrayList<String>();
      while (addList.size()<Numbertodo(r, m, d)) {
        for (int t=0; t<Sub.length; t++) {
          if (r==int(Sub[t].substring(2, 6))&&m==int(Sub[t].substring(7, 9))&&d==int(Sub[t].substring(10, 12))) {
            String show[]=split(Sub[t], ",");
            String disp=(show[4]); //ここでその日のやることデータを吐き出す。
            addList.add(disp);
          }
        }
      }
      if (addList.size()==0) {
        addList.add("予定はありません");
      }
      fill(255, 35);
      rect(0, Nexthigh+80+y, 480, 30);
      textSize(25);
      fill(255);
      textFont(Font004, 25);
      textAlign(LEFT); 
      text(str(m)+" / "+str(d), 15, Nexthigh+105+y);
      for (int w=0; w<addList.size(); w++) {
        fill(255);
        textSize(30);
        textFont(Font004, 30);
        textAlign(LEFT);    
        text(addList.get(w), 40, Nexthigh+150+40*w+y);
        println(y);
      }
     
    }
  }
}
