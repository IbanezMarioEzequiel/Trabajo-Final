class SpriteAsteroide implements IVisualizable {
  private PImage sprite;
  private int widthFrame;
  private int heightFrame;
  private int xFrame;
  private int yFrame=0;
  private PVector posicion;
  private PVector velocidad;

  SpriteAsteroide() {
    sprite = requestImage("asteroide.png");//toma la imagen del
    widthFrame=1216/4;  //ancho del Frame
    heightFrame=317;//alto del Frame
    xFrame=0;//posición x del Frame
    yFrame=0;//posición y del Frame
  }
  void display() {
    imageMode (CENTER);
    image(sprite.get(xFrame, yFrame, widthFrame, heightFrame), this.posicion.x, this.posicion.y, 80, 80);
    xFrame = xFrame + widthFrame;
    if (xFrame>=sprite.width) {
      xFrame =2*widthFrame;
    }
  }
  void movimiento(){
      this.posicion.y+=velocidad.y; //le resta ala posicion la velocidad del PVector y 
  }
  void setPosicion(PVector pos) {
    this.posicion=pos;
  }
  PVector getPosicion() {
    return this.posicion;
  }
  void setVelocidad(PVector vel) {
    this.velocidad=vel;
  }
}
