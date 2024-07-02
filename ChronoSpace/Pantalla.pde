class Pantalla implements IVisualizable{
  private PImage image;
  private PImage titulo;
  private float opacidadLogo;
  private PVector posicion;
  private int stateScreen; // Variable que sirve de ayuda para el estado de las pantallas
  private int stateOption; // Variable que sirve de ayuda para el estado de las opciones
  private boolean nombreJuego;
  private String[] opciones;
  private int i;
  private int opcionSeleccionada;
  private Nave nave;
  private GestorAsteroides gstAsteroide;
  
  public Pantalla() {
    this.image = loadImage("logo.png");
    this.titulo = loadImage("titulo.png");
    this.opacidadLogo = 255; // Inicialmente, la imagen del logo está completamente visible
    this.posicion = new PVector(width/2,height/2);
    this.stateScreen = StateScreen.LOGO; // Se inicializa la variable stateScreen con el estado del logo del grupo para que sea lo primero que se dibuje con el método mostrarPantallaActual llamado en el draw
    this.opcionSeleccionada=0;
    Transform transformNave=new Transform(new PVector(width/2,height-100));
    ImageComponent imageNave=new ImageComponent("navve.png");
    this.nave=new Nave(transformNave,imageNave,nave.bala, new PVector(10,1000*Time.getDeltaTime(frameRate)));
    this.gstAsteroide=new GestorAsteroides();
  }
  
  public void display() {
    switch(this.stateScreen) {
      case StateScreen.LOGO:{
        imageMode(CENTER);
        tint(255, opacidadLogo);
        image(image, posicion.x, posicion.y);
        opacidadLogo -= 1; // Disminuye la opacidad del logo
      break;
      }
      case StateScreen.MENU:{
        // Al terminar de mostrarse el logo, se muestra la pantalla de inicio
        imageMode(CENTER);
        noTint();
        image(gif, posicion.x, posicion.y, width, height+30); // Al tamaño del alto de la imagen se le aumentó 30 píxeles para evitar que se vean particulas negras que no tendrían que estar en el gif
    
        //Estructura de control que muestra el nombre del juego si el valor de la variable boolean "nombreJuego" es verdadero
        if(nombreJuego) {
          noTint();
          image(titulo, posicion.x, posicion.y-200, 500, 150);
        }
    
        // Estructura de control que sirve para darle un efecto de parpadeo al nombre del juego
        if(frameCount % 50 < 15) {
          nombreJuego=false;
        } else {
          nombreJuego=true;
        }
        setOpciones(new String [] {"Empezar", "Salir"});
        for(i = 0; i < opciones.length; i++) {
          if(i == opcionSeleccionada) {
            stateOption = StateOption.OPCIONMARCADA;
          } else {
            stateOption = StateOption.OPCIONNOMARCADA;
          }
        }
      break;      
      }
      case StateScreen.NIVEL:{
        background(124, 5, 5);
        nave.transform.setPosition((new PVector(width/2,height-100)));
        nave.display();
        gstAsteroide.display();
      break;
      }
      case StateScreen.VICTORIA:{
        background(0, 255, 0);
        fill(255, 0, 0);
        textAlign(CENTER);
        text("Nivel Completado", posicion.x, posicion.y);
      break;
      }
      case StateScreen.DERROTA:{
        background(0);
        setOpciones(new String[] {"Reintentar", "Salir"});
        for(i = 0; i < opciones.length; i++) {
          if(i == opcionSeleccionada) {
            stateOption = StateOption.OPCIONMARCADA;
          } else {
            stateOption = StateOption.OPCIONNOMARCADA;
          }
        }
      break;
      }
    }
  }
  
  public PVector getPosicion() {
    return this.posicion;
  }
  
  public void setPosicion(PVector posicion) {
    this.posicion=posicion;
  }
  
  public int getStateScreen() {
    return this.stateScreen;
  }
  
  public void setStateScreen(int stateScreen) {
    this.stateScreen=stateScreen;
  }
  
  public String[] getOpciones() {
    return this.opciones;
  }
  
  public void setOpciones(String[] opciones) {
    this.opciones=opciones;
  }
  
  public int getI() {
    return this.i;
  }
  
  public void setI(int i) {
    this.i=i;
  }
  
  public int getOpcionSeleccionada() {
    return this.opcionSeleccionada;
  }
  
  public void setOpcionSeleccionada(int opcionSeleccionada) {
    this.opcionSeleccionada=opcionSeleccionada;
  }
}
