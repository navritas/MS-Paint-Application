/******************************** GLOBAL VARIABLES *******************************/
ArrayList<Shape> shapes = new ArrayList<Shape>();
int startX = 0, startY = 0;
int brushRadius = 7; 
int mouseX2 = 0, mouseY2 = 0;
boolean drawCurrentShape = false;
String tool = "";
int currentColor = 0;
boolean isDrawingLine = false;
boolean isDrawingEllipse = false;
boolean isDrawingRectangle = false;
PImage savedImage;
String currentText = "";
int textSize = 16;
boolean isTypingText = false;
int padding = 10; 
boolean isInvertEnabled = false;
boolean isDrawingStar = false;
float outerRadius;
float innerRadius;
int saveCounter = 0; 

// Increase and Decrease button variables
int increaseBrushButtonX = 800; 
int decreaseBrushButtonX = 850; 
int brushButtonY = 0; 
int brushButtonSize = 50; 

/************************************* SETUP *************************************/
void setup() {
  fullScreen(); //Makes the size full screen
  strokeWeight(5);
}

//Drawing the shapes 
void draw() {
  background(255);
  
  if (savedImage != null) { 
    image(savedImage, 0, 0, width, height);
  }
 
  for (Shape shape : shapes) {
    shape.display();
  }

//Drawing the toolbar
  toolbar();

  stroke(currentColor);
  fill(currentColor);
  //Drawing lines
  if (isDrawingLine) {
    line(startX, startY, mouseX, mouseY);
   //Drawing rectangles
  } else if (isDrawingRectangle) {
    int w = mouseX - startX;
    int h = mouseY - startY;
    rect(startX, startY, w, h); 
    //Drawing ellipses
  } else if (isDrawingEllipse) {
    int w = mouseX - startX;
    int h = mouseY - startY;
    ellipse(startX + w/2, startY + h/2, abs(w), abs(h)); 
    //Text tool handling
  } if (tool.equals("text") && isTypingText && startY > 50) { 
    fill(currentColor);
    textSize(this.textSize);

    float textWidth = textWidth(currentText) + (padding * 2);
    float textHeight = textSize + (padding * 2);

    stroke(0); 
    noFill(); 
    //Adds padding around the text
    rect(startX - padding, startY - textSize - padding, textWidth, textHeight);

    // Draw the text
    noStroke(); 
    text(currentText, startX, startY);
    
    //Enables invert filter
  } if (isInvertEnabled) {
        filter(INVERT);
    //Drawing stars
  } if (isDrawingStar && drawCurrentShape) {
    pushMatrix();
    translate(startX, startY);
    drawStar(0, 0, outerRadius, innerRadius, 5); 
    popMatrix();
  }
}

//Draw star function
void drawStar(int x, int y, float radius1, float radius2, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle / 2.0;
  beginShape();
  for (float i = 0; i < TWO_PI; i += angle) {
    float x1 = x + cos(i) * radius1;
    float y1 = y + sin(i) * radius1;
    vertex(x1, y1);
    x1 = x + cos(i + halfAngle) * radius2;
    y1 = y + sin(i + halfAngle) * radius2;
    vertex(x1, y1);
  }
  endShape(CLOSE);
}

/**************************** EVENT HANDLING FUNCTIONS ***************************/
//Select tool function
void selectTool() {
  isDrawingLine = false;
  isDrawingRectangle = false;
  isDrawingEllipse = false;
  isDrawingStar = false;

  if (mouseY < 50) { 
    if (0 < mouseX && mouseX < 50) {
      tool = "line";
    } else if (50 < mouseX && mouseX < 100) {
      tool = "brush";
    } else if (100 < mouseX && mouseX < 150) {
      tool = "rectangle";
    } else if (150 < mouseX && mouseX < 200) {
      tool = "ellipse";
    } else if (700 < mouseX && mouseX < 750) {
      tool = "text";
    } else if (750 < mouseX && mouseX < 800) {
      tool = "star";
      isDrawingStar = true;
    }
  }
}

