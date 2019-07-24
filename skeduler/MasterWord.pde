class Candidates {

  // 変数
  private String data;    // 文字列を入れる
  private int matchedLength; // 一致する長さを入れる

  public Candidates(String data, int matchedLength) {
    this.data = data;
    this.matchedLength = matchedLength;
  }

  // 一致の長さを取得
  private int getMatchedLength() {
    return matchedLength;
  }

  // 文字列を取得
  private String getData() {
    return data;
  }

  // 比較用関数（優先度：一致文字の長さ、文字列の長さ、文字列）
  private int compare(Candidates obj2) {//obj1=data,obj2=matchedLenght
    Candidates obj1 = this;
    if (obj2.getMatchedLength() != obj1.getMatchedLength()) return obj2.getMatchedLength()-obj1.getMatchedLength();//もし一致率の長さで比較して大小あったらそれが即帰ってくる
    if (obj1.getData().length() != obj2.getData().length()) return obj1.getData().length()-obj2.getData().length();//もし文字列の長さで大小あったら即それを返す
    return obj1.getData().compareTo(obj2.getData());//上２つでもだめなら辞書での大小を比較してかえす
  }
}

String[] PredictiveTransformaion(String Target) {
  if (Target.equals("")) return new String[0];//からっぽをかえす
  //宣言
  String[] extensions=loadStrings("dic/"+Target.substring(0, 1)+".txt");//例えば「あ」からはじまる言葉が大量に入ってる
  ArrayList<Candidates> CandidatesData = new ArrayList<Candidates>();

  //読み込み
  if (extensions!=null) {
    for (int i=1; i<extensions.length-2; i++) {
      String[] dictmp=split(extensions[i], ",");

      //何文字目まで一致するのか
      int matchedlength=0;
      println(Target, dictmp[0]);
      while (Target.substring(0, matchedlength+1).equals(dictmp[0].substring(0, matchedlength+1))&&++matchedlength<min(dictmp[0].length(), Target.length()));

      if (matchedlength>0) {
        Candidates tmp=new Candidates(dictmp[1], matchedlength);//いれていろいろ比較する用のクラスだからそれのコンストラクタにぶちこむ
        for (int j=CandidatesData.size()-1; j>=-1; j--) {//一致率低いのから入るからケツからいれようね
          if (j!=-1&&tmp.compare(CandidatesData.get(j))==0) break;//文字の長さも一致率も辞書での大きさも一致すると０が帰ってくるのでそれつまりもうすでに候補に入ってるので除外
          if (j!=-1&&tmp.compare(CandidatesData.get(j))>0||j==-1) {//データいれる
            CandidatesData.add(j+1, tmp);
            if (CandidatesData.size()>12) CandidatesData.remove(12);
            break;
          }
        }
      }
    }
  }

  // 返却用に型を変える
  String[] s = new String [CandidatesData.size()];
  for (int i = 0; i < CandidatesData.size(); i++) s[i] = CandidatesData.get(i).getData();
  return s;
}


