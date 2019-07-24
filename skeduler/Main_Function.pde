//クリック
void mousePressed() {
  if (mouseButton == LEFT) mouseKey = 1;
}

//離す
void mouseReleased() {
  if (mouseButton == LEFT) mouseKey = 0;
}

//(これは年、日でいれてサブストリングで日付判断する等するよってことですうけるね
String TODO(String deta, int y, int m, int d) {
  String tmp="";
  if (y==int(deta.substring(2, 6))&&m==int(deta.substring(7, 9))&&d==int(deta.substring(10, 12))) {
    String show[]=split(deta, ",");
    tmp= show[4]; //ここでその日のやることデータを吐き出す。
  }
  return tmp;
}

String DetailTODO(int y, int m, int d) {//これがぬるを吐く＝＝その日にタスクはない
  String Disp="null";
  for (int t=0; t<Sub.length; t++) {
    if (y==int(Sub[t].substring(2, 6))&&m==int(Sub[t].substring(7, 9))&&d==int(Sub[t].substring(10, 12))) {
      String show[]=split(Sub[t], ",");
      Disp=show[4]; //ここでその日のやることデータを吐き出す。
    }
  }
  return Disp;
}



String DetailTODOmemo(int y, int m, int d) {//これがぬるを吐く＝＝その日にタスクはない
  String Disp="";
  for (int t=0; t<Sub.length; t++) {
    if (y==int(Sub[t].substring(2, 6))&&m==int(Sub[t].substring(7, 9))&&d==int(Sub[t].substring(10, 12))) {
      String show[]=split(Sub[t], ",");
      Disp=show[5]; //ここでその日のやることデータの詳しいメモを表示する。詳しいめもを！！！！！！！！！！！！！！！！！
    }
  }
  return Disp;
}

int Subdetailtodokind(int y, int m, int d) {//タスクの種類を吐き出す
  int disp=100;
  for (int t=0; t<Sub.length; t++) {
    if (y==int(Sub[t].substring(3, 7))&&m==int(Sub[t].substring(9, 10))&&d==int(Sub[t].substring(11, 13))) {
      String show[]=split(Sub[t], ",");
      disp=int(show[0]); //ここでその日のやることデータを吐き出す。
    } else {
      disp=4;
    }
  }
  return disp;
}

//一番上のタイトルの帯を表示
void TopLabel(String title, int size, int x, int y) {
  fill(255); 
  textAlign(CENTER); 
  //textSize(size); 
  textFont(Font004, size);
  text(title, x, y); //そしてテキストを上から重ねry
}

//グラデーションを作るよ
void Backcolor(color c1, color c2) {
  noStroke();
  for (float w = 0; w < height; w += 5) {
    float r = map(w, 0, height, red(c1), red(c2));
    float g = map(w, 0, height, green(c1), green(c2));
    float b = map(w, 0, height, blue(c1), blue(c2));
    fill(r, g, b);
    rect(0, w, height, 5);
  }
}

int Numbertodo(int y, int m, int d) {
  int n=0;
  for (int i=0; i<Sub.length; i++) {
    if (y==int(Sub[i].substring(2, 6))&&m==int(Sub[i].substring(7, 9))&&d==int(Sub[i].substring(10, 12))) {
      n++;
    }
  }
  return n;
}


boolean   cngAlpha;    //変化開始FLG
Fadeinout inout;
class Fadeinout {
  float     alpha;       //透明度

  boolean   fadeMode;    //フェードイン・アウト切り替えFLG

  Fadeinout () {
    //透明度の変化は「停止」にしておく
    cngAlpha = false;

    //最初はフェードインから始めたいので
    //現在の状態を「フェードアウト」に仮設定する
    fadeMode = false;
  }
  void jikkou() {
    //透明度を変化させる場合
    if ( cngAlpha == true ) {
      //モードに応じて処理する
      if ( fadeMode == true ) {
        //フェードイン
        fadeIn();
      } else {
        //フェードアウト
        fadeOut();
      }
    }
  }


  //フェードイン処理関数
  void fadeIn() {
    //徐々に濃くする
    alpha = alpha + 4f;

    //不透明になったら変化終了
    if ( alpha > 255f ) { 
      alpha = 255f; 
      cngAlpha = false;
    }
  }

  //フェードアウト処理関数
  void fadeOut() {
    //徐々に薄くする
    alpha = alpha - 4f;

    //透明になったら変化終了
    if ( alpha < 0f ) {
      alpha = 0f;
      cngAlpha = false;
    }
  }
  void mouseClicked(){
  //マウスクリックで変化開始
  cngAlpha = true; 
  
  //クリックされるごとにフェードイン・アウトを
  //切り替える
  if( fadeMode == true ){
    //今フェードインなら、次はフェードアウト
    alpha = 255f;
    fadeMode = false;
  } else {
    //今フェードアウトなら、次はフェードイン
    alpha = 0f;
    fadeMode = true;
  }
}
}
