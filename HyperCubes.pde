nCube cube;
float angle;
float scale;

void setup() {
  size(700, 700, P3D);
  //cube = new nCube(4, 2, new int[]{2});
  cube = new nCube(10, 2, new int[]{2, 5});
  angle = 0;
  scale = 100;
  sphereDetail(5);
}

void draw() {
  lights();
  background(0);
  translate(width / 2, height / 2, 0);
  rotateY(angle += 0.01);
  cube.update().display();
}
