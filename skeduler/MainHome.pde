class MainHome extends State {
  void drawState() {
    if (ClassSetUp) {
      Backcolor(#2F1864, #B892FA);
      D=100;
      ClassSetUp=false;
    }
    Backcolor(#2F1864, #B892FA);

    //フェイドイン
    fill(255, D);
    D=D-20;
    rect(0, 0, width, height);


    noStroke();
    float X=240;
    float Y=640/5;
    //rectMode(CENTER);
    fill(255, 40);
    rect(X-90, Y-90, 180, 180, 10);
    textAlign(CENTER);
    textFont(Font004, 50);
    fill(255);//これ消すと日付等が表示されなくなりますよ気をつけて！ばかちゃん
    text(hour()+" : "+minute(), 240, 640/5);
    textFont(Font002, 24);
    text(month()+"月"+day()+"日", 240, 640/5+45);
    Draw_Circle();
  }

  State decideState() {


    for (int i=4; i<Setpos.length-1; i=i+4) {
      if (ClassSetUp==false&&mouseKey==1&&sqrt(sq(mouseX-float(Setpos[i]))+sq(mouseY-float(Setpos[i+1])))<int(Setpos[i+3])) {
        ClassSetUp=true; 
        switch(int(Setpos[i+2])) {
        case 0://時計
          break;
        case 1://やることリスト
          return new Main_ToDoList();

        case 2://メモ
          return new Main_Memo();

        case 3://ツイッター
          return new Twitter();

        case 4://探す
          return new Main_Nextday7_ToDoList();

        case 5://カレンダー
          return new Calender();

        case 6://設定
          return new Setting_MainHome();
        case 7:
          return new AddToDo();
        case 8:
          return new SearchToDo();
        }
      }
    }

    return this;
  }
}
float angle = 0.0; //角度
void Draw_Circle() {

  for (int i=4; i<Setpos.length-1; i=i+4) {
    float x=float(Setpos[i]);
    float y=float(Setpos[i+1]);
    int date=int(Setpos[i+2]);
    int cirl=int(Setpos[i+3]);

    angle+=0.01;
    if (date%2!=0) {
      x = x+2*cos(-angle); //x座標の計算
      y = y+2*sin(-angle); //y座標の計算
    } else {
      x = x+2*cos(angle); //x座標の計算
      y = y+2*sin(angle); //y座標の計算
    }
    if (sqrt(sq(mouseX-float(Setpos[i]))+sq(mouseY-float(Setpos[i+1])))<int((Setpos[i+3]))/2) {
      fill(#FFF2FF, 190);
    } else {
      fill(#FFF2FF, 80);
    }
    noStroke();
    ellipse(x, y, cirl, cirl);
    imageMode(CENTER);
    switch(int(Setpos[i+2])) {
    case 0://時計
      clock=new Clock();
      clock.display(x, y, cirl);
      break;
    case 1://やることリスト
      image(icon003, x, y, cirl-32, cirl-32);
      break;
    case 2://メモ
      image(icon002, x, y, cirl-32, cirl-32);
      break;
    case 3://ツイッター
      image(icon007, x, y, cirl, cirl);
      break;
    case 4://７day
      image(icon006, x, y, cirl-32, cirl-32);
      break;
    case 5://カレンダー
      image(icon001, x, y, 63, 63);
      break;
    case 6://設定
      image(icon005, x, y, 63, 63);
      break;
    case 7:
      image(icon004, x, y, 63, 63);//やること追加
      break;
    case 8:
      image(icon008, x, y, 63, 63);
      break;
    }
  }
}

Clock clock;
class Clock {//アナログのくるくるする時計ちゃん
  Clock() {

    stroke(0);
    smooth();
    frameRate(30);
  }
  public void display(float x, float y, int cir) {//メインメニューのサークル４、５の座標打ち込んでそこにうんたら。半径も。
    //background(255);
    float s = second();
    float m = minute();
    float h = hour() % 12;

    pushMatrix();
    translate(x, y);
    ellipse(0, 0, cir, cir);


    noFill();
    stroke(0);
    /*
     pushMatrix();
     translate(i, j);
     rotate(PI / 6);
     ellipse(0, 0, 10, 20);
     popMatrix();
     */
    //秒針
    pushMatrix();
    rotate(radians(s*(360/60)));
    strokeWeight(1);
    line(0, 0, 0, -cir/2);
    popMatrix();

    //分針
    pushMatrix();
    rotate(radians(m*(360/60)));
    strokeWeight(2);
    line(0, 0, 0, -cir/2);
    popMatrix();


    //時針
    pushMatrix();
    rotate(radians(h*(360/12)));
    strokeWeight(4);
    line(0, 0, 0, -cir/4);
    popMatrix();

    popMatrix();
  }
}
/*
void backcolor() {
 color colorA= color(#FD9DFF);
 color colorB = color(#62C6D8);
 float dr = (red(colorB) - red(colorA))/height;
 float dg = (green(colorB) - green(colorA))/height;
 float db = (blue(colorB) - blue(colorA))/height;
 
 for(float w = 0; w < width; w += 5){
 　float r = map(w, 0, width, red(c1), red(c2));
 　float g = map(w, 0, width, green(c1), green(c2));
 　float b = map(w, 0, width, blue(c1), blue(c2));
 fill(r, g, b);
 rect(w, 0, 5, height);
 }
 }
 */
