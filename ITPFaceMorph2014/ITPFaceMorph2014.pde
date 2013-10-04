// process photos so that the eye and mouse would be at the same place
// mode: morph all / morph A and B

PImage a;
PImage b;
//Morpher morph;
ArrayList<Morpher> morphs;
Table table;
String imgNameA;
String imgNameB;
String fNameA;
String lNameA;
String fNameB;
String lNameB;
int count = 0;

float amt =  0;
float increasement = 0.05;  // the bigger, the faster changing

void setup() {
  size(278, 430, P2D);
  frameRate(20);

  // load the table
  table = loadTable("../PointsOnFace/file/points.csv", "header");

  morphs = new ArrayList<Morpher>();
  loadImg(0);
}

void draw() {
  morphs.get(count).drawMorph(amt);
  amt+= increasement;
  if (amt >1) {
    // change to next img
    //   println("done");
    count++;
    loadImg(count);
    amt = 0;
  }
  displayName();
  saveFrame("2014_########.tif");
}

void loadImg(int _count) {
  int i = count;

  if (i< 113) {

    // load img A
    TableRow rowA = table.getRow(i);
    String imgNameA = rowA.getString("name");
    fNameA = rowA.getString("firstName");
    lNameA = rowA.getString("lastName");
    println(imgNameA + " :  " + fNameA + " "+ lNameA);
    a = loadImage(imgNameA+".png");
    //image(a, 0, 0);

    // load img B
    TableRow rowB = table.getRow(i+1);
    String imgNameB = rowB.getString("name");
    fNameB = rowB.getString("firstName");
    lNameB = rowB.getString("lastName");
    println(imgNameB + " :  " + fNameB + " "+ lNameB);
    b = loadImage(imgNameB+".png");
    //image(b, width/2, 0);

    // Create the morphing object
    morphs.add(new Morpher(a, b));

    // add pairs
    PVector leftA = new PVector(rowA.getFloat("leftX"), rowA.getFloat("leftY"));
    PVector leftB = new PVector(rowB.getFloat("leftX"), rowB.getFloat("leftY"));
    morphs.get(i).addPair(leftA, leftB);
    PVector rightA = new PVector(rowA.getFloat("rightX"), rowA.getFloat("rightY"));
    PVector rightB = new PVector(rowB.getFloat("rightX"), rowB.getFloat("rightY"));
    morphs.get(i).addPair(rightA, rightB);
    PVector bottomA = new PVector(rowA.getFloat("bottomX"), rowA.getFloat("bottomY"));
    PVector bottomB = new PVector(rowB.getFloat("bottomX"), rowB.getFloat("bottomY"));
    morphs.get(i).addPair(bottomA, bottomB);
  }
}

void displayName() {
  fill(255);
    textAlign(CENTER);
    textSize(32);
    if(amt<0.5) text(fNameA, width/2, height-30);
    else text(fNameB, width/2, height-30);
}

