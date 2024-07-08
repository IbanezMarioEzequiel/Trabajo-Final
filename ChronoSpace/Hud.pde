class HUD {
  private int tiempoRestante; // Tiempo restante en segundos
  private int minutosTiempoR; // Minutos restantes
  private int segundosTiempoR; // Segundos restantes
  private String conversionSegundos; // Segundos restantes en formato de dos dígitos
  private PImage energia100; // Imagen de energía al 100%
  private PImage energia75; // Imagen de energía al 75%
  private PImage energia50; // Imagen de energía al 50%
  private PImage energia25; // Imagen de energía al 25%

  // Constructor de la clase HUD
  public HUD() {
  }

  // Método para mostrar el tiempo restante
  public void mostrarTiempo() {
    minutosTiempoR = int(tiempoRestante / 60); // Conversión del tiempo restante en minutos
    segundosTiempoR = int(tiempoRestante % 60); // Conversión del tiempo restante en segundos
    conversionSegundos = nf(segundosTiempoR, 2); // Mostrar siempre los segundos restantes en 2 dígitos
    fill(255); 
    textAlign(LEFT, TOP); // Alineación del texto
    textSize(25); // Tamaño del texto
    text("Tiempo restante: " + minutosTiempoR + ":" + conversionSegundos, 10, 15); // Mostrar el tiempo restante
  }

  // Método para mostrar la energía de la nave
  public void mostrarEnergia(Nave nave) {
    // Cargar las imágenes de energía
    energia100 = loadImage("Energy Stage 1.png");
    energia75 = loadImage("Energy Stage 2.png");
    energia50 = loadImage("Energy Stage 3.png");
    energia25 = loadImage("Energy Stage 4.png");
    imageMode(CENTER); // Modo de imagen centrado
    // Mostrar la imagen de energía correspondiente
    if (nave.energia == 100) {
      image(energia100, 50, height / 2, 80, 80);
    } else if (nave.energia == 75) {
      image(energia75, 50, height / 2, 80, 80);
    } else if (nave.energia == 50) {
      image(energia50, 50, height / 2, 80, 80);
    } else if (nave.energia == 25) {
      image(energia25, 50, height / 2, 80, 80);
    }
  }

  // Método para establecer el tiempo restante
  public void setTiempoRestante(int tiempoRestante) {
    this.tiempoRestante = tiempoRestante;
  }

  // Método para obtener el tiempo restante
  public int getTiempoRestante() {
    return this.tiempoRestante;
  }
}
