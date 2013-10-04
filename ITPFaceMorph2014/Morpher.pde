import triangulate.*;

class Morpher {
  ArrayList<Pair> pairs = new ArrayList<Pair>();
  ArrayList<TrianglePair> tiles;
  PImage imgA;
  PImage imgB;

  Morpher(PImage _imgA, PImage _imgB ) {
    imgA = _imgA;
    imgB = _imgB;

    pairs.add(new Pair(0, 0));
    pairs.add(new Pair(imgA.width/2, 0));
    pairs.add(new Pair(imgA.width, 0));
    pairs.add(new Pair(0, imgA.height/2));
    pairs.add(new Pair(imgA.width, imgA.height/2));
    pairs.add(new Pair(0, imgA.height));
    pairs.add(new Pair(imgA.width/2, imgA.height));
    pairs.add(new Pair(imgA.width, imgA.height));
    makeTriangles();
  }

  void addPair(PVector a, PVector b) {
    pairs.add(new Pair(a.get(), b.get()));
    makeTriangles();
  }

  void makeTriangles() {
    tiles = Triangulate.triangulatePairs(pairs);
  }

  void drawMorph(float amt) {

    // For every triangle
    for (int i = 0; i < tiles.size(); i++) {

      // Let's get the pair
      TrianglePair tp = tiles.get(i);
      // We make a new triangle which interpolates 
      Triangle t = tp.mix(amt);

      // Draw the first image
      tint(255);
      // stroke(255); // show triangles
      noStroke();
      noFill();
      textureMode(IMAGE);
      beginShape();
      texture(imgA);
      // Use morphed triangle with corresponding texture points on original triangle
      vertex(t.p1.x, t.p1.y, tp.p1.a.x, tp.p1.a.y);
      vertex(t.p2.x, t.p2.y, tp.p2.a.x, tp.p2.a.y);
      vertex(t.p3.x, t.p3.y, tp.p3.a.x, tp.p3.a.y);
      endShape();

      // Draw the second image blended with first
      noStroke();
      noFill();
      tint(255, amt*255);
      //tint(255,255); // Try showing ImageB always
      //stroke(255);   // Try showing show triangles
      textureMode(IMAGE);
      beginShape();
      texture(imgB);
      // Use morphed triangle with corresponding texture points on original triangle
      vertex(t.p1.x, t.p1.y, tp.p1.b.x, tp.p1.b.y);
      vertex(t.p2.x, t.p2.y, tp.p2.b.x, tp.p2.b.y);
      vertex(t.p3.x, t.p3.y, tp.p3.b.x, tp.p3.b.y);
      endShape();
    }
  }
}

