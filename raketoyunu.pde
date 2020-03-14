int can= 3; //can

Raket raket1 = new Raket();
Top top1 = new Top();
Fuze fuze1 = new Fuze();
Fuze fuze2 = new Fuze();
Fuze fuze3 = new Fuze();
//Fuze fuze4 = new Fuze();

void setup()
{
  size(700, 600);
  background(0);
  smooth();
}

void draw()
{
  background(0);
  raket1.update();
  top1.update();
  
  if (top1.y == raket1.y && top1.x > raket1.x && top1.x <= raket1.x + (raket1.w / 2) )
  {
    top1.goLeft();
    top1.changeY(); 
  }

  if (top1.y == raket1.y && top1.x > raket1.x + (raket1.w/2) && top1.x <= raket1.x + raket1.w )
  {
    top1.goRight();
    top1.changeY();
  }
  if (top1.x + top1.D / 2 >= width)
  {
    top1.goLeft();
  }

  if (top1.x - top1.D / 2 <= 0)
  {
    top1.goRight();
  }

  //Top tavana çarparsa, farklı bir yöne doğru gitmesi
  if (top1.y - top1.D / 2 <= 0)
  {
    top1.changeY();
  }
  
  //Füze rakete çarptığında
  if (fuze1.x >= raket1.x && fuze1.x <= raket1.x + raket1.w && fuze1.y >= raket1.y && fuze1.y <= raket1.y + raket1.h)
  {
    raket1.g = 0;
    raket1.b = 0;
    can -= 1;
  }
   fuze1.update();
   //Eğer füze y yönünde belli bir mesafeye giderse, üste yeniden yüklenir ve tekrar gelir
   if (fuze1.y > fuze1.maxDist)
  {
    fuze1.reload();
    
    // raketin g ve b değerleri 255'e döner (raketi tekrar beyaz yapar).
    raket1.g = 255; 
    raket1.b = 255;
  }
  //2.füze
  if (fuze2.x >= raket1.x && fuze2.x <= raket1.x + raket1.w && fuze2.y >= raket1.y && fuze2.y <= raket1.y + raket1.h)
  {
    raket1.g = 0;
    raket1.b = 0;
    can -= 1;
  }
   fuze2.update();
   //Eğer füze y yönünde belli bir mesafeye giderse, üste yeniden yüklenir ve tekrar gelir
   if (fuze2.y > fuze2.maxDist)
  {
    fuze2.reload();
    
    // raketin g ve b değerleri 255'e döner (raketi tekrar beyaz yapar).
    raket1.g = 255; 
    raket1.b = 255;
  }
  //3.füze
  if (fuze3.x >= raket1.x && fuze3.x <= raket1.x + raket1.w && fuze3.y >= raket1.y && fuze3.y <= raket1.y + raket1.h)
  {
    raket1.g = 0;
    raket1.b = 0;
    can -= 1;
  }
   fuze3.update();
   //Eğer füze y yönünde belli bir mesafeye giderse üste yeniden yüklenir ve tekrar gelir
   if (fuze3.y > fuze3.maxDist)
  {
    fuze3.reload();
    
    // raketin g ve b değerleri 255'e döner (raketi tekrar beyaz yapar).
    raket1.g = 255; 
    raket1.b = 255;
  }
   if (top1.y > height)
  {
    top1.reset();
    can -= 1;
  }
  //Kalan canı gösterir
  textSize(18);
  text("LIVES: ", 10, 570);
  text(can, 70, 570); 
  
  // Eğer oyuncu kazanır yada kaybederse oyunu yeniden başlatmak için fareye tıklatma
  if ((can <= 0) && mousePressed)
  {
    resetGame();
  } 
  
  //Can kalmazsa oyun kaybeder
  if (can <= 0)
  {
    gameLose();
  }
}

// Oyuncu kaybettikten sonra
void gameLose()
{
  
// "Oyun bitti" kullanıcının tekrar oynamak için ekranı tıklatması
  background(0);
  textSize(40);
  text("GAME OVER", 100, 200);
  text("Click mouse to play again!", 100, 500);
  
  top1.x = -10;
  top1.y = -10;
  top1.vx = 0;
  top1.vy = 0;
  
  /*fuze1.x = -20;
  fuze1.y = -20;
  
  fuze2.x = -60;
  fuze2.y = -60;
  
  fuze3.x = -200;
  fuze3.y = -200;*/
}

void resetGame()
{
  // Tüm puan değerlerini sıfırla
  can = 3;
  
  // Füzenin maksimum mesafesini sıfırla
  fuze1.maxDist = 1000;
  fuze2.maxDist = 1000;
  fuze3.maxDist = 10000;
  
  top1.reset();
 }

 class Raket
{
  float x; //raket x
  float y; //raket y
  float w; //raket genişlik
  float h; //raket yükseklik
  float r; //raket r
  float g; //raket g
  float b; //raket b

  Raket()
  {
    x = width/2;
    y = 500;
    w = 100;
    h = 10;
    r=255;
    g=255;
    b=255;
  }
  void update()
  {
    //Raket fareyi izler
    x = mouseX;    

    fill(r, g, b);
    rect(x, y, w, h);
  }
}

class Top
{

  float x;  //top x
  float y; //top y
  float vx; //top hızı x
  float vy; //top hızı y 
  float D; 

  Top()
  {
    x = 300;
    y = 400;
    vx = 0; 
    vy = 4; 
    D = 10;
  }

  //top güncellenmesi
  void update()
  {
    noStroke();
    fill(255);
    ellipse(x, y, D, D);

    y += vy; //artma y
    x += vx; //artma x
  }

  //Top sola gider
  void goLeft()
  {
    vx = -4; //azaltma x
  }

  //Top sağa gider
  void goRight()
  {
    vx = 4; //azaltma x
  }

  //Top y yönünde değişir
  void changeY()
  {
    vy *= -1; 
  }

  //Top raketin altına düşerse sıfırlar
  void reset()
  {
    x = 300;
    y = 400;
    vx = 0;
    vy = 4;
  }
}


class Fuze
{
  float x; //füze x
  float y; //füze y
  float vy; //füze vy
  float g; //gravity
  float maxDist;// Füze, y yönünde ne kadar geri çağrılmadan önce hareket eder.
  
  Fuze()
  {
    x = random(10, width-10); // füze ekranın üstündeki rastgele pozisyonda başlar
    y = 0; //füzenin y den başlangıcı
    vy = 2; //füze y velocity
    g = 0.4; //gravity

    maxDist = 1000;
  }
  //füze güncellenmesi
   void update()
  {
    noStroke();
    fill(255, 0, 0); //füze kırmızı  
    beginShape();
    vertex(x, y);
    vertex(x-5, y-10);
    vertex(x-5, y-50);
    vertex(x, y-25);
    vertex(x+5, y-50);
    vertex(x+5, y-10);
    endShape(CLOSE);

    y += vy; //y yönünde artış
    vy += g; //GRAVITY
  }
  
  // Füzeyi yeniden yükler (ekranın en üstüne koyar).
  void reload()
  {
    x = random(10, width-10); 
    y = 0;
    vy = 2;

    noStroke();
    fill(255, 0, 0);
    beginShape();
    vertex(x, y);
    vertex(x-5, y-10);
    vertex(x-5, y-50);
    vertex(x, y-25);
    vertex(x+5, y-50);
    vertex(x+5, y-10);
    endShape(CLOSE);
  }
}
