class Rectangle extends Shape {
  int width, height; // Specific attributes for rectangles

  //Constructor Method
  Rectangle(int x, int y, int width, int height, color c) {
    super(x, y, c);
    this.width = width;
    this.height = height;
  }
  
  void display() {
    noStroke();
    fill(shapeColor);
    rect(x, y, width, height);
  }
}
