// Importación de las bibliotecas necesaria para el correcto funcionamiento del jego
import gifAnimation.*;
import ddf.minim.*;
// -----------------------

// Definición de variables
private Gif gif;
private Minim minim;
private JoyPad joyPad;
private Pantalla pantalla;
private AudioPlayer musicaInicio; //
private AudioPlayer musicaSelector; // ----------------------------------------------------------------------------------------------------------------------------------
private AudioPlayer musicaNivel1; //
private AudioPlayer musicaNivel2; // ------------------------------------------------------------------------------------------------------------------------------------
private AudioPlayer musicaNivel3; //
private AudioSample sonidoDisparo; // Las variables de tipo AudioSample son utilizadas para efectos de sonido, mientras que las de tipo AudioPlayer sirven para la música
private AudioSample sonidoExplosion; // 
private AudioSample sonidoChoque; //   ----------------------------------------------------------------------------------------------------------------------------------
private AudioPlayer nivelCompletado; //
private AudioPlayer nivelFallado; // ------------------------------------------------------------------------------------------------------------------------------------
private AudioPlayer juegoCompletado; //
private boolean perderNivel; // -------------------------------------------------------------------------------------------------------------------
private boolean ganarNivel; //
private boolean deteccionDisparo; // --------------------------------------------------------------------------------------------------------------
private boolean eliminarNivel1; //
private boolean eliminarNivel2; // Variables de tipo boolean que sirven para controlar los estados de la pantalla establecidos en la clase Pantalla
private boolean eliminarNivel3; //
private boolean ganarJuego; // --------------------------------------------------------------------------------------------------------------------
private boolean isChoosing; //
private boolean isPlaying; // ---------------------------------------------------------------------------------------------------------------------
private PFont fuente;  // Variable tipo PFont para cambiar la fuente del texto del programa

void setup() {
  size(800, 600);
  frameRate(60);
  deteccionDisparo = false;
  //Inicializa Minim y carga la música desde la carpeta de datos
  minim = new Minim(this);
  musicaInicio = minim.loadFile("musicaInicio.mp3"); //
  musicaSelector = minim.loadFile("MusicaSelector.mp3"); // -------------------------------------------------------------
  musicaNivel1 = minim.loadFile("Song 1.wav"); //
  musicaNivel2 = minim.loadFile("Song 2.wav"); // -----------------------------------------------------------------------
  musicaNivel3 = minim.loadFile("Song 3.wav"); //
  sonidoDisparo = minim.loadSample("SonidoDisparo.mp3"); // Carga la música y los efectos de sonido para su posterior uso
  sonidoExplosion = minim.loadSample("ExplosionAsteroide.mp3"); //
  sonidoChoque = minim.loadSample("SonidoChoque.mp3"); // ---------------------------------------------------------------
  nivelCompletado = minim.loadFile("NivelCompletado.mp3"); //
  nivelFallado = minim.loadFile("MusicaDerrota.mp3"); // ----------------------------------------------------------------
  juegoCompletado = minim.loadFile("JuegoCompletado.mp3"); //
  // -----------------------------------------------------------
  fuente = loadFont("BrokenConsole-Bold-48.vlw");  // Se carga la fuente para utilizar en los textos del juego
  textFont(fuente); // Se inicializa la fuente para su uso

  //tiempo de la musica

  // Carga el GIF desde la carpeta de datos
  gif = new Gif(this, "imagenInicio.gif");
  gif.play();

  /* Posición para el logo, el fondo y el título */
  joyPad = new JoyPad();
  pantalla = new Pantalla(); // Se inicializa la variable stateScreen con el estado del logo del grupo para que sea lo primero que se dibuje con el método mostrarPantallaActual llamado en el draw
  
  
}

