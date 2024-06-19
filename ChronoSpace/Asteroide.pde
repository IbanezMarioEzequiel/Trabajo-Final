class Asteroide implements IMoveable{
  private Transform transform;
  private ImageComponent imageComponent;
  private int resistencia;
  private int alto;
  private int ancho;
  
  public Asteroide() {
  }
  
  public Asteroide(Transform transform, ImageComponent imageComponent, int resistencia, int alto, int ancho) {
    this.transform=transform;
    this.imageComponent=imageComponent;
    this.resistencia=resistencia;
    this.alto=alto;
    this.ancho=ancho;
  }
  
  public Transform getTransform() {
    return transform;
  }
  
  public void setTransform(Transform transform) {
    this.transform=transform;
  }
  
  public ImageComponent getImageComponent() {
    return imageComponent;
  }
  
  public void setImageComponent(ImageComponent imageComponent) {
    this.imageComponent=imageComponent;
  }
  
  public int getResistencia() {
    return resistencia;
  }
  
  public void setResistencia(int resistencia) {
    this.resistencia=resistencia;
  }
  
  public int getAlto() {
    return alto;
  }
  
  public void setAlto(int alto) {
    this.alto=alto;
  }
  
  public int getAncho() {
    return ancho;
  }
  
  public void setAncho(int ancho) {
    this.ancho=ancho;
  }
  
  public void display() {
  }
  
  public void mover() {
  }
  
  public void debilitar() {
  }
 // estadoDestruido se encuentra comentado debido a un error 
  //public boolean estaDestruido() {
 //}
}