void mousePressed() {
  if (mouseY > 50) {
    startX = mouseX;
    startY = mouseY;
    drawCurrentShape = true;
    if (mouseX > width - 60 && mouseX < width - 10 && mouseY > height - 60 && mouseY < height - 10) {
    exit(); // Exits the application
    return; 
  }
    if (tool.equals("line")) {
      isDrawingLine = true;
    } else if (tool.equals("rectangle")) {
      isDrawingRectangle = true;
    } else if (tool.equals("ellipse")) {
      isDrawingEllipse = true;
    } else if (tool.equals("star")) {
      isDrawingStar = true;
    }
    //Calls selectTool function
  } else {
    selectTool();
  }
    // Colour selection tool handling
    if (200 < mouseX && mouseX < 250 && 0 < mouseY && mouseY < 50) {
      currentColor = color(255, 0, 0); // Red
    } else if (250 < mouseX && mouseX < 300 && 0 < mouseY && mouseY < 50) {
      currentColor = color(0, 0, 255); // Blue
    } else if (300 < mouseX && mouseX < 350 && 0 < mouseY && mouseY < 50) {
      currentColor = color(0, 255, 0); // Green
    } else if (350 < mouseX && mouseX < 400 && 0 < mouseY && mouseY < 50) {
      currentColor = color(255, 255, 0); // Yellow
    }
    
     if (450 < mouseX && mouseX < 500 && 0 < mouseY && mouseY < 50) {
      saveImage();
      
   } else if (500 < mouseX && mouseX < 550 && 0 < mouseY && mouseY < 50) {
      loadSavedImage();
      shapes.clear();
      
   } else if (600 < mouseX && mouseX < 650 && 0 < mouseY && mouseY < 50) {
      undoLastShape(); 
      
  } if (tool.equals("text")) {
      if (isTypingText) {
        shapes.add(new Text(startX, startY, currentColor, currentText, textSize));
      }
      isTypingText = true;
      currentText = "";
      startX = mouseX;
      startY = mouseY;
      
  } if (650 < mouseX && mouseX < 700 && 0 < mouseY && mouseY < 50) {
    isInvertEnabled = !isInvertEnabled;
  } 
  if (750 < mouseX && mouseX < 800 && 0 < mouseY && mouseY < 50) {
    tool = "star";
    isDrawingStar = true;
    //Decreasing and Increases Brush Size 
  } if (mouseX > increaseBrushButtonX && mouseX < increaseBrushButtonX + brushButtonSize && mouseY < brushButtonSize) {
    brushRadius += 1; 
    println("Increased Brush Size: " + brushRadius);
  }

    if (mouseX > decreaseBrushButtonX && mouseX < decreaseBrushButtonX + brushButtonSize && mouseY < brushButtonSize) {
        brushRadius = max(1, brushRadius - 1);
        println("Decreased Brush Size: " + brushRadius);
  }
}

//Function to undo 
void undoLastShape() {
  if (!shapes.isEmpty()) {
    shapes.remove(shapes.size() - 1); 
  }
}

//Function to allow file loading
void loadSavedImage() {
  selectInput("Select a file to process:", "fileSelected");
 }
 
//Function to select the several saved files
void fileSelected(File selection) {
  savedImage = loadImage(selection.getAbsolutePath());
  }

//Saves several images 
void saveImage() {
  String filename = "savedImage_" + saveCounter + ".png";
  save(filename);
  saveCounter++; 
}

void mouseDragged() {
  if (mouseY > 50) { 
    //Spraypaint tool handling
    if (tool.equals("brush")) {
      shapes.add(new Brush(mouseX, mouseY, brushRadius, currentColor));
    } else if (tool.equals("eraser")) {
      shapes.add(new Brush(mouseX, mouseY, brushRadius, color(255)));
      noStroke();
    } else if (tool.equals("sprayPaint")) {
      int dots = (int)random(3, 6); 
      for (int i = 0; i < dots; i++) {
        int sprayX = mouseX + (int)random(-12, 12); 
        int sprayY = mouseY + (int)random(-12, 12);
        shapes.add(new Point(sprayX, sprayY, currentColor));
      }
      //Drawing stars
    } if (isDrawingStar) {
    outerRadius = dist(startX, startY, mouseX, mouseY);
    innerRadius = outerRadius / 2.5; 
  } 
  }
}

void mouseReleased() {
  if (mouseY > 50) {
    //Drawing stars
    if (isDrawingStar) {
      shapes.add(new Star(startX, startY, outerRadius, innerRadius, 5, currentColor)); // Using 5 for a typical star
      isDrawingStar = false;
    }
    //Drawing lines
    if (isDrawingLine) {
      shapes.add(new Line(startX, startY, mouseX, mouseY, currentColor));
      isDrawingLine = false;
      //Drawing rectangles
    } else if (isDrawingRectangle) {
      shapes.add(new Rectangle(startX, startY, mouseX - startX, mouseY - startY, currentColor));
      isDrawingRectangle = false;
      //Drawing Ellispes
    } else if (isDrawingEllipse) {
      int w = mouseX - startX;
      int h = mouseY - startY;
      shapes.add(new Ellipse(startX + w/2, startY + h/2, abs(w), abs(h), currentColor));
      isDrawingEllipse = false;
  }
  }
    drawCurrentShape = false;
  }

