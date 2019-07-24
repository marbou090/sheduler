class Main_ToDoList extends State {
  void drawState() {
    int[]select={50, 125, 260, 125, 50, 335, 260, 335};
    String[]texttle={"Add schedule", "Search", "Latest schedule", "Schedule list"};
    PImage[]icon={icon004, icon008, icon003, icon006};
    if (ClassSetUp) {
      mouseKey=0;
      controlP5.addButton("BackPage").setLabel("<").setPosition(25, 20).setSize(45, 45); 
      nextpage=7;
      ClassSetUp=false;
    }
    Backcolor(#0F4993, #88AEDE);
    
    TopLabel("To Do List", 50, width/2, 60);
    //imageMode(CENTER);
    for (int i=0; i<select.length; i=i+2) {
      if (mouseX>select[i]&&mouseX<select[i]+175&&mouseY>select[i+1]&&mouseY<select[i+1]+175) {
        fill(255, 160);
      } else {
        fill(255, 99);
      }
      if (mouseKey==1&&mouseX>select[i]&&mouseX<select[i]+175&&mouseY>select[i+1]&&mouseY<select[i+1]+175) {
        nextpage=i/2;
      }
      rect(select[i], select[i+1], 175, 175, 30);
      image(icon[i/2], select[i]+88, select[i+1]+75, 100, 100);
      textSize(25);
      fill(255);
      text(texttle[i/2], select[i]+88, select[i+1]+160);
    }
  }

  State decideState() {
    if (mouseKey==1&&mouseX>25&&mouseX<70&&mouseY>20&&mouseY<65) {
      controlP5.remove("BackPage");
      ClassSetUp=true;
      return new MainHome();
    }
    if (nextpage!=7) {
      controlP5.remove("BackPage");
      ClassSetUp=true;
      switch(nextpage) {
      case 0:
        return new AddToDo();
      case 1:
        return new SearchToDo();
      case 2:
        return new Main_Nextday7_ToDoList();
      case 3:
        return new Sub_ToDoList();
      }
    }
    return this;
  }
}