//String settext="テキストを入力する";   //入力前の表示
int MoveNowLine;
int MoveLine;
String KeyBodeOut = "", KeyBodeCode3="";
int h;
String Masterkeybode(String subtext, int textwidth) {//すでに入力されていた文字列と、表示したい座標、テキストの横幅（はみ出そうとしたら自動で改行）
  if (textinputstart) {
    ResetKeybode();
    Lefttext=subtext;
    MoveLine=0;
    h=0;
    textinputstart=false;
  }

  if (MoveNowLine < 0) {
    MoveNowLine = 0;
  }
  if (MoveNowLine > disptext.length()) {
    MoveNowLine = disptext.length();
  }

  //自動改行
  if (disptext.length()>0&&(disptext.length()+1)%13==0) {
    textnow=textnow+"\n";
    //Lefttext="";
    //NowLine = NowLine + 1;
  }

  //入力
  for (int i = 0; i < KeyBodeText.length; i++) {
    if (KeyBodeText[i] != "" && KeyBodeText[i] != null) {
      if (mx > KeyBodeX[i] && mx < KeyBodeX[i]+KeyBodeWidth[i] && my > KeyBodeY[i]+380&& my < KeyBodeY[i]+380+KeyBodeHeight[i]) {
        if (mouseKey == 1) {
          mouseKey=2;
          switch(KeyBodeText[i]) {
          case "Shift":
            Lefttext=Lefttext+textnow;
            textnow="";
            KeyShift = KeyShift + 1;
            if (KeyShift%2!=0) {
              KeyType=1;
              keyshift=true;
            } else {
              KeyType=0;
              keyshift=false;
            }
            break;
          case "全":
            //NowLine = NowLine + disptext.length();
            break;
          case "半":
            //NowLine = NowLine + disptext.length();
            break;
          case ">":
            MoveLine = MoveLine + 1;
            NowLine=disptext.length();
            MoveNowLine=NowLine+MoveLine;
            if (MoveNowLine > disptext.length()) {
              MoveNowLine = MoveLine-1;
            }
            break;
          case "<":
            MoveLine = MoveLine - 1;
            NowLine=disptext.length();
            MoveNowLine=NowLine+MoveLine;
            if (MoveNowLine < 0) MoveLine=MoveLine+1;
            break;
          case "<<":
            break;
          case "SP":
            textnow=textnow+"*;";
            break;
          case "Ent":
            if (textnow.length()>0) {
              Lefttext=Lefttext+textnow;
            } else if (textnow.length()== 0) {
              textnow=textnow+"\n";//検出したらそこで改行？
              Lefttext=Lefttext+textnow;
              NowLine = NowLine + 1;
            }
            textnow="";
            break;
          case "del":
            NowLine=disptext.length();
            MoveNowLine=NowLine+MoveLine;
            if (MoveLine==0&&textnow.length()>0) {
              textnow=textnow.substring(0, textnow.length()-1);//横移動なしでかつ入力中
            } else if (MoveLine==0&&textnow.length()==0&&Lefttext.length()>0) {//横移動なしでかつ未入力なし
              Lefttext=Lefttext.substring(0, Lefttext.length()-1);
            } else if (Lefttext.length()<MoveNowLine&&disptext.length()>MoveNowLine) {//ひだりに移動かつ入力中
              textnow=textnow.substring(0, MoveNowLine-Lefttext.length()-1)+textnow.substring(MoveNowLine-Lefttext.length(), textnow.length());
            }
            break;
          default:
            break;
          }
        }
      }
      if (keyshift==true) {
        disptext=Lefttext+textnow+UppercaseLetter(KeyBodeText[i])+Ligthtext;
      } else if (keyshift==false) {
        disptext=Lefttext+textnow+KeyBodeText[i]+Ligthtext;
      }
    }
  }

  //ひらがなの変換
  if (KeyType==1) {//はいシフト押されたら切り替えましてひらがな変換走りますよって。
    int TextPos = 0;
    int TextLength = 1;
    String a = "";
    while (TextPos < textnow.length()) {
      String ForRome = textnow.substring(TextPos, TextPos+TextLength);//変換対象
      String AfterConversion = ConvertToRomaji(ForRome);
      if (AfterConversion.equals(ForRome)) {//変換がなかった
        if (TextLength > 6 || TextPos+TextLength == textnow.length()) {//これ以上変換にかけても見つかる見込みがない
          a = a + textnow.substring(TextPos, TextPos+1);
          TextPos = TextPos + 1;
          TextLength = 1;
        } else {  //まだ可能性がある
          TextLength = TextLength + 1;
        }
      } else {//変換があった
        a = a + AfterConversion;
        TextPos = TextPos + ForRome.length();
        TextLength = 1;
      }
    }
    textnow = a;
  } else {
  }

  disptext=Lefttext+textnow+Ligthtext;



  //キーボードの外側の枠
  noStroke();
  fill(255);
  rect(0, 330, 480, 680);


  for (int i=1; i<LoadFile.length; i++) {//全体をぶん回す
    //今の、入力の表示
    if (mousePressed==true&&mouseX>KeyBodeX[i]&&mouseX<KeyBodeX[i]+KeyBodeWidth[i]&&mouseY>KeyBodeY[i]+380&&mouseY<KeyBodeY[i]+380+KeyBodeHeight[i]) {//はい押されましたテキストなうにいれますよって。
      if (i<28||i>=36) { 
        textnow=textnow+KeyBodeText[i];
        mousePressed=false;
      }
    }

    //キーボード描きますよ
    if (mouseX>KeyBodeX[i]&&mouseX<KeyBodeX[i]+KeyBodeWidth[i]&&mouseY>KeyBodeY[i]+380&&mouseY<KeyBodeY[i]+380+KeyBodeHeight[i]) {
      fill(0, 0, 255, 200);
    } else {
      fill(0, 0, 255, 51);
    }

    if (KeyType==1) {
      diskeybode(UppercaseLetter(KeyBodeText[i]), KeyBodeX[i], KeyBodeY[i]+380, KeyBodeWidth[i], KeyBodeHeight[i]);//;
    } else if (KeyType==0) {
      diskeybode(KeyBodeText[i], KeyBodeX[i], KeyBodeY[i]+380, KeyBodeWidth[i], KeyBodeHeight[i]);
    }
  }


  //変換前の文字列for (String s : PredictiveTransformation("あいす", 12)) println(s);
  if (textnow.length()>0) {
    int next=0;
    int x=0;

    if (mousePressed==true&&abs(pmouseX-mouseX)>1) {
      h=h-(pmouseX-mouseX);
    }
    for (String s : PredictiveTransformaion(textnow)) {
      x=x+30*next+10;
      int X=x+h;
      fill(0);
      textSize(20);
      text(s, X, 350);
      next=s.length();
      if (mouseX>x&&mouseX<x+30*next+10&&mouseY>350&&mouseY<370) {
        if (mouseKey==1) {
          mouseKey=2;
          textnow=s;
        }
      }
    }
  }

  //描画用にテキストを編集する
  if (!disptext.isEmpty()) {//中身があったら
    //まず空白
    for (int i=0; i<disptext.length(); i++) {
      if (disptext.indexOf("*;")!=-1) {
        int p1;
        p1=(disptext.indexOf("*;"));
        String unti;
        unti=disptext.substring(0, p1)+" "+disptext.substring(p1+2, disptext.length());
        disptext=unti;
        //a=disptext;
      }
    }
  }
  textAlign(LEFT);
  textSize(30);
  return disptext;
}


