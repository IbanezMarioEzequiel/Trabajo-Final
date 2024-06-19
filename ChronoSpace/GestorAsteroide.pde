class GestorAsteroides {
  private Asteroide asteroide;
  private float distancia;
  private float distanciaMinima;
  private PVector nuevaPosicion;
  
  public GestorAsteroides() {
  }
  
  public GestorAsteroides(Asteroide asteroide, float distancia, float distanciaMinima, PVector nuevaPosicion) {
    this.asteroide=asteroide;
    this.distancia=distancia;
    this.distanciaMinima=distanciaMinima;
    this.nuevaPosicion=nuevaPosicion;
  }
  
  public Asteroide getAsteroide() {
    return asteroide;
  }
  
  public void setAsteroide(Asteroide asteroide) {
    this.asteroide=asteroide;
  }
  
  public float getDistancia() {
    return distancia;
  }
  
  public void setDistancia(float distancia) {
    this.distancia=distancia;
  }
  
  public float getDistanciaMinima() {
    return distanciaMinima;
  }
  
  public void setDistanciaMinima(float distanciaMinima) {
    this.distanciaMinima=distanciaMinima;
  }
  
  public PVector getNuevaPosicion() {
    return nuevaPosicion;
  }
  
  public void setNuevaPosicion(PVector nuevaPosicion) {
    this.nuevaPosicion=nuevaPosicion;
  }
  
  public void display() {
  }
  
  public void verificarColision(ArrayList<Bala> bala) {
  }
}
