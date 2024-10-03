class Line extends Shape {
  int x2, y2;

  //Constructor Method
  Line(int x, int y, int x2, int y2, color shapeColor) {
    super(x, y, shapeColor);
    this.x2 = x2;
    this.y2 = y2;
  }

  void display() {
    stroke(shapeColor);
    line(x, y, x2, y2);
  }
}
