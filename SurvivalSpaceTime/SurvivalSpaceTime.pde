/*Este es un ejemplo del menu de inicio,
  en el segundo entregable se ordenara*/

import gifAnimation.*;
import ddf.minim.*;

private Gif gif;
private Minim minim;
private AudioPlayer musicaInicio;
private PImage image;
private PImage titulo1;
private PImage titulo2;
private PImage titulo3;
private float opacidadLogo = 255; // Inicialmente, la imagen del logo está completamente visible,
private boolean mostrarLogo=true; // y cuando la imagen deje de verse, el estado de esta variable cambiará a false y se mostrará la pantalla de inicio
private PVector posicion;
private boolean nombreJuego;

void setup() {
  size(800, 600);

  // Inicializa Minim y carga la música desde la carpeta de datos
  minim = new Minim(this);
  musicaInicio = minim.loadFile("musicaInicio.wav");

  // Carga el GIF desde la carpeta de datos
  gif = new Gif(this, "imagenInicio.gif");
  gif.play();

  /* Posición para el logo, el fondo y el título */
  posicion=new PVector(width/2,height/2);
  image = loadImage("logo.png");
  titulo1 = loadImage("titulo1.png");
  titulo2 = loadImage("titulo2.png");
  titulo3 = loadImage("titulo3.png");

}

void draw() {
  background(255);
  // Dibuja el logo primero
  if(mostrarLogo) {
    imageMode(CENTER);
    tint(255, opacidadLogo);
    image(image, posicion.x, posicion.y);
    opacidadLogo -= 1; // Disminuye la opacidad del logo
    if(opacidadLogo <= 0) {
      opacidadLogo = 0;
      mostrarLogo = false; // Cambia a mostrar el GIF   
    }
  } else {
    // Al terminar de mostrarse el logo, se muestra la pantalla de inicio
    imageMode(CENTER);
    noTint();
    image(gif, posicion.x, posicion.y, width, height+30); // Al tamaño del alto de la imagen se le aumentó 30 píxeles para evitar que se vean particulas negras que no tendrían que estar en el gif
    
    //Estructura de control que muestra el nombre del juego si el valor de la variable boolean "nombreJuego" es verdadero
    if(nombreJuego) {
      noTint();
      image(titulo1, posicion.x, 50, 500, 50);
      image(titulo2, posicion.x, 100, 400, 50);
      image(titulo3, posicion.x, 150, 300, 50);
    }
    
    // Estructura de control que sirve para darle un efecto de parpadeo al nombre del juego
    if (frameCount % 50 < 15) {
      nombreJuego=false;
    } else {
      nombreJuego=true;
    }
    
    // Comienza a reproducir la música    
    musicaInicio.play(); 
    if(musicaInicio.position() >= musicaInicio.length()) {
      musicaInicio.rewind();
    }
  }
}