void draw() {
  background(255);
  pantalla.display();
  if(pantalla.opacidadLogo <= 0) {
    pantalla.opacidadLogo = 0;
    pantalla.setOpciones(new String [] {"Empezar", "Salir"});
    pantalla.instructorO.setDistanciaOpciones(80);
    pantalla.instructorO.setPosicion(new PVector(width/2, height/2+140));
    pantalla.setStateScreen(StateScreen.MENU); // Cambia a mostrar el GIF
    
    // Comienza a reproducir la música
    musicaInicio.play();
    if(musicaInicio.position()>=musicaInicio.length()) {
      musicaInicio.rewind();
    }
  }
  
  if(isChoosing) {
    mostrarNivelesDisponibles();
    pantalla.setStateScreen(StateScreen.SELECTORNIVELES);
    musicaSelector.play();
  }
  
  if(isPlaying) {
    // Al empezar a jugar cada nivel, se establece su funcionamiento, variando la resistencia de los asteroides y el tiempo del nivel, que se basa en la duración de su música
    musicaSelector.pause();
    musicaSelector.rewind();
    pantalla.setStateScreen(StateScreen.NIVEL);
    pantalla.setOpcionSeleccionada(0);
    if(pantalla.escenario.getStateLevel()==StateLevel.PRIMERNIVEL) {
      pantalla.gstAsteroide.setResistenciaAst(50);
      pantalla.gstAsteroide.generadorAsteroides();
      pantalla.gstAsteroide.verificarColision(pantalla.nave.balas, sonidoExplosion);
      musicaNivel1.play();
      pantalla.hud.setTiempoRestante((musicaNivel1.length() - musicaNivel1.position()) / 1000);
    } else if (pantalla.escenario.getStateLevel()==StateLevel.SEGUNDONIVEL) {
      pantalla.gstAsteroide.setResistenciaAst(70);
      pantalla.gstAsteroide.generadorAsteroides();
      pantalla.gstAsteroide.verificarColision(pantalla.nave.balas, sonidoExplosion);
      musicaNivel2.play();
      pantalla.hud.setTiempoRestante((musicaNivel2.length() - musicaNivel2.position()) / 1000);
    } else if (pantalla.escenario.getStateLevel()==StateLevel.TERCERNIVEL) {
      pantalla.gstAsteroide.setResistenciaAst(100);
      pantalla.gstAsteroide.generadorAsteroides();
      pantalla.gstAsteroide.verificarColision(pantalla.nave.balas, sonidoExplosion);
      musicaNivel3.play();
      pantalla.hud.setTiempoRestante((musicaNivel3.length() - musicaNivel3.position()) / 1000);
    }
    
    if((musicaNivel1.position()>=musicaNivel1.length() && pantalla.escenario.getStateLevel()==StateLevel.PRIMERNIVEL) || (musicaNivel2.position()>=musicaNivel2.length() && pantalla.escenario.getStateLevel()==StateLevel.SEGUNDONIVEL) || (musicaNivel3.position()>=musicaNivel3.length() && pantalla.escenario.getStateLevel()==StateLevel.TERCERNIVEL)) {
      ganarNivel();
      pantalla.nave.setEnergia(100);
    }
    
    if(pantalla.gstAsteroide.colisionNave(pantalla.gstAsteroide.asteroides, pantalla.nave)) {
      sonidoChoque.trigger();
      pantalla.nave.setEnergia(pantalla.nave.getEnergia()-25);
      if(pantalla.nave.getEnergia()==0) {
        perderNivel();
        pantalla.nave.setEnergia(100);
      }
    }
  }
  
  if(perderNivel) {
    pantalla.setOpciones(new String[] {"Reintentar", "Salir"});
    pantalla.instructorO.setDistanciaOpciones(270);
    pantalla.instructorO.setPosicion(new PVector(width/2-150, height/2+200));
    pantalla.setStateScreen(StateScreen.DERROTA);
  }
  
  if(ganarNivel) {
    pantalla.setStateScreen(StateScreen.VICTORIA);
    nivelCompletado.play();
  }
  
  if(ganarJuego) {
    nivelCompletado.pause();
    nivelCompletado.rewind();
    pantalla.setStateScreen(StateScreen.COMPLETADO);
    juegoCompletado.play();
  }

  if(joyPad.isUpPressed()) {
    pantalla.nave.mover("Arriba");
  }
  
  if(joyPad.isLeftPressed()) {
    pantalla.nave.mover("Izquierda");
  }
  
  if(joyPad.isDownPressed()) {
    pantalla.nave.mover("Abajo");
  }
  
  if(joyPad.isRightPressed()) {
    pantalla.nave.mover("Derecha");
  }
}

