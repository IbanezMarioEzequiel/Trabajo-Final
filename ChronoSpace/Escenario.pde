class Escenario implements IVisualizable {
  // Variables privadas de la clase
  private PImage nivel1; // Imagen del nivel 1
  private PImage nivel2; // Imagen del nivel 2
  private PImage nivel3; // Imagen del nivel 3
  private int widthFrame; // Ancho de cada frame
  private int heightFrame; // Altura de cada frame
  private int xFrame; // Posición x del frame actual en el sprite 
  private int yFrame; // Posición y del frame actual en el sprite 
  private float xFrameFloat; // Posición x del frame actual en float para transiciones suaves
  private float nextxFrameFloat; // Próxima posición x del frame en float
  private int velTransicion = 12; // Velocidad de transición entre frames
  private PVector posicion; // PVector de posición del escenario
  private PVector velocidad; // PVector de velocidad del escenario
  private int stateLevel; // Nivel actual del escenario

  // Constructor de la clase Escenario
  Escenario() {
    xFrame = 0;
    yFrame = 0;
    nivel1 = requestImage("Nivel1Beta1.png"); // Cargar imagen del nivel 1
    nivel2 = requestImage("Nivel2Beta.png"); // Cargar imagen del nivel 2
    nivel3 = requestImage("lv3Beta-sheet.png"); // Cargar imagen del nivel 3
    widthFrame = 36000 / 60; // Calcular el ancho de cada frame
    heightFrame = 600; // Asignar la altura del frame
  }

  // Método para mostrar el escenario en la pantalla
  void display() {
    switch (this.stateLevel) {
      case StateLevel.PRIMERNIVEL: {
        imageMode(CENTER); // Establecer el modo de la imagen en el centro
        // Dibujar el frame actual del nivel 1
        image(nivel1.get(xFrame, yFrame, widthFrame, heightFrame), this.posicion.x, this.posicion.y, width, height);
        xFrameFloat += (widthFrame * velTransicion * Time.getDeltaTime(frameRate)); // Calcular la posición x del siguiente frame
        if (xFrameFloat >= nextxFrameFloat) {
          this.xFrame += this.widthFrame; // Avanzar al siguiente frame
          nextxFrameFloat = xFrame + this.widthFrame; // Calcular la próxima posición x del frame
          if (this.xFrame >= this.nivel1.width) {
            this.xFrame = 0; // Reiniciar la posición x del frame si se alcanza el final de la imagen
            this.xFrameFloat = 0;
            this.nextxFrameFloat = this.widthFrame;
          }
        }
        break;
      }
      case StateLevel.SEGUNDONIVEL: {
        imageMode(CENTER);
        image(nivel2.get(xFrame, yFrame, widthFrame, heightFrame), this.posicion.x, this.posicion.y, width, height);
        xFrameFloat += (widthFrame * velTransicion * Time.getDeltaTime(frameRate));
        if (xFrameFloat >= nextxFrameFloat) {
          this.xFrame += this.widthFrame;
          nextxFrameFloat = xFrame + this.widthFrame;
          if (this.xFrame >= this.nivel2.width) {
            this.xFrame = 0;
            this.xFrameFloat = 0;
            this.nextxFrameFloat = this.widthFrame;
          }
        }
        break;
      }
      case StateLevel.TERCERNIVEL: {
        imageMode(CENTER);
        image(nivel3.get(xFrame, yFrame, widthFrame, heightFrame), this.posicion.x, this.posicion.y, width, height);
        xFrameFloat += (widthFrame * velTransicion * Time.getDeltaTime(frameRate));
        if (xFrameFloat >= nextxFrameFloat) {
          this.xFrame += this.widthFrame;
          nextxFrameFloat = xFrame + this.widthFrame;
          if (this.xFrame >= this.nivel3.width) {
            this.xFrame = 0;
            this.xFrameFloat = 0;
            this.nextxFrameFloat = this.widthFrame;
          }
        }
        break;
      }
    }
  }

  // Método para mover el escenario
  void movimiento() {
    this.posicion.y -= velocidad.y;
  }

  // Método para establecer la posición del escenario
  void setPosicion(PVector pos) {
    this.posicion = pos;
  }

  // Método para obtener la posición del escenario
  PVector getPosicion() {
    return this.posicion;
  }

  // Método para establecer la velocidad del escenario
  void setVelocidad(PVector vel) {
    this.velocidad = vel;
  }

  // Método para establecer el nivel del escenario
  void setStateLevel(int stateLevel) {
    this.stateLevel = stateLevel;
  }

  // Método para obtener el nivel del escenario
  int getStateLevel() {
    return this.stateLevel;
  }
}
