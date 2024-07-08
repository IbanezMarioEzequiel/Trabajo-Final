class GestorAsteroides implements IVisualizable {
  private ArrayList<Asteroide> asteroides; // Lista de asteroides
  private int resistenciaAst; // Resistencia de los asteroides

  // Constructor de la clase GestorAsteroides
  public GestorAsteroides() {
    asteroides = new ArrayList<Asteroide>();
  }

  // Método para generar asteroides
  public void generadorAsteroides() {
    if (frameCount % 10 == 0) { // Generar un asteroide cada 10 frames
      Transform transformAsteroide = new Transform(new PVector((int) random(20, width - 20), 0)); // Generar una posición aleatoria
      asteroides.add(new Asteroide(transformAsteroide, new PVector(0, (int) width / 10 * Time.getDeltaTime(frameRate)), resistenciaAst, 80, 80)); // Añadir un nuevo asteroide a la lista
    }
  }

  // Método para mostrar los asteroides en la pantalla
  public void display() {
    for (int i = 0; i < asteroides.size(); i++) {
      Asteroide as = asteroides.get(i);
      as.display();
      if (as.getSpriteAsteroide().getPosicion().y > height) { // Si el asteroide sale de la pantalla, eliminarlo
        asteroides.remove(as);
      }
    }
  }

  // Método para verificar colisiones entre balas y asteroides
  public void verificarColision(ArrayList<Bala> balas,AudioSample sonidoExplosion) {
    ArrayList<Bala> balasAEliminar = new ArrayList<>();
    ArrayList<Asteroide> asteroidesAEliminar = new ArrayList<>();

    for (int i = 0; i < balas.size(); i++) {
      Bala bala = balas.get(i);
      for (int j = 0; j < asteroides.size(); j++) {
        Asteroide ast = asteroides.get(j);
        float distancia = dist(ast.getSpriteAsteroide().getPosicion().x, ast.getSpriteAsteroide().getPosicion().y + 20,
                               bala.getBala().getPosicion().x, bala.getBala().getPosicion().y); // Calcular la distancia entre la bala y el asteroide
        if (distancia < 40) { // Si la distancia es menor a 40 es una colisión
          balasAEliminar.add(bala); //agrega la bala a la lista de BalasEliminadas
          ast.debilitar(); // Reducir la resistencia del asteroide
          if (ast.estaDestruido()) { // Si la resistencia del asteroide es 0 o menos
            asteroidesAEliminar.add(ast);//agrega ala lista de asteroideAEliminar
            sonidoExplosion.trigger();  
         }
        }
      }
    }

    // Eliminar las balas marcadas para eliminación
    for (Bala b : balasAEliminar) {
      balas.remove(b);//elimina las balas de la lista de balasAEliminar
    }

    // Eliminar los asteroides marcados para eliminación
    for (Asteroide a : asteroidesAEliminar) {
      asteroides.remove(a);//elimina el asteroide de la lista de asteroideAEliminar
    }
  }

  // Método para verificar colisiones entre asteroides y la nave
  public boolean colisionNave(ArrayList<Asteroide> ast, Nave nave) {
    for (int i = 0; i < ast.size(); i++) {
      Asteroide aste = ast.get(i);
      float distancia = dist(aste.getSpriteAsteroide().getPosicion().x, aste.getSpriteAsteroide().getPosicion().y + 20,
                             nave.getTransform().getPosition().x, nave.getTransform().getPosition().y); // Calcular la distancia entre el asteroide y la nave
      if (distancia < 70) { // Si la distancia es menor a 70
        ast.remove(i); // Eliminar el asteroide
        return true; // Devolver true para indicar una colisión
      }
    }
    return false; // Devolver false si no hay colisiones
  }

  // Método para establecer la resistencia de los asteroides
  public void setResistenciaAst(int resistenciaAst) {
    this.resistenciaAst = resistenciaAst;
  }

  // Método para obtener la resistencia de los asteroides
  public int getResistenciaAst() {
    return this.resistenciaAst;
  }
}
