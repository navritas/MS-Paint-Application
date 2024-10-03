class Text extends Shape {
  String text;
  int size;
  
  //Constructor Method
  Text(int x, int y, color c, String text, int size) {
    super(x, y, c);
    this.text = text;
    this.size = size;
  }

  void display() {
    fill(shapeColor);
    textSize(size);
    text(text, x, y);
  }
}
