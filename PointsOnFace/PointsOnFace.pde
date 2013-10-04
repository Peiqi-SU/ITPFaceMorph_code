import java.io.File;

int id = 0;
String[] names;
PImage img;
Table table;
Table table_matchdata;
PVector a;
PVector b;
PVector c;

int countPoint = 0;

void setup() {
  size(278, 430, P2D);

  ellipseMode(CENTER);
  noStroke();

  // list files
  int count = 0;
  String path = "/Users/peiqisu/Courses/FaceIt/ITPFaceMorph/PointsOnFace/data"; 
  String files;
  File folder = new File(path);
  File[] listOfFiles = folder.listFiles(); 
  names = new String[listOfFiles.length];

  for (int i = 0; i < listOfFiles.length; i++) {
    if (listOfFiles[i].isFile()) {
      files = listOfFiles[i].getName();
      if (files.endsWith(".png")) {
        //println(files);
        names[count] = files; // add file name to a array
        count ++;
      }
    }
  }
  println(count);
  //println(names);

  // set up table
  table = new Table();

  table.addColumn("name");
  table.addColumn("leftX");
  table.addColumn("rightX");
  table.addColumn("bottomX");
  table.addColumn("leftY");
  table.addColumn("rightY");
  table.addColumn("bottomY");
  table.addColumn("firstName");
  table.addColumn("lastName");

  // load table_matchdata
  table_matchdata = loadTable("file/matchdata.csv");
}

void draw() {
}

// "space" for save points and change pictures
void keyPressed() {
  if (key == 's') {
    showPhoto();
  }
}

// save points and change picture
void showPhoto() {
  // load picture
  img = loadImage(names[id]);
  image(img, 0, 0);
}

void mousePressed() {
  if (mouseX > 10 && mouseX < img.width-10 && mouseY > 10 && mouseY < img.height -10) {
    if (countPoint ==0) {
      fill(255, 20, 20);
      ellipse(mouseX, mouseY, 10, 10);

      a = new PVector(mouseX, mouseY);
      countPoint++;
    }
    else if (countPoint ==1) {
      fill(20, 255, 20);
      ellipse(mouseX, mouseY, 10, 10);

      b = new PVector(mouseX, mouseY);
      countPoint++;
    }
    else if (countPoint ==2) {
      fill(20, 20, 255);
      ellipse(mouseX, mouseY, 10, 10);

      c = new PVector(mouseX, mouseY);
      countPoint = 0;
      saveData();
    }
  }
}

void saveData() {
  // save points
  String[] temp_2 = split(names[id], '.');
  TableRow newRow = table.addRow();
  newRow.setString("name", temp_2[0]);
  newRow.setFloat("leftX", a.x);
  newRow.setFloat("leftY", a.y);
  newRow.setFloat("rightX", b.x);
  newRow.setFloat("rightY", b.y);
  newRow.setFloat("bottomX", c.x);
  newRow.setFloat("bottomY", c.y);
  println(temp_2[0]);

  // find name
  TableRow result = table_matchdata.findRow(temp_2[0], 0);
  String firstName = result.getString(1);
  String lastName = result.getString(2);
  newRow.setString("firstName", firstName);
  newRow.setString("lastName", lastName);

  saveFrame("pointedFace/"+names[id]);
  saveTable(table, "file/points.csv");
  id ++;
  showPhoto();
}

