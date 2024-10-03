class Point extends Shape {
  
  //Constructor Method
  Point(int x, int y, color shapeColor) {
    super(x, y, shapeColor);
  }

  void display() {
    noStroke();
    stroke(shapeColor);
    point(x, y);
  }
}
