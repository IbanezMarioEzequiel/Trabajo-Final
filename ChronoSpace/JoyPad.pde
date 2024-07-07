class JoyPad {
  private boolean upPressed;      // Estado del botón de dirección hacia arriba
  private boolean leftPressed;    // Estado del botón de dirección hacia la izquierda
  private boolean downPressed;    // Estado del botón de dirección hacia abajo
  private boolean rightPressed;   // Estado del botón de dirección hacia la derecha
  private boolean shootDetection; // Estado de detección de disparo

  // Getter y Setter para upPressed
  public boolean isUpPressed() {
    return this.upPressed;
  }

  public void setUpPressed(boolean upPressed) {
    this.upPressed = upPressed;
  }

  // Getter y Setter para leftPressed
  public boolean isLeftPressed() {
    return this.leftPressed;
  }

  public void setLeftPressed(boolean leftPressed) {
    this.leftPressed = leftPressed;
  }

  // Getter y Setter para downPressed
  public boolean isDownPressed() {
    return this.downPressed;
  }

  public void setDownPressed(boolean downPressed) {
    this.downPressed = downPressed;
  }

  // Getter y Setter para rightPressed
  public boolean isRightPressed() {
    return this.rightPressed;
  }

  public void setRightPressed(boolean rightPressed) {
    this.rightPressed = rightPressed;
  }
  
  // Getter y Setter para shootDetection
  public boolean isShootDetection() {
    return this.shootDetection;
  }
  
  public void setShootDetection(boolean shootDetection) {
    this.shootDetection = shootDetection;
  }
}
