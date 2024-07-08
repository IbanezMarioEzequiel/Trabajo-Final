class Nave implements IVisualizable {
  private Transform transform;          // Transform de la nave (posición)
  private ImageComponent imageComponent;// Componente de imagen para visualizar la nave
  private ArrayList<Bala> balas;        // Lista de balas disparadas por la nave
  private PVector velocidad;            // Velocidad de movimiento de la nave
  private int energia;                  // Energía de la nave

  // Constructor vacío
  public Nave() {
  }

  // Constructor con parámetros para inicializar la nave
  public Nave(Transform transform, ImageComponent imageComponent, PVector velocidad, int energia) {
    this.transform = transform;
    this.imageComponent = imageComponent;
    this.balas = new ArrayList<Bala>();
    this.velocidad = velocidad;
    this.energia = energia;
  }

  // Método para mostrar la nave y sus balas
  public void display() {
    imageComponent.displayImage(transform.getPosition(), 100, 100); // Mostrar la imagen de la nave

    for (int i = 0; i < balas.size(); i++) {
      Bala b = balas.get(i);
      b.display(); // Llama al método display de la clase Bala para mostrar cada bala

      // Eliminar la bala si sale fuera de la pantalla
      if (b.getBala().getPosicion().y < 0) {
        balas.remove(i); // Elimina la bala de la lista si su posición y es menor que 0
      }
    }
  }

  // Método para mover la nave en una dirección específica
  public void mover(String direccion) {
    switch (direccion) {
      case "Arriba":
        if (transform.getPosition().y > 0) { // Mover hacia arriba si no se sale de la pantalla
          transform.getPosition().y -= velocidad.y; // Resta velocidad en y para mover la nave hacia arriba
        }
        break;
      case "Izquierda":
        if (transform.getPosition().x > 50) { // Mover hacia la izquierda si no se sale de la pantalla
          transform.getPosition().x -= velocidad.x; // Resta velocidad en x para mover la nave hacia la izquierda
        }
        break;
      case "Abajo":
        if (transform.getPosition().y < height - 50) { // Mover hacia abajo si no se sale de la pantalla
          transform.getPosition().y += velocidad.y; // Suma velocidad en y para mover la nave hacia abajo
        }
        break;
      case "Derecha":
        if (transform.getPosition().x < width - 50) { // Mover hacia la derecha si no se sale de la pantalla
          transform.getPosition().x += velocidad.x; // Suma velocidad en x para mover la nave hacia la derecha
        }
        break;
    }
  }

  // Método para generar una nueva bala desde la posición actual de la nave
  public void generarBala() {
    Transform transformBala = new Transform(new PVector(this.transform.getPosition().x, this.transform.getPosition().y)); // Posición inicial de la bala
    balas.add(new Bala(transformBala, new PVector(0, int((width + height) / 2) * Time.getDeltaTime(frameRate)))); // Agregar nueva bala a la lista de balas
  }

  // Métodos getter y setter para los atributos de la clase

  public Transform getTransform() {
    return transform;
  }

  public void setTransform(Transform transform) {
    this.transform = transform;
  }

  public ImageComponent getImageComponent() {
    return imageComponent;
  }

  public void setImageComponent(ImageComponent imageComponent) {
    this.imageComponent = imageComponent;
  }

  public PVector getVelocidad() {
    return velocidad;
  }

  public void setVelocidad(PVector velocidad) {
    this.velocidad = velocidad;
  }

  public int getEnergia() {
    return energia;
  }

  public void setEnergia(int energia) {
    this.energia = energia;
  }
}