//Text tool logic handling
void keyPressed() {
  if (tool.equals("text")) {
    if ((keyCode == ENTER || keyCode == RETURN) && isTypingText) {
      shapes.add(new Text(startX, startY, currentColor, currentText, textSize));
      isTypingText = false;
    } else if (keyCode == BACKSPACE && currentText.length() > 0) {
      // Handle backspace
      currentText = currentText.substring(0, currentText.length() - 1);
    } else if (isTypingText) {
      currentText += key;
    }
  }
}


/******************************** OTHER FUNCTIONS ********************************/

void toolbar() {
  stroke(0); 

  fill(255);
  
  // Line button
  rect(0, 0, 50, 50);
  line(10, 40, 40, 10);

  // Brush button
  rect(50, 0, 50, 50);
  ellipse(75, 25, 5, 5);

  // Rectangle button
  rect(100, 0, 50, 50);
  rect(110, 10, 30, 30);
  
  // Ellipse button
  rect(150, 0, 50, 50);
  ellipse(175, 25, 30, 20);
  
  // Red Button
  fill(255, 0, 0);
  rect(200, 0, 50, 50);
  
  // Blue Button
  fill(0, 0, 255);
  rect(250, 0, 50, 50);
  
  // Green Button
  fill(0, 255, 0);
  rect(300, 0, 50, 50);
  
  // Yellow Button
  fill(255, 255, 0);
  rect(350, 0, 50, 50);
  
  //Eraser Button
  fill(255);
  rect(400, 0, 50, 50); 
  fill(0); 
  textSize(32); 
  text('E', 415, 35); 
  
  // Save Button
  fill(255);
  rect(450, 0, 50, 50); 
  fill(0); 
  textSize(32);
  text('S', 465, 35);
  
  // Load Button
  fill(255); 
  rect(500, 0, 50, 50); 
  fill(0); 
  textSize(32); 
  text('L', 515, 35); 
  
  // Spray Paint button
  fill(255);
  rect(550, 0, 50, 50);
  fill(0);
  textSize(32);
  text('P', 560, 35); 
  
  // Invert Button
  fill(255);
  rect(650, 0, 50, 50);
  fill(0);
  textSize(32);
  text('I', 670, 35);
  
  // Undo Button
  fill(255); 
  rect(600, 0, 50, 50); 
  fill(0); 
  textSize(32);
  text('U', 614, 35); 
  
  // Text Button
  fill(255);
  rect(700, 0, 50, 50);
  fill(0);
  textSize(32);
  text('T', 717, 35); // 'T' for Text
  
  // Exit Full Screen Button
  fill(255); 
  rect(width - 60, height - 60, 50, 50); 
  fill(0); // Black 'X'
  textSize(32);
  text('X', width - 43, height - 25); 
  
  // Star button
   fill(255);
  rect(750, 0, 50, 50); 
  beginShape();
    vertex(776, 12);
    vertex(783, 40);
    vertex(760, 23);
    vertex(790, 23);
    vertex(760, 40);
  endShape(CLOSE);
  
  // Increase Brush Size Button 
    fill(255); 
    rect(800, 0, 50, 50); 
    fill(0); 
    textSize(32);
    text('+', 817, 35); 

    // Decrease Brush Size Button 
    fill(255); 
    rect(850, 0, 50, 50); 
    fill(0); 
    textSize(32);
    text('-', 871, 35);
  
  // Button logic
  if (mousePressed) {
    if (0 < mouseX && mouseX < 50 && 0 < mouseY && mouseY < 50) {
      tool = "line";
    } else if (50 < mouseX && mouseX < 100 && 0 < mouseY && mouseY < 50) {
      tool = "brush";
    } else if (100 < mouseX && mouseX < 150 && 0 < mouseY && mouseY < 50) {
      tool = "rectangle";
    } else if (150 < mouseX && mouseX < 200 && 0 < mouseY && mouseY < 50) {
      tool = "ellipse";
    } else if (400 < mouseX && mouseX < 450 && 0 < mouseY && mouseY < 50) {
      tool = "eraser"; 
    } else if (450 < mouseX && mouseX < 500 && 0 < mouseY && mouseY < 50) {
      tool = "save";
    } else if (500 < mouseX && mouseX < 550 && 0 < mouseY && mouseY < 50) {
      tool = "load";
    } else if (550 < mouseX && mouseX < 600 && 0 < mouseY && mouseY < 50) {
      tool = "sprayPaint";
    } else if (600 < mouseX && mouseX < 650 && 0 < mouseY && mouseY < 50) {
      tool = "undo";
   }
 }
}
