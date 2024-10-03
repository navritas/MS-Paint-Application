class Brush extends Shape {
  int radius;

  //Constructor Method
  Brush(int tempX, int tempY, int tempRadius, color tempColor) {
    super(tempX, tempY, tempColor); 
    radius = tempRadius;
  }

  void display() {
    noStroke();
    fill(shapeColor); 
    ellipse(x, y, radius*2.2, radius*2.2);
  }
}