void ResetKeybode() {
  //キーボードのロード（初期化含む）
  KeyType=1 ;
  LoadFile = loadStrings("keybode.txt");//データはこれに入っているぞ
  KeyBodeText = new String[LoadFile.length];//なかみ
  KeyBodeX = new int[LoadFile.length];//ざひょー
  KeyBodeY = new int[LoadFile.length];//ざひょー
  KeyBodeWidth = new int[LoadFile.length];//はば
  KeyBodeHeight = new int[LoadFile.length];//たかさ
  for (int i = 1; i < LoadFile.length; i++) {
    String Temp[] = split(LoadFile[i], ",");
    KeyBodeText[i] = Temp[0];
    KeyBodeX[i] = int(Temp[1]);
    KeyBodeY[i] = int(Temp[2]);
    KeyBodeWidth[i] = int(Temp[3]);
    KeyBodeHeight[i] = int(Temp[4]);
  }
  //Lefttext=settext;
  textnow="";
  NowLine = 0;
  disptext="";
}


void diskeybode(String text, int x, int y, int insx, int insy) {
  noStroke();
  rect(x, y, insx, insy, 8);
  textAlign(LEFT, CENTER);
  textSize(18);
  fill(0);
  text(text, x+insx/2, y+insy/2);
}


String UppercaseLetter(String p1) {
  String s = p1;
  if (p1.equals("a")) s = "A";
  if (p1.equals("b")) s = "B";
  if (p1.equals("c")) s = "C";
  if (p1.equals("d")) s = "D";
  if (p1.equals("e")) s = "E";
  if (p1.equals("f")) s = "F";
  if (p1.equals("g")) s = "G";
  if (p1.equals("h")) s = "H";
  if (p1.equals("i")) s = "I";
  if (p1.equals("j")) s = "J";
  if (p1.equals("k")) s = "K";
  if (p1.equals("l")) s = "L";
  if (p1.equals("m")) s = "M";
  if (p1.equals("n")) s = "N";
  if (p1.equals("o")) s = "O";
  if (p1.equals("p")) s = "P";
  if (p1.equals("q")) s = "Q";
  if (p1.equals("r")) s = "R";
  if (p1.equals("s")) s = "S";
  if (p1.equals("t")) s = "T";
  if (p1.equals("u")) s = "U";
  if (p1.equals("v")) s = "V";
  if (p1.equals("w")) s = "W";
  if (p1.equals("x")) s = "X";
  if (p1.equals("y")) s = "Y";
  if (p1.equals("z")) s = "Z";
  if (p1.equals(".")) s = ":";
  if (p1.equals("-")) s = "+";
  if (p1.equals("/")) s = "*";
  if (p1.equals("\"")) s = "#";

  return s;
}