void mostrarNivelesDisponibles() {
  // Este método sirve para mostrar los niveles disponibles según sea el caso, excluyendo los niveles ya completados
  if (eliminarNivel1 && eliminarNivel2) {
    pantalla.setOpciones(new String [] {"Nivel 3"});
    pantalla.instructorO.setDistanciaOpciones(1);
    pantalla.instructorO.setPosicion(new PVector(width/2, height/2+180));    
  } else if (eliminarNivel1 && eliminarNivel3) {
    pantalla.setOpciones(new String [] {"Nivel 2"});
    pantalla.instructorO.setDistanciaOpciones(1);
    pantalla.instructorO.setPosicion(new PVector(width/2, height/2+180));
  } else if (eliminarNivel2 && eliminarNivel3) {
    pantalla.setOpciones(new String [] {"Nivel 1"});
    pantalla.instructorO.setDistanciaOpciones(1);
    pantalla.instructorO.setPosicion(new PVector(width/2, height/2+180));
  } else if (eliminarNivel1) {
    pantalla.setOpciones(new String [] {"Nivel 2", "Nivel 3"});
    pantalla.instructorO.setDistanciaOpciones(290);
    pantalla.instructorO.setPosicion(new PVector(width/2-150, height/2+180));
  } else if (eliminarNivel2) {
    pantalla.setOpciones(new String [] {"Nivel 1", "Nivel 3"});
    pantalla.instructorO.setDistanciaOpciones(290);
    pantalla.instructorO.setPosicion(new PVector(width/2-150, height/2+180));
  } else if (eliminarNivel3) {
    pantalla.setOpciones(new String [] {"Nivel 1", "Nivel 2"});
    pantalla.instructorO.setDistanciaOpciones(290);
    pantalla.instructorO.setPosicion(new PVector(width/2-150, height/2+180));
  } else {
    pantalla.setOpciones(new String [] {"Nivel 1", "Nivel 2", "Nivel 3"});
    pantalla.instructorO.setDistanciaOpciones(240);
    pantalla.instructorO.setPosicion(new PVector(width/2-240, height/2+180));
  }
}

void elegirNivel() {
  // Este método sirve para controlar el acceso a los niveles, verificando cuáles son los niveles completados y cuáles los aún disponibles para jugar
  if (!eliminarNivel1 && pantalla.getOpcionSeleccionada() == 0) {
    pantalla.escenario.setStateLevel(StateLevel.PRIMERNIVEL);
  } else if ((!eliminarNivel2 && (!eliminarNivel1 || eliminarNivel3) && pantalla.getOpcionSeleccionada() == 1) || (!eliminarNivel2 && (eliminarNivel1 || !eliminarNivel3) && pantalla.getOpcionSeleccionada() == 0)) {
    pantalla.escenario.setStateLevel(StateLevel.SEGUNDONIVEL);
  } else if (((!eliminarNivel3 && !eliminarNivel1 && !eliminarNivel2) && (pantalla.getOpcionSeleccionada() == 2) || ((eliminarNivel1 && eliminarNivel2) && pantalla.getOpcionSeleccionada() == 0) || ((eliminarNivel1 || eliminarNivel2) && pantalla.getOpcionSeleccionada()==1))) {
    pantalla.escenario.setStateLevel(StateLevel.TERCERNIVEL);
  }
}

