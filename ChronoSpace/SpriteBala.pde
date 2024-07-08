class SpriteBala implements IVisualizable {
  // Variables privadas de la clase
  private PImage sprite; // Imagen que contiene el sprite
  private int widthFrame; // Ancho de cada frame del sprite
  private int heightFrame; // Altura de cada frame del sprite
  private int xFrame; // Posición x del frame actual en el sprite
  private int yFrame; // Posición y del frame actual en el sprite
  private int cantFrames; // Cantidad total de frames en el sprite
  private int contFrames; // Contador de frames para la animación
  private PVector posicion; // Vector de posición de la bala
  private PVector velocidad; // Vector de velocidad de la bala

  // Constructor de la clase SpriteBala
  SpriteBala() {
    sprite = requestImage("balas1.png"); // Cargar la imagen del sprite
    widthFrame = 790 / 10; // Calcular el ancho de cada frame dividiendo el ancho total del sprite entre la cantidad de frames
    heightFrame = 73; // Asignar la altura del frame
    xFrame = 0; // Inicializar la posición x del frame actual
    yFrame = 0; // Inicializar la posición y del frame actual
    cantFrames = 10; // Establecer la cantidad total de frames
    contFrames = 1; // Inicializar el contador de frames
  }

  // Método para mostrar el sprite en la pantalla
  void display() {
    imageMode(CENTER); // Establecer el modo de la imagen en el centro
    if (contFrames <= cantFrames) { // Verificar si el contador de frames es menor o igual a la cantidad total de frames
      // Dibujar la imagen del frame actual en la posición de la bala, redimensionada a 80x80
      image(sprite.get(xFrame, yFrame, widthFrame, heightFrame), this.posicion.x, this.posicion.y, 80, 80);
      xFrame = xFrame + widthFrame; // Avanzar a la siguiente posición x del frame
      contFrames++; // Incrementar el contador de frames
      if (xFrame >= sprite.width) { // Si se alcanza el final del sprite
        xFrame = 0; // Reiniciar la posición x del frame
        contFrames = 1; // Reiniciar el contador de frames
      }
    }
    this.posicion.y -= velocidad.y; // Mover la bala hacia arriba en función de su velocidad
  }

  // Método para establecer la posición de la bala
  void setPosicion(PVector pos) {
    this.posicion = pos;
  }

  // Método para obtener la posición de la bala
  PVector getPosicion() {
    return this.posicion;
  }

  // Método para establecer la velocidad de la bala
  void setVelocidad(PVector vel) {
    this.velocidad = vel;
  }
}
