class Sub_ToDoList extends State {
  void drawState() {
    if (ClassSetUp) {
      sublist=new SubToDoList();
      ClassSetUp=false;
    }
    Backcolor(#0F4993, #88AEDE);
    sublist.showList();
  }
  State decideState() {
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
  int e;

  int Nexthigh;
  SubToDoList() {
    e=0;

    controlP5.addButton("BackPage").setLabel("<").setPosition(25, 20).setSize(45, 45);
  }

  void showList() {
    Nexthigh=30;
    if (mousePressed==true&&abs(pmouseY-mouseY)>1) {
      e=e-(pmouseY-mouseY);
    }
    for (int s=0; s<Sub.length; s++) {
      int y=year();
      int m=month();
      int d=day()+s;

      ArrayList<String>addList=new ArrayList<String>();
      while (addList.size()<Numbertodo(y, m, d)) {
        for (int t=0; t<Sub.length; t++) {
          if (y==int(Sub[t].substring(2, 6))&&m==int(Sub[t].substring(7, 9))&&d==int(Sub[t].substring(10, 12))) {
            String show[]=split(Sub[t], ",");
            String disp=(show[4]); //ここでその日のやることデータを吐き出す。
            addList.add(disp);
          }
        }
        // println(addList.size(), Numbertodo(y, m, d));
      }
      // if (addList.size()==0) {
      //   addList.add("");
      // }
      //    if (addList.get(g)!="") {

      for (int g=0; g<addList.size(); g++) {
        fill(255, 35);
        rect(0, Nexthigh+80+e, 480, 30);
        textSize(25);
        fill(255);
        textFont(Font004, 25);
        textAlign(LEFT); 
        text(str(m)+" / "+str(d), 15, Nexthigh+105+e);
        fill(255);
        textSize(30);
        textFont(Font004, 30);
        textAlign(LEFT);    
        println(addList.size());
        text(addList.get(g), 40, Nexthigh+150+40*g+e);
      }
      Nexthigh=Nexthigh+(addList.size()+1)*40;
    }


    TopLabel("Schedule list", 45, width/2, 60);
  }
}