void ganarNivel() {
  isPlaying = false;
  joyPad.setUpPressed(false); // ---------------------------------------------------------------------------------------------
  joyPad.setLeftPressed(false); // Al ganar un nivel, los booleans de movimiento del joypad se tornarán en "false" para evitar
  joyPad.setDownPressed(false); // que la nave se salga del lugar establecido cuando esté en el nivel y se mueva por sí sola
  joyPad.setRightPressed(false); // ----------------------------------------------------------------------------------------
  pantalla.gstAsteroide.asteroides.clear(); // --------------------------------------------------------------
  pantalla.nave.balas.clear(); // Se limpian los asteroides y las balas, y se reinicia la posición de la nave
  pantalla.nave.transform.setPosition(new PVector(width/2, height-100)); // ---------------------------------
  if(!(eliminarNivel1 && eliminarNivel2 && eliminarNivel3)) { // -----------------------------------------
    ganarNivel = true; // Si aún no se completaron los 3 niveles, aparece la pantalla del nivel completado
  } // ---------------------------------------------------------------------------------------------------
  if(pantalla.escenario.getStateLevel()==StateLevel.PRIMERNIVEL) { //
    musicaNivel1.close(); //
    eliminarNivel1 = true; // ----------------------------------------------------------------------------------------------------------------------------------------------
  } else if (pantalla.escenario.getStateLevel()==StateLevel.SEGUNDONIVEL) { //
    musicaNivel2.close(); // Ségun sea el nivel que se esté jugando, al completarlo detiene la música para que no se vuelva a reproducir luego porque ya no se la necesitará
    eliminarNivel2 = true; //
  } else if (pantalla.escenario.getStateLevel()==StateLevel.TERCERNIVEL) { // ----------------------------------------------------------------------------------------------
    musicaNivel3.close(); // 
    eliminarNivel3 = true; // ----------------------------------------------------------------------------------------------------------------------------------------------
  } //
  if(eliminarNivel1 && eliminarNivel2 && eliminarNivel3) { // ---------------------------------------------------------
    ganarJuego = true; // Si los 3 niveles fueron completados, aparece la pantalla del juego completado en su totalidad
  } // ----------------------------------------------------------------------------------------------------------------
}

void perderNivel() {
  perderNivel = true;
  isPlaying = false;
  joyPad.setUpPressed(false); // ----------------------------------------------------------------------------------------------
  joyPad.setLeftPressed(false); // Al perder un nivel, los booleans de movimiento del joypad se tornarán en "false" para evitar
  joyPad.setDownPressed(false); // que la nave se salga del lugar establecido cuando esté en el nivel y se mueva por sí sola
  joyPad.setRightPressed(false); // ----------------------------------------------------------------------------------------
  nivelFallado.play(); // Se reproduce la música que correspondería al perder el nivel
  pantalla.gstAsteroide.asteroides.clear(); // --------------------------------------------------------------
  pantalla.nave.balas.clear(); // Se limpian los asteroides y las balas, y se reinicia la posición de la nave
  pantalla.nave.transform.setPosition(new PVector(width/2, height-100)); // ---------------------------------
  if(pantalla.escenario.getStateLevel()==StateLevel.PRIMERNIVEL) { // ----------------------------------------------------------------------------------------------------
    musicaNivel1.pause(); // 
    musicaNivel1.rewind(); // --------------------------------------------------------------------------------------------------------------------------------------------
  } else if (pantalla.escenario.getStateLevel()==StateLevel.SEGUNDONIVEL) { //
    musicaNivel2.pause(); // Ségun sea el nivel que se esté jugando, pausa la música de ese nivel y la inicia de nuevo para reproducirla cuando se vuelva a jugar el nivel
    musicaNivel2.rewind(); //
  } else if (pantalla.escenario.getStateLevel()==StateLevel.TERCERNIVEL) { // --------------------------------------------------------------------------------------------
    musicaNivel3.pause(); //
    musicaNivel3.rewind(); // --------------------------------------------------------------------------------------------------------------------------------------------
  } //
}

