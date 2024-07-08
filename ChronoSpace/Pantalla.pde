class Pantalla implements IVisualizable {
  private PImage logo;               // Imagen del logo del juego
  private PImage titulo;             // Imagen del título del juego
  private PImage juegoCompletado;    // Imagen para la pantalla de juego completado
  private float opacidadLogo;        // Opacidad actual del logo durante la transición
  private int stateScreen;           // Estado actual de la pantalla
  private boolean nombreJuego;       // Controla el parpadeo del nombre del juego en el menú
  private String[] opciones;         // Opciones del menú o selector de niveles
  private int i;                     // Índice
  private int opcionSeleccionada;    // Índice de la opción seleccionada en el menú
  private InstructorOpciones instructorO;  // Instancia del instructor de opciones para manejar las opciones visuales
  private HUD hud;                   // Instancia del HUD (Heads-Up Display) para mostrar tiempo y energía
  private Nave nave;                 // Instancia de la nave del jugador
  private GestorAsteroides gstAsteroide;  // Instancia del gestor de asteroides
  private Escenario escenario;       // Instancia del escenario del juego
  private Derrota derrota;           // Instancia de la pantalla de derrota
  private Victoria victoria;         // Instancia de la pantalla de victoria

  // Constructor de la clase Pantalla
  public Pantalla() {
    // Inicialización de variables y cargando imágenes
    this.logo = loadImage("logo.png");
    this.titulo = loadImage("titulo.png");
    this.juegoCompletado = loadImage("JuegoCompletado.png");
    this.opacidadLogo = 255;  // Inicialmente, el logo está completamente visible
    this.stateScreen = StateScreen.LOGO;  // Se inicia en el estado de presentación del logo
    this.opcionSeleccionada = 0;  // no hay opción seleccionada en el menú
    this.instructorO = new InstructorOpciones();  // Inicialización del instructor de opciones
    this.hud = new HUD();  // Inicialización del HUD
    // Creación de la nave del jugador con su posición inicial y componentes visuales
    Transform transformNave = new Transform(new PVector(width/2, height-100));
    ImageComponent imageNave = new ImageComponent("navve.png");
    this.nave = new Nave(transformNave, imageNave, new PVector(int((width+height)/2)*Time.getDeltaTime(frameRate), int((width+height)/2)*Time.getDeltaTime(frameRate)), 100);
    this.gstAsteroide = new GestorAsteroides();  // Inicialización del gestor de asteroides
    this.escenario = new Escenario();  // Inicialización del escenario
    this.escenario.setStateLevel(StateLevel.PRIMERNIVEL);  // Establecer el nivel inicial del escenario
    this.derrota = new Derrota();  // Inicialización de la pantalla de derrota
    this.derrota.setPosicion(new PVector(width/2, height/2));  // Establecer la posición de la pantalla de derrota
    this.victoria = new Victoria();  // Inicialización de la pantalla de victoria
    this.victoria.setPosicion(new PVector(width/2, height/2));  // Establecer la posición de la pantalla de victoria
  }

  // Método para mostrar la pantalla actual según el estado
  public void display() {
    switch (this.stateScreen) {
      case StateScreen.LOGO:
        // Mostrar el logo con transparencia decreciente hasta que desaparezca
        imageMode(CENTER);
        tint(255, opacidadLogo);
        image(logo, width/2, height/2);
        opacidadLogo -= 1;  // Disminuir la opacidad gradualmente
        noTint();
        break;

      case StateScreen.MENU:
        // Mostrar el menú principal
        imageMode(CENTER);
        image(gif, width/2, height/2, width, height+30);  // Mostrar imagen o animación de fondo del menú
        if (nombreJuego) {
          image(titulo, width/2, height/2-200, 500, 150);  // Mostrar título del juego con efecto de parpadeo
        }
        // Control de parpadeo del nombre del juego
        if (frameCount % 50 < 15) {
          nombreJuego = false;
        } else {
          nombreJuego = true;
        }
        // Mostrar las opciones del menú y manejar su visualización según la selección
        for (i = 0; i < opciones.length; i++) {
          if (i == opcionSeleccionada) {
            instructorO.setStateOption(StateOption.OPCIONMARCADA);  // Opción marcada si es la seleccionada
          } else {
            instructorO.setStateOption(StateOption.OPCIONNOMARCADA);  // Opción no marcada si no es la seleccionada
          }
          instructorO.display(stateScreen, opciones, i, opcionSeleccionada);  // Mostrar la opción actual
        }
        break;

      case StateScreen.SELECTORNIVELES:
        // Mostrar el selector de niveles
        background(137, 0, 229);  // Fondo morado
        fill(255, 255, 0);
        textAlign(CENTER);
        textSize(40);
        text("SELECTOR DE NIVEL", width/2, height/2-220);  // Título del selector de niveles
        fill(255);
        text("Con ENTER seleccione un nivel", width/2, height/2-70);  // Instrucciones
        text("para empezar a jugar", width/2, height/2+10);
        // Mostrar las opciones del selector de niveles y manejar su visualización según la selección
        for (i = 0; i < opciones.length; i++) {
          if (i == opcionSeleccionada) {
            instructorO.setStateOption(StateOption.OPCIONMARCADA);  // Opción marcada si es la seleccionada
          } else {
            instructorO.setStateOption(StateOption.OPCIONNOMARCADA);  // Opción no marcada si no es la seleccionada
          }
          instructorO.display(stateScreen, opciones, i, opcionSeleccionada);  // Mostrar la opción actual
        }
        break;

      case StateScreen.NIVEL:
        // Mostrar el juego en curso
        escenario.setPosicion(new PVector(width/2, height/2));  // Establecer posición del escenario
        escenario.display();  // Mostrar el escenario
        nave.display();  // Mostrar la nave del jugador
        gstAsteroide.display();  // Mostrar los asteroides gestionados
        hud.mostrarTiempo();  // Mostrar el tiempo en el HUD
        hud.mostrarEnergia(nave);  // Mostrar la energía de la nave en el HUD
        break;

      case StateScreen.DERROTA:
        // Mostrar pantalla de derrota
        derrota.display();  // Mostrar la pantalla de derrota
        // Mostrar las opciones y manejar su visualización según la selección
        for (i = 0; i < opciones.length; i++) {
          if (i == opcionSeleccionada) {
            instructorO.setStateOption(StateOption.OPCIONMARCADA);  // Opción marcada si es la seleccionada
          } else {
            instructorO.setStateOption(StateOption.OPCIONNOMARCADA);  // Opción no marcada si no es la seleccionada
          }
          instructorO.display(stateScreen, opciones, i, opcionSeleccionada);  // Mostrar la opción actual
        }
        break;

      case StateScreen.VICTORIA:
        // Mostrar pantalla de victoria
        victoria.display();  // Mostrar la pantalla de victoria
        fill(255, 0, 0);
        textAlign(CENTER);
        textSize(40);
        text("Presiona Enter para volver al selector de niveles", width/2, height/2+180);  // Instrucción para volver al selector de niveles
        break;

      case StateScreen.COMPLETADO:
        // Mostrar pantalla de juego completado
        imageMode(CENTER);
        image(juegoCompletado, width/2, height/2, width, height);  // Mostrar imagen de juego completado
        break;
    }
  }

  // Métodos getter y setter para acceder y modificar los atributos de la clase

  public int getStateScreen() {
    return this.stateScreen;
  }

  public void setStateScreen(int stateScreen) {
    this.stateScreen = stateScreen;
  }

  public String[] getOpciones() {
    return this.opciones;
  }

  public void setOpciones(String[] opciones) {
    this.opciones = opciones;
  }

  public int getOpcionSeleccionada() {
    return this.opcionSeleccionada;
  }

  public void setOpcionSeleccionada(int opcionSeleccionada) {
    this.opcionSeleccionada = opcionSeleccionada;
  }
}
