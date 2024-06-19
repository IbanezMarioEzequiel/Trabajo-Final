public class Bala{
  private Transform transform;
  private PVector velocidad;

  Bala( Transform transform,PVector velocidad){
    this.transform=transform;
    this.velocidad=velocidad;
  }

  void display(){

  }

  void movimientoBala(){
    transform.getPosition().y-=this.velocidad.y;
  }


public PVector getVelociadad(){
    return this.velocidad;
  }

  public void setVelocidad(PVector vel){
    this.velocidad=vel;
  }

}