String ConvertToRomaji(String p1) {
  String s = "";
  if (p1.equals("a")) s = s + "あ";
  else if (p1.equals("i")) s = s + "い";
  else if (p1.equals("u")) s = s + "う";
  else if (p1.equals("e")) s = s + "え";
  else if (p1.equals("o")) s = s + "お";
  else if (p1.equals("ka")) s = s + "か";
  else if (p1.equals("ki")) s = s + "き";
  else if (p1.equals("ku")) s = s + "く";
  else if (p1.equals("ke")) s = s + "け";
  else if (p1.equals("ko")) s = s + "こ";
  else if (p1.equals("sa")) s = s + "さ";
  else if (p1.equals("si")) s = s + "し";
  else if (p1.equals("su")) s = s + "す";
  else if (p1.equals("se")) s = s + "せ";
  else if (p1.equals("so")) s = s + "そ";
  else if (p1.equals("ta")) s = s + "た";
  else if (p1.equals("ti")) s = s + "ち";
  else if (p1.equals("tu")) s = s + "つ";
  else if (p1.equals("te")) s = s + "て";
  else if (p1.equals("to")) s = s + "と";
  else if (p1.equals("na")) s = s + "な";
  else if (p1.equals("ni")) s = s + "に";
  else if (p1.equals("nu")) s = s + "ぬ";
  else if (p1.equals("ne")) s = s + "ね";
  else if (p1.equals("no")) s = s + "の";
  else if (p1.equals("ha")) s = s + "は";
  else if (p1.equals("hi")) s = s + "ひ";
  else if (p1.equals("hu")) s = s + "ふ";
  else if (p1.equals("he")) s = s + "へ";
  else if (p1.equals("ho")) s = s + "ほ";
  else if (p1.equals("ma")) s = s + "ま";
  else if (p1.equals("mi")) s = s + "み";
  else if (p1.equals("mu")) s = s + "む";
  else if (p1.equals("me")) s = s + "め";
  else if (p1.equals("mo")) s = s + "も";
  else if (p1.equals("ya")) s = s + "や";
  else if (p1.equals("yi")) s = s + "い";
  else if (p1.equals("yu")) s = s + "ゆ";
  else if (p1.equals("ye")) s = s + "いぇ";
  else if (p1.equals("yo")) s = s + "よ";
  else if (p1.equals("ra")) s = s + "ら";
  else if (p1.equals("ri")) s = s + "り";
  else if (p1.equals("ru")) s = s + "る";
  else if (p1.equals("re")) s = s + "れ";
  else if (p1.equals("ro")) s = s + "ろ";
  else if (p1.equals("wa")) s = s + "わ";
  else if (p1.equals("wi")) s = s + "うぃ";
  else if (p1.equals("wu")) s = s + "う";
  else if (p1.equals("we")) s = s + "うぇ";
  else if (p1.equals("wo")) s = s + "を";
  else if (p1.equals("za")) s = s + "ざ";
  else if (p1.equals("zi")) s = s + "じ";
  else if (p1.equals("zu")) s = s + "ず";
  else if (p1.equals("ze")) s = s + "ぜ";
  else if (p1.equals("zo")) s = s + "ぞ";    
  else if (p1.equals("ga")) s = s + "が";
  else if (p1.equals("gi")) s = s + "ぎ";
  else if (p1.equals("gu")) s = s + "ぐ";
  else if (p1.equals("ge")) s = s + "げ";
  else if (p1.equals("go")) s = s + "ご";
  else if (p1.equals("da")) s = s + "だ";
  else if (p1.equals("di")) s = s + "ぢ";
  else if (p1.equals("du")) s = s + "づ";
  else if (p1.equals("de")) s = s + "で";
  else if (p1.equals("do")) s = s + "ど";
  else if (p1.equals("ba")) s = s + "ば";
  else if (p1.equals("bi")) s = s + "び";
  else if (p1.equals("bu")) s = s + "ぶ";
  else if (p1.equals("be")) s = s + "べ";
  else if (p1.equals("bo")) s = s + "ぼ";
  else if (p1.equals("pa")) s = s + "ぱ";
  else if (p1.equals("pi")) s = s + "ぴ";
  else if (p1.equals("pu")) s = s + "ぷ";
  else if (p1.equals("pe")) s = s + "ぺ";
  else if (p1.equals("po")) s = s + "ぽ";
  else if (p1.equals("nn")) s = s + "ん";
  else if (p1.equals("fa")) s = s + "ふぁ";
  else if (p1.equals("fi")) s = s + "ふぃ";
  else if (p1.equals("fu")) s = s + "ふ";
  else if (p1.equals("fe")) s = s + "ふぇ";
  else if (p1.equals("fo")) s = s + "ふぉ";
  else if (p1.equals("la")) s = s + "ぁ";
  else if (p1.equals("li")) s = s + "ぃ";
  else if (p1.equals("lu")) s = s + "ぅ";
  else if (p1.equals("le")) s = s + "ぇ";
  else if (p1.equals("lo")) s = s + "ぉ";
  else if (p1.equals("ltu")) s = s + "っ";
  else if (p1.equals("lwa")) s = s + "ゎ";
  else if (p1.equals("lyo")) s = s + "ょ";
  else if (p1.equals("lyu")) s = s + "ゅ";
  else if (p1.equals("lya")) s = s + "ゃ";
  else if (p1.equals("xa")) s = s + "ぁ";
  else if (p1.equals("xi")) s = s + "ぃ";
  else if (p1.equals("xu")) s = s + "ぅ";
  else if (p1.equals("xe")) s = s + "ぇ";
  else if (p1.equals("xo")) s = s + "ぉ";
  else if (p1.equals("xtu")) s = s + "っ";
  else if (p1.equals("xwa")) s = s + "ゎ";
  else if (p1.equals("xyo")) s = s + "ょ";
  else if (p1.equals("xyu")) s = s + "ゅ";
  else if (p1.equals("xya")) s = s + "ゃ";
  else if (p1.equals("zya")) s = s + "じゃ";
  else if (p1.equals("zyi")) s = s + "じ";
  else if (p1.equals("zyu")) s = s + "じゅ";
  else if (p1.equals("zye")) s = s + "じぇ";
  else if (p1.equals("zyo")) s = s + "じょ";
  else if (p1.equals("sha")) s = s + "しゃ";
  else if (p1.equals("shi")) s = s + "し";
  else if (p1.equals("shu")) s = s + "しゅ";
  else if (p1.equals("she")) s = s + "しぇ";
  else if (p1.equals("sho")) s = s + "しょ";
  else if (p1.equals("sya")) s = s + "しゃ";
  else if (p1.equals("syi")) s = s + "しぃ";
  else if (p1.equals("syu")) s = s + "しゅ";
  else if (p1.equals("sye")) s = s + "しぇ";
  else if (p1.equals("syo")) s = s + "しょ";
  else if (p1.equals("qa")) s = s + "くぁ";
  else if (p1.equals("qi")) s = s + "くぃ";
  else if (p1.equals("qu")) s = s + "く";
  else if (p1.equals("qe")) s = s + "くぇ";
  else if (p1.equals("qo")) s = s + "くぉ";
  else if (p1.equals("ca")) s = s + "か";
  else if (p1.equals("ci")) s = s + "し";
  else if (p1.equals("cu")) s = s + "く";
  else if (p1.equals("ce")) s = s + "せ";
  else if (p1.equals("co")) s = s + "こ";
  else if (p1.equals("ja")) s = s + "じゃ";
  else if (p1.equals("ji")) s = s + "じ";
  else if (p1.equals("ju")) s = s + "じゅ";
  else if (p1.equals("je")) s = s + "じぇ";
  else if (p1.equals("jo")) s = s + "じょ";
  else if (p1.equals("jya")) s = s + "じゃ";
  else if (p1.equals("jyi")) s = s + "じぃ";
  else if (p1.equals("jyu")) s = s + "じゅ";
  else if (p1.equals("jye")) s = s + "じぇ";
  else if (p1.equals("jyo")) s = s + "じょ";
  else if (p1.equals("kya")) s = s + "きゃ";
  else if (p1.equals("kyi")) s = s + "きぃ";
  else if (p1.equals("kyu")) s = s + "きゅ";
  else if (p1.equals("kye")) s = s + "きぇ";
  else if (p1.equals("kyo")) s = s + "きょ";
  else if (p1.equals("nya")) s = s + "にゃ";
  else if (p1.equals("nyi")) s = s + "にぃ";
  else if (p1.equals("nyu")) s = s + "にゅ";
  else if (p1.equals("nye")) s = s + "にぇ";
  else if (p1.equals("nyo")) s = s + "にょ";
  else if (p1.equals("-")) s = s + "ー";
  else if (p1.equals("kk")) s = s + "っk";
  else if (p1.equals("ss")) s = s + "っs";
  else if (p1.equals("tt")) s = s + "っt";
  else if (p1.equals("hh")) s = s + "っh";
  else if (p1.equals("mm")) s = s + "っm";
  else if (p1.equals("yy")) s = s + "っy";
  else if (p1.equals("rr")) s = s + "っr";
  else if (p1.equals("ww")) s = s + "っw";
  else if (p1.equals("gg")) s = s + "っg";
  else if (p1.equals("zz")) s = s + "っz";
  else if (p1.equals("dd")) s = s + "っd";
  else if (p1.equals("bb")) s = s + "っb";
  else if (p1.equals("pp")) s = s + "っp";
  else if (p1.equals("ff")) s = s + "っf";
  else if (p1.equals("rya")) s = s + "りゃ";
  else if (p1.equals("ryi")) s = s + "りぃ";
  else if (p1.equals("ryu")) s = s + "りゅ";
  else if (p1.equals("rye")) s = s + "りぇ";
  else if (p1.equals("ryo")) s = s + "りょ";
  else if (p1.equals("dya")) s = s + "ぢゃ";
  else if (p1.equals("dyi")) s = s + "ぢぃ";
  else if (p1.equals("dyu")) s = s + "ぢゅ";
  else if (p1.equals("dye")) s = s + "ぢぇ";
  else if (p1.equals("dyo")) s = s + "ぢょ";
  else if (p1.equals("gya")) s = s + "ぎゃ";
  else if (p1.equals("gyi")) s = s + "ぎぃ";
  else if (p1.equals("gyu")) s = s + "ぎゅ";
  else if (p1.equals("gye")) s = s + "ぎぇ";
  else if (p1.equals("gyo")) s = s + "ぎょ";
  else if (p1.equals("va")) s = s + "ヴぁ";
  else if (p1.equals("vi")) s = s + "ヴぃ";
  else if (p1.equals("vu")) s = s + "ヴ";
  else if (p1.equals("ve")) s = s + "ヴぇ";
  else if (p1.equals("vo")) s = s + "ヴぉ";
  else if (p1.equals("tya")) s = s + "ちゃ";
  else if (p1.equals("tyi")) s = s + "ちぃ";
  else if (p1.equals("tyu")) s = s + "ちゅ";
  else if (p1.equals("tye")) s = s + "ちぇ";
  else if (p1.equals("tyo")) s = s + "ちょ";
  else if (p1.equals("tha")) s = s + "てゃ";
  else if (p1.equals("thi")) s = s + "てぃ";
  else if (p1.equals("thu")) s = s + "てゅ";
  else if (p1.equals("the")) s = s + "てゅ";
  else if (p1.equals("tho")) s = s + "てょ";
  else if (p1.equals("twa")) s = s + "とぁ";
  else if (p1.equals("twi")) s = s + "とぃ";
  else if (p1.equals("twu")) s = s + "とぅ";
  else if (p1.equals("twe")) s = s + "とぇ";
  else if (p1.equals("two")) s = s + "とぉ";
  else if (p1.equals("wha")) s = s + "うぁ";
  else if (p1.equals("whi")) s = s + "うぃ";
  else if (p1.equals("whu")) s = s + "う";
  else if (p1.equals("whe")) s = s + "うぇ";
  else if (p1.equals("who")) s = s + "うぉ";  
  else if (p1.equals("hya")) s = s + "ひゃ";
  else if (p1.equals("hyi")) s = s + "ひぃ";
  else if (p1.equals("hyu")) s = s + "ひゅ";
  else if (p1.equals("hye")) s = s + "ひぇ";
  else if (p1.equals("hyo")) s = s + "ひょ";
  else s = s + p1;

  return s;
}
