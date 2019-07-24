class Twitter extends State {
  void drawState() {
    if(ClassSetUp){
    link( "http://twitter.com/home?status");
    ClassSetUp=false;
    }
    background(255);
  }
  State decideState() {
    return new MainHome();
  }
}
