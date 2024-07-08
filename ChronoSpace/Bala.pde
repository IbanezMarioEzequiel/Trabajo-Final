public class Bala implements IVisualizable{
  // Variables privadas de la clase
  private Transform transform; // Transformación de la bala
  private PVector velocidad; // Vector de velocidad de la bala
  private SpriteBala balaAnimacion; // Sprite animado de la bala

   // Constructor con parámetros 
  Bala( Transform transform,PVector velocidad){
    this.transform=transform;
    this.velocidad=velocidad;
    balaAnimacion = new SpriteBala(); // Crear una nueva instancia de SpriteBala
    // Asignar una nueva posición al sprite de la bala utilizando la posición del transform de la bala
    balaAnimacion.setPosicion(new PVector(transform.getPosition().x, transform.getPosition().y));
    // Asignar una nueva velocidad al sprite de la bala utilizando la velocidad de la bala
    balaAnimacion.setVelocidad(new PVector(0, this.velocidad.y));
  }

   // Método para mostrar el sprite de la bala en la pantalla
   void display(){
     balaAnimacion.display();
  }

  // Getter para la velocidad
  public PVector getVelociadad(){
    return this.velocidad;
  }

  // Setter para la velocidad
  public void setVelocidad(PVector vel){
    this.velocidad=vel;
  }

  // Getter para el transform
  public Transform getTransform() {
    return transform;
  }
  
  // Getter para el sprite de la bala
  public SpriteBala getBala() {
    return this.balaAnimacion;
  }
}
