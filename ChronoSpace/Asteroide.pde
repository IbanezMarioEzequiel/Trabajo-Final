class Asteroide implements IVisualizable{
  // Variables privadas de la clase
  private Transform transform;  // Transform del asteroide (posición)
  private int resistencia; // Resistencia del asteroide
  private int alto; // Altura del asteroide
  private int ancho; // Ancho del asteroide
  private SpriteAsteroide spriteAsteroide; // Sprite animado del asteroide
  private PVector velocidad; // Vector de velocidad del asteroide
  
 // Constructor por defecto
  public Asteroide() {
}
  
 // Constructor con parámetros
  public Asteroide(Transform transform, PVector velocidad, int resistencia, int alto, int ancho) {
    this.transform = transform;
    this.velocidad = velocidad;
    this.resistencia = resistencia;
    this.alto = alto;
    this.ancho = ancho;
    spriteAsteroide = new SpriteAsteroide(); // Crear un nuevo sprite del asteroide
    // Asignar una nueva posición al sprite del asteroide utilizando la posición del transform del asteroide
    spriteAsteroide.setPosicion(new PVector(transform.getPosition().x, transform.getPosition().y));
    // Asignar una nueva velocidad al sprite del asteroide utilizando la velocidad del asteroide
    spriteAsteroide.setVelocidad(new PVector(0, this.velocidad.y));
  }
  
  // Getter y Setter para transform
  public Transform getTransform() {
    return transform;
  }

  public void setTransform(Transform transform) {
    this.transform = transform;
  }

  // Getter y Setter para resistencia
  public int getResistencia() {
    return resistencia;
  }

  public void setResistencia(int resistencia) {
    this.resistencia = resistencia;
  }

  // Getter y Setter para alto
  public int getAlto() {
    return alto;
  }

  public void setAlto(int alto) {
    this.alto = alto;
  }

  // Getter y Setter para ancho
  public int getAncho() {
    return ancho;
  }

  public void setAncho(int ancho) {
    this.ancho = ancho;
  }

  // Método para mostrar el sprite del asteroide en la pantalla
  public void display() {
    spriteAsteroide.display();
  }

  // Método para debilitar la resistencia del asteroide en 10 unidades
  public void debilitar() {
    this.resistencia -= 10;
  }

  // Getter para el sprite del asteroide
  public SpriteAsteroide getSpriteAsteroide() {
    return this.spriteAsteroide;
  }

  // Método para verificar si el asteroide está destruido
  public boolean estaDestruido() {
    // Si la resistencia es menor o igual a 0, el asteroide está destruido
    if (this.resistencia <= 0) {
      return true; // Devuelve verdadero
    } else {
      return false; // Devuelve falso
    }
  }
}
