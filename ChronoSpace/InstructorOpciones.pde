class InstructorOpciones {
  private int stateOption; // Estado de las opciones
  private PVector posicion; // Posición base para mostrar las opciones
  private int distanciaOpciones; // Distancia vertical o horizontal entre las opciones

  // Constructor vacío
  public InstructorOpciones() {
  }

  // Método para mostrar las opciones dependiendo del estado y la pantalla actual
  public void display(int stateScreen, String[] opciones, int i, int opcionSeleccionada) {
    switch(this.stateOption) {
      case StateOption.OPCIONMARCADA: { // Si la opción está marcada
        if (stateScreen == StateScreen.MENU) {
          fill(0, 223, 229); // Color de la opción seleccionada en el menú
          textAlign(CENTER);
          textSize(40);
          text(opciones[i], posicion.x, posicion.y + i * distanciaOpciones); // Mostrar texto de la opción
          
          // Mostrar "x" a los lados de la opción seleccionada
          if (opcionSeleccionada == 0) {
            fill(255, 255, 0);
            textAlign(CENTER);
            textSize(30);
            text("x", posicion.x - 116, posicion.y + i * distanciaOpciones); // Posición del "x" a la izquierda
            text("x", posicion.x + 116, posicion.y + i * distanciaOpciones); // Posición del "x" a la derecha
          } else if (opcionSeleccionada == 1) {
            fill(255, 255, 0);
            textAlign(CENTER);
            textSize(30);
            text("x", posicion.x - 79, posicion.y + i * distanciaOpciones); // Posición del "x" a la izquierda
            text("x", posicion.x + 79, posicion.y + i * distanciaOpciones); // Posición del "x" a la derecha
          }
        } else if (stateScreen == StateScreen.SELECTORNIVELES) {
          fill(255, 255, 0); // Color amarillo para la opción seleccionada en el selector de niveles
          textAlign(CENTER);
          textSize(40);
          text(opciones[i], posicion.x + i * distanciaOpciones, posicion.y); // Mostrar texto de la opción
        } else if (stateScreen == StateScreen.DERROTA) {
          fill(0, 223, 229); // Color de la opción seleccionada en la pantalla de derrota
          textAlign(CENTER);
          textSize(40);
          text(opciones[i], posicion.x + i * distanciaOpciones, posicion.y); // Mostrar texto de la opción
        }
        break;
      }
      case StateOption.OPCIONNOMARCADA: { // Si la opción no está marcada
        if (stateScreen == StateScreen.MENU) {
          fill(0); // Color negro para las opciones no seleccionadas en el menú
          textAlign(CENTER);
          textSize(40);
          text(opciones[i], posicion.x, posicion.y + i * distanciaOpciones); // Mostrar texto de la opción
        } else if (stateScreen == StateScreen.SELECTORNIVELES || stateScreen == StateScreen.DERROTA) {
          fill(255); // Color blanco para las opciones no seleccionadas en el selector de niveles o pantalla de derrota
          textAlign(CENTER);
          textSize(40);
          text(opciones[i], posicion.x + i * distanciaOpciones, posicion.y); // Mostrar texto de la opción
        }
        break;
      }
    }
  }

  // Métodos getter y setter para los atributos de la clase
  public int getStateOption() {
    return this.stateOption;
  }

  public void setStateOption(int stateOption) {
    this.stateOption = stateOption;
  }

  public PVector getPosicion() {
    return this.posicion;
  }

  public void setPosicion(PVector posicion) {
    this.posicion = posicion;
  }
  
  public int getDistanciaOpciones() {
    return this.distanciaOpciones;
  }
  
  public void setDistanciaOpciones(int distanciaOpciones) {
    this.distanciaOpciones = distanciaOpciones;
  }
}
