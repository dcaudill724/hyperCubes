class nCube {
  nVector[] points;
  nVector[] projection;
  color[] pointColors;
  ArrayList<PVector> lineIndecies;
  int[] rotationAxes;
  int dimension;
  float distance;

  nCube(int dimension, float distance, int[] rotationAxes) {
    this.dimension = dimension;
    this.distance = distance;
    this.rotationAxes = rotationAxes;
    points = new nVector[(int)pow(2, dimension)];
    for (int i = 0; i < points.length; ++i) {
      float[] point = new float[dimension];
      points[i] = new nVector(point);
    }
    int count = points.length;
    for (int i = 0; i < dimension; ++i) {
      count /= 2;
      boolean sign = true;
      int tempCount = 0;
      for (int j = 0; j < points.length; ++j) {
        if (sign) {
          points[j].coords[i][0] = 1;
        } else {
          points[j].coords[i][0] = -1;
        }
        ++tempCount;
        if (tempCount == count) {
          tempCount = 0;
          sign = !sign;
        }
      }
    }
     
    lineIndecies = new ArrayList<PVector>();
    for (int i = 0; i < points.length; ++i) {
      for (int j = 0; j < points.length; ++j) {
        if (i != j && points[i].distance(points[j]) == distance) {
          lineIndecies.add(new PVector(i, j));
        }
      }
    }
  }

  nCube update() {
    projection = new nVector[points.length];
    for (int i = 0; i < points.length; ++i) {
      projection[i] = points[i].copy();
      for (int j = 0; j < rotationAxes.length; ++j) {
        float[][] matrix = new float[dimension][dimension];
        for (int k = 0; k < dimension; ++k) {
          for (int l = 0; l < dimension; ++l) {
            if (k == l) matrix[k][l] = 1;
            else matrix[k][l] = 0;
          }
        }
        matrix[rotationAxes[j]][rotationAxes[j]] = cos(angle);
        matrix[rotationAxes[j] + 1][rotationAxes[j] + 1] = cos(angle);
        matrix[rotationAxes[j]][rotationAxes[j] + 1] = -sin(angle);
        matrix[rotationAxes[j] + 1][rotationAxes[j]] = sin(angle);
        projection[i].mult(matrix);
      }
      
      for (int l = 0; l < dimension - 3; ++l) {
        float w = 1 / (distance - projection[i].get(dimension - (1 + l)));
        float[][] matrix = new float[dimension - 1 - l][dimension - l];
        for (int j = 0; j < matrix.length; ++j) {
          for (int k = 0; k < matrix[0].length; ++k) {
            if (j != dimension - 1 && k == j) matrix[j][k] = w;
            else matrix[j][k] = 0;
          }
        }
        projection[i].mult(matrix);
        projection[i] = projection[i].copy(dimension - 1 - l);
      }
    }
    return this;
  }

  void display() {
    fill(0, 255, 255);
    noStroke();
    for (nVector point : projection) {
      pushMatrix();
      translate(point.get(0) * scale, point.get(1) * scale, point.get(2) * scale);
      sphere(5);
      popMatrix();
    }
    for (PVector p : lineIndecies) {
      connect(projection[(int)p.x], projection[(int)p.y]);
    }
  }


  void connect(nVector pt1, nVector pt2) {
    strokeWeight(1);
    stroke(0, 255, 255, 100);
    line(pt1.get(0) * scale, pt1.get(1) * scale, pt1.get(2) * scale, pt2.get(0) * scale, pt2.get(1) * scale, pt2.get(2) * scale);
  }
}
