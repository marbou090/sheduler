class Main_Nextday7_ToDoList extends State {
  void drawState() {
    if (ClassSetUp) {
      mouseKey=2;
      todo=new TodoList();
      textFont(Font002, 24);
      ClassSetUp=false;
    }
    Backcolor(#0F4993, #88AEDE);
    todo.day7_ListDraw();
  }

  State decideState() {
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


class TodoList {
  //宣言
  String[] todotitle={"TUR : TODAY : ", "FRI : TOMORROW : ", "SAT : ", "SUN : ", "MON : ", "TUR : ", "WED : "}; 
  ArrayList<String> SAV=new ArrayList<String>(); 
  int f;
  TodoList() {
    mouseKey=0;
    f=0;
    selecttodo=new boolean[Sub.length];
    controlP5.addButton("BackPage").setLabel("<").setPosition(25, 15).setSize(45, 45); 
    for (int i=0; i<Sub.length; i++) { 
      selecttodo[i]=false;
    }
  }
  void day7_ListDraw() {
    int Nexthigh=0;
    if (mousePressed==true&&abs(pmouseY-mouseY)>1) {
      f=f-(pmouseY-mouseY);
    }
    for (int s=0; s<7; s++) {
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
      if (addList.size()==0) {
        addList.add("予定はありません");
      }

      fill(255, 35);
      rect(0, Nexthigh+80+f, 480, 30);
      textSize(25);
      fill(255);
      textFont(Font004, 25);
      textAlign(LEFT); 
      text(str(m)+" / "+str(d), 15, Nexthigh+105+f);
      for (int g=0; g<addList.size(); g++) {
        fill(255);
        textSize(30);
        textFont(Font004, 30);
        textAlign(LEFT);    
        text(addList.get(g), 40, Nexthigh+150+40*g+f);
      }
      Nexthigh=Nexthigh+(addList.size()+1)*40;
    }
    TopLabel("Next 7 Days", 30, width/2, 50);//一番上のそのページのタイトル帯
  }
}
