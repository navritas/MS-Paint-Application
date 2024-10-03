class Star extends Shape {
    float radius1, radius2; 
    int npoints; 
    
    //Constructor Method
    Star(int x, int y, float radius1, float radius2, int npoints, color colour) {
        super(x, y, colour); 
        this.radius1 = radius1;
        this.radius2 = radius2;
        this.npoints = npoints;
    }

    void display() {
        fill(shapeColor); 
        noStroke();
        pushMatrix();
        translate(x, y);
        beginShape();
        float angle = TWO_PI / npoints;
        float halfAngle = angle / 2.0;
        for (float a = 0; a < TWO_PI; a += TWO_PI / npoints) {
            float sx = cos(a) * radius1;
            float sy = sin(a) * radius1;
            vertex(sx, sy);
            sx = cos(a + PI / npoints) * radius2;
            sy = sin(a + PI / npoints) * radius2;
            vertex(sx, sy);
        }
        endShape(CLOSE);
        popMatrix();
    }
}
