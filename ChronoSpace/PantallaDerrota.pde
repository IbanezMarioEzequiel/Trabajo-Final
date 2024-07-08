class Derrota implements IVisualizable {
  private PImage sprite;      // Sprite que contiene la animación de Game Over
  private int widthFrame;     // Ancho de cada frame del sprite
  private int heightFrame;    // Alto de cada frame del sprite
  private int xFrame;         // Posición inicial x del primer frame
  private int yFrame;         // Posición inicial y del primer frame
  private int cantFrames;     // Cantidad total de frames en la animación
  private int contFrames;     // Contador para controlar el frame actual
  private PVector posicion;   // Posición en pantalla donde se muestra la animación
  private int tiempoSprite;   // Tiempo para controlar la velocidad de la animación

  // Constructor de la clase Derrota
  Derrota() {
    sprite = requestImage("GameOverV2.png");  // Cargar el sprite de Game Over (debe estar en la carpeta de recursos del sketch)
    widthFrame = 3756 / 6;   // Ancho de cada frame del sprite (suponiendo que el sprite tiene 6 frames en una fila)
    heightFrame = 417;       // Alto de cada frame del sprite
    xFrame = 0;              // Posición inicial x del primer frame
    yFrame = 0;              // Posición inicial y del primer frame
    cantFrames = 8;          // Cantidad total de frames en la animación
    contFrames = 1;          // Inicialmente mostramos el primer frame
    tiempoSprite = millis(); // Inicializar el tiempo para controlar la velocidad de la animación
  }

  // Método para mostrar la animación de Game Over
  void display() {
    imageMode(CENTER);
    if (contFrames <= cantFrames) {  // Si todavía hay frames por mostrar en la animación
      // Mostrar el frame actual del sprite en la posición especificada
      image(sprite.get(xFrame, yFrame, widthFrame, heightFrame), this.posicion.x, this.posicion.y, width, height);
      // Controlar la velocidad de la animación basada en el tiempo transcurrido
      if (millis() - tiempoSprite >= 120) {  // Cambiar de frame cada 120
        xFrame = xFrame + widthFrame;  // Avanzar al siguiente frame en la fila
        contFrames++;  // Incrementar el contador de frames mostrados
        tiempoSprite = millis();  // Actualizar el tiempo de referencia para el siguiente cambio de frame
      }
      // Reiniciar la animación al llegar al último frame del sprite
      if (xFrame >= sprite.width) {
        xFrame = 0;       // Volver al primer frame
        contFrames = 1;   // Reiniciar el contador de frames mostrados
      }
    }
  }

  // Métodos getter y setter para acceder y modificar la posición de la animación
  void setPosicion(PVector pos) {
    this.posicion = pos;
  }
  
  PVector getPosicion() {
    return this.posicion;
  }
}
