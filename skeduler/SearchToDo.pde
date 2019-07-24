
class SearchToDo extends State {
  void drawState() {
    if (ClassSetUp) {
      subsearch=new SubSearchToDo();
      ClassSetUp=false;
    }
    Backcolor(#0F4993, #88AEDE);
    subsearch.seareshword() ;
    if (mouseKey==1&&mouseX>400&&mouseX<445&&mouseY>20&&mouseY<65) {
      mouseKey=2;
      search=true;
    }
    if (mousePressed==true&&abs(pmouseY-mouseY)>1) {
      y=y-(pmouseY-mouseY);
    }
    if (search) {
      subsearch.showsearchpage(Masterkeybode(labeltitle, 375));
    }
    TopLabel("Search", 45, width/2, 60);
  }
  State decideState() {
    if (mouseKey==1&&mouseX>25&&mouseX<70&&mouseY>20&&mouseY<65) {
      controlP5.remove("BackPage");
      controlP5.remove("探す");
      ClassSetUp=true;
      return new Main_ToDoList();
    }
    return this;
  }
}

SubSearchToDo subsearch;
float y=0;
boolean titleinput, search;
String labeltitle;
class SubSearchToDo {
  SubSearchToDo() {
    titleinput=false;
    search=false;
    labeltitle="";
    controlP5.addButton("BackPage").setLabel("<").setPosition(25, 20).setSize(45, 45);
    controlP5.addButton("探す").setLabel("SEARCH").setPosition(400, 20).setSize(45, 45);
  }

  void seareshword() {
    float titley=110+y;

    if (mouseX>50&&mouseX<430&&mouseY>titley&&mouseY<titley+50) {
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
    textSize(25);
    fill(255);
    textFont(Font004, 25);
    textAlign(LEFT); 
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


  void showsearchpage(String im) { 
    int Nexthigh=100;
    ArrayList<String>addList=new ArrayList<String>();
    ArrayList<String>addListday=new ArrayList<String>();
    ArrayList<String>num=new ArrayList<String>();
    for (int t=0; t<Sub.length; t++) {
      String[] m1 = match(Sub[t], im);
      if (m1!=null) {
        String show[]=split(Sub[t], ",");
        String disp=(show[4]); //ここでその日のやることデータを吐き出す。
        addList.add(disp);
        addListday.add(show[2]+" / "+show[3]);
        num.add(str(Numbertodo(int(show[1]), int(show[2]), int(show[3]))));
      }
    }

    if (addList.size()==0) {
      addList.add("予定はありません");
    }
    if (addListday.size()==0) {
      addListday.add("");
    }

    textSize(25);
    fill(255);
    textFont(Font004, 25);
    textAlign(LEFT); 
    if (addList.size()>0) {
      int b=0;
      for (int v=0; v<addListday.size(); v++) {
        fill(255, 35);
        rect(0, Nexthigh+80+y, 480, 30);
        text(addListday.get(v), 15, Nexthigh+105+y);
          b++;
          fill(255);
          textSize(30);
          textFont(Font004, 25);
          textAlign(LEFT);    
          text(addList.get(v), 40, Nexthigh+150+40*v+y);
          println(y);
      }
    }
  }
}
