class Nave implements IMoveable {
  private Transform transform;
  private ImageComponent imageComponent;
  private Bala bala;
  private PVector velocidad;
  
  public Nave() {
  }
  
  public Nave(Transform transform, ImageComponent imageComponent, Bala bala, PVector velocidad) {
    this.transform=transform;
    this.imageComponent=imageComponent;
    this.bala=bala;
    this.velocidad=velocidad;
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
  
  public Bala getBala() {
    return bala;
  }
  
  public void setBala(Bala bala) {
    this.bala=bala;
  }
  
  public PVector getVelocidad() {
    return velocidad;
  }
  
  public void setVelocidad(PVector velocidad) {
    this.velocidad=velocidad;
  }
  
  public void display() {
  }
  
  public void mover() {
  }
  
  public void generarBala() {
  }
}
