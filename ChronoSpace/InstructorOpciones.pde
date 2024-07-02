class InstructorOpciones{
  private int stateOption; // Variable que sirve de ayuda para el estado de las opciones
  private PVector posicion;
  
  public InstructorOpciones() {
    this.posicion = new PVector(width/2,height/2);
  }
  
  public void display(int stateScreen, String[] opciones, int i, int opcionSeleccionada) {
    switch(this.stateOption) {
      case StateOption.OPCIONMARCADA:{
        if(stateScreen==StateScreen.MENU) {
          fill(0, 223, 229); // Este es el color de la opción seleccionada
          textAlign(CENTER);
          text(opciones[opcionSeleccionada], posicion.x, posicion.y+140 + i * 80);
          if(opcionSeleccionada == 0) {
            fill(255, 255, 0);
            text("x", posicion.x-92, posicion.y+140 + i * 80);
            text("x", posicion.x+92, posicion.y+140 + i * 80);
          } else if(opcionSeleccionada == 1) {
            fill(255, 255, 0);
            text("x", posicion.x-55, posicion.y+140 + i * 80);
            text("x", posicion.x+55, posicion.y+140 + i * 80);
          }
        } else if(stateScreen==StateScreen.DERROTA) {
          fill(0, 223, 229); // Este es el color de la opción seleccionada
          textAlign(CENTER);
          text(opciones[i], posicion.x-100 + i * 200, posicion.y+200);
        }
      break;
      }
      case StateOption.OPCIONNOMARCADA:{
        if(stateScreen==StateScreen.MENU) {
          fill(0); // Las demás opciones estarán en color negro y sin las "x" en ambos extremos
          textAlign(CENTER);
          text(opciones[i], posicion.x, posicion.y+140 + i * 80);
        } else if(stateScreen==StateScreen.DERROTA) {
          fill(255); // Las demás opciones estarán en color blanco
          textAlign(CENTER);
          text(opciones[i], posicion.x-100 + i * 200, posicion.y+200);
        }
      }
    }
  }
  
  public int getStateOption() {
    return this.stateOption;
  }
  
  public void setStateOption(int stateOption) {
    this.stateOption=stateOption;
  }
  
  public PVector getPosicion() {
    return this.posicion;
  }
  
  public void setPosicion(PVector posicion) {
    this.posicion=posicion;
  }
}
