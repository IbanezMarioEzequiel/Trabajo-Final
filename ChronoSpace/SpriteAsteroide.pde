class SpriteAsteroide implements IVisualizable {
  // Variables privadas de la clase
  private PImage sprite;// Imagen que contiene el sprite sheet
  private int widthFrame;// Ancho de cada frame del sprite
  private int heightFrame;// Altura de cada frame del sprite
  private int xFrame;// Posición x del frame actual en el sprite
  private int yFrame;// Posición y del frame actual en el sprite
  private int cantFrames; // Cantidad total de frames en el sprite
  private int contFrames; // Contador de frames para la animación
  private PVector posicion;// Vector de posición del asteroide
  private PVector velocidad;// Vector de velocidad del asteroide
  private int tiempoSprite; // Tiempo de referencia para controlar la velocidad de la animación


  SpriteAsteroide() {
    sprite = requestImage("asteroide2.png"); // Cargar la imagen del sprite sheet
    widthFrame = 1040 / 8; // Calcular el ancho de cada frame dividiendo el ancho total del sprite entre la cantidad de frames
    heightFrame = 271; // Asignar la altura del frame
    xFrame = 0; // Inicializar la posición x del frame actual
    yFrame = 0; // Inicializar la posición y del frame actual
    cantFrames = 8; // Establecer la cantidad total de frames
    contFrames = 1; // Inicializar el contador de frames
    tiempoSprite = 2 * millis() / 1000; // Establecer el tiempo inicial de referencia

}
// Método para mostrar el sprite en la pantalla
  void display() {
    imageMode(CENTER); // Establecer el modo de la imagen en el centro
    if (contFrames <= cantFrames) { // Verificar si el contador de frames es menor o igual a la cantidad total de frames
      // Dibujar la imagen del frame actual en la posición del asteroide, redimensionada a 80x80
      image(sprite.get(xFrame, yFrame, widthFrame, heightFrame), this.posicion.x, this.posicion.y, 80, 80);
      if (millis() - tiempoSprite >= 60) { // Verificar si ha pasado suficiente tiempo para cambiar de frame
        xFrame = xFrame + widthFrame; // Avanzar a la siguiente posición x del frame
        contFrames++; // Incrementar el contador de frames
        tiempoSprite = millis(); // Actualizar el tiempo de referencia
      }
      if (xFrame >= sprite.width) { // Si se alcanza el final del sprite
        xFrame = 0; // Reiniciar la posición x del frame
        contFrames = 1; // Reiniciar el contador de frames
      }

      this.posicion.y += velocidad.y; // Mover el asteroide hacia abajo en función de su velocidad
    }
  }
  // Método para establecer la posición del asteroide
  void setPosicion(PVector pos) {
    this.posicion = pos;
  }

  // Método para obtener la posición del asteroide
  PVector getPosicion() {
    return this.posicion;
  }

  // Método para establecer la velocidad del asteroide
  void setVelocidad(PVector vel) {
    this.velocidad = vel;
  }
}
