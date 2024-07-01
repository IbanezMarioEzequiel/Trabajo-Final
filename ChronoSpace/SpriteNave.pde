class SpriteNave implements IVisualizable{
private PImage sprite;
private int widthFrame;
private int heightFrame;
private int xFrame;
private int yFrame;
private PVector posicion;

SpriteNave(){
  sprite = requestImage("nave.png");
  widthFrame=790/10;//ancho del Frame
  heightFrame=73;//alto del frame 
  xFrame=0;
  yFrame=0;
}
  
void display(){
    imageMode (CENTER);     
        image(sprite.get(xFrame,yFrame,widthFrame,heightFrame), this.posicion.x,this.posicion.y,80,80);        
  }
}