void keyPressed() {
  // Comportamiento de las opciones y al apretar la tecla ENTER en dicha pantalla
  if (keyCode == UP && pantalla.getStateScreen()==StateScreen.MENU || keyCode == LEFT && (pantalla.getStateScreen()==StateScreen.SELECTORNIVELES || pantalla.getStateScreen()==StateScreen.DERROTA)) {
    if (pantalla.getOpcionSeleccionada() > 0) { // Estas condiciones en las opciones, hacen que al desplazarse no se vaya fuera del límite mostrado y tampoco vuelva a la opción del otro extremo si se apunta a la dirección contraria
      pantalla.setOpcionSeleccionada(pantalla.getOpcionSeleccionada()-1);
    }
  }

  if (keyCode == DOWN && pantalla.getStateScreen()==StateScreen.MENU || keyCode == RIGHT && (pantalla.getStateScreen()==StateScreen.SELECTORNIVELES || pantalla.getStateScreen()==StateScreen.DERROTA)) {
    if (pantalla.getOpcionSeleccionada() < pantalla.getOpciones().length - 1) {
      pantalla.setOpcionSeleccionada(pantalla.getOpcionSeleccionada()+1);
    }
  }

  if (keyCode == ENTER && pantalla.getStateScreen()==StateScreen.MENU) {
    if (pantalla.getOpcionSeleccionada()==0) {
      isChoosing = true;
      musicaInicio.close();
    }
    if (pantalla.getOpcionSeleccionada()==1) {
      exit();
    }
  }

  if (keyCode == ENTER && pantalla.getStateScreen()==StateScreen.SELECTORNIVELES) {
    isPlaying = true;
    isChoosing = false;
    elegirNivel();
    pantalla.nave.setTransform(new Transform(new PVector(width/2, height-100)));
  }

  if (keyCode == ENTER && pantalla.getStateScreen()==StateScreen.VICTORIA) {
    isChoosing = true;
    ganarNivel = false;
    nivelCompletado.pause();
    nivelCompletado.rewind();
    pantalla.nave.setTransform(new Transform(new PVector(width/2, height-100)));
  }

  if (keyCode == ENTER && pantalla.getStateScreen()==StateScreen.DERROTA) {
    isPlaying = true;
    nivelFallado.pause();
    nivelFallado.rewind();
    if (pantalla.getOpcionSeleccionada()==0) {
      perderNivel = false;
    }
    if (pantalla.getOpcionSeleccionada()==1) {
      exit();
    }
  }
  // ---------------------------------------------------------------------

  if (keyCode==UP && pantalla.getStateScreen()==StateScreen.NIVEL) {     //
    joyPad.setUpPressed(true);                                           // ---------------------------------------------------------------------------------------------------
  }                                                                      //
                                                                         // ---------------------------------------------------------------------------------------------------
  if (keyCode==LEFT && pantalla.getStateScreen()==StateScreen.NIVEL) {   //
    joyPad.setLeftPressed(true);                                         // ---------------------------------------------------------------------------------------------------
  }                                                                      //
                                                                         // Al presionar las teclas de movimiento de la nave en el nivel, se mueven hacia la dirección apuntada
  if (keyCode==DOWN && pantalla.getStateScreen()==StateScreen.NIVEL) {   //
    joyPad.setDownPressed(true);                                         // ---------------------------------------------------------------------------------------------------
  }                                                                      //
                                                                         // ---------------------------------------------------------------------------------------------------
  if (keyCode==RIGHT && pantalla.getStateScreen()==StateScreen.NIVEL) {  //
    joyPad.setRightPressed(true);                                        // ---------------------------------------------------------------------------------------------------
  }                                                                      //
  
  if ((key == 'x' || key == 'X') && pantalla.getStateScreen()==StateScreen.NIVEL) {
    if(!deteccionDisparo) { // ------------------------------------------------------------------------------------------------------------------
      pantalla.nave.generarBala(); //  Al presionar la tecla X estando en el nivel, se disparará una bala con su efecto de sonido perteneciente y 
      sonidoDisparo.trigger(); //       deteccionDisparo se torna true para que no haga más de un disparo al seguir manteniendo apretada la tecla
      deteccionDisparo = true; // ---------------------------------------------------------------------------------------------------------------
    }
  }
}

void keyReleased() {
  if (keyCode==UP && pantalla.getStateScreen()==StateScreen.NIVEL) {     //
    joyPad.setUpPressed(false);                                          // ----------------------------------------------------------------
  }                                                                      //
                                                                         // ----------------------------------------------------------------
  if (keyCode==LEFT && pantalla.getStateScreen()==StateScreen.NIVEL) {   //
    joyPad.setLeftPressed(false);                                        // ----------------------------------------------------------------
  }                                                                      //
                                                                         // Y al dejar de presionarlas, se deja de mover hacía esa dirección
  if (keyCode==DOWN && pantalla.getStateScreen()==StateScreen.NIVEL) {   //
    joyPad.setDownPressed(false);                                        // ----------------------------------------------------------------
  }                                                                      //
                                                                         // ----------------------------------------------------------------
  if (keyCode==RIGHT && pantalla.getStateScreen()==StateScreen.NIVEL) {  //
    joyPad.setRightPressed(false);                                       // ----------------------------------------------------------------
  }                                                                      //
  
  if ((key == 'x' || key == 'X') && pantalla.getStateScreen()==StateScreen.NIVEL) {
    deteccionDisparo = false; // Al dejar de presionar la tecla X, deteccionDisparo se vuelve false para poder volver a disparar
  }
}
