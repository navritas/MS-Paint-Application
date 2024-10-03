class Ellipse extends Shape {
  int w, h;
  
  //Constructor Method
  Ellipse(int x, int y, int w, int h, color shapeColor) {
    super(x, y, shapeColor);
    this.w = w;
    this.h = h;
  }

  void display() {
    noStroke(); // Disable the outline
    fill(shapeColor);
    ellipse(x, y, w, h);
  }
}
