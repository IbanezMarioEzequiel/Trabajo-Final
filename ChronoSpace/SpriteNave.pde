class SpriteNave implements IVisualizable{
private PImage sprite;
private int widthFrame;
private int heightFrame;
private int xFrame;
private int yFrame=0;
private PVector posicion;

SpriteNave(){
  sprite = requestImage("nave.png");
  widthFrame=790/10;
  heightFrame=73;
  xFrame=0;
  yFrame=0;
}
  
void display(){
    imageMode (CENTER);     
        image(sprite.get(xFrame,yFrame,widthFrame,heightFrame), this.posicion.x,this.posicion.y,80,80);
        xFrame = xFrame + widthFrame;
        if (xFrame>=sprite.width) {         
            xFrame =2*widthFrame;          
          }
  }
}
