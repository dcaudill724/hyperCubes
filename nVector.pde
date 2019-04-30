class nVector {
  float[][] coords;

  nVector(float[] coords) {
    this.coords = new float[coords.length][1];
    for (int i = 0; i < coords.length; ++i) {
      this.coords[i][0] = coords[i];
    }
  }

  float get(int i) {
    return coords[i][0];
  }
  
  int length() {
    return coords.length; 
  }
  
  nVector copy() {
    float[] newCoords = new float[coords.length];
    for (int i = 0; i < coords.length; ++i) {
      newCoords[i] = coords[i][0]; 
    }
    return new nVector(newCoords);
  }
  
  nVector copy(int dimension) {
    float[] newCoords = new float[dimension];
    for (int i = 0; i < dimension; ++i) {
      newCoords[i] = coords[i][0]; 
    }
    return new nVector(newCoords);
  }
  
  void write() {
    for (int i = 0; i < coords[0].length; ++i) {
      for (int j = 0; j < coords.length; ++j) {
        print(coords[j][i] + " "); 
      }
      println(" ");
    }
  }
  
  float distance(nVector pt2) {
    float sum = 0;
    if (coords.length != pt2.coords.length) {
      return 0; 
    } else {
      for (int i = 0; i < coords.length; ++i) {
        sum += (sq(pt2.get(i) - get(i)));
      }
    }
    return sqrt(sum);
  }

  void mult(float[][] matrix) {
    int colsA = matrix[0].length;
    int rowsA = matrix.length;
    int colsB = coords[0].length;
    int rowsB = coords.length;
    if (colsA != rowsB) return;
    float[][] result = new float[rowsA][colsB];
    for (int i = 0; i < rowsA; ++i) {
      for (int j = 0; j < colsB; ++j) {
        for (int k = 0; k < colsA; ++k) {
          result[i][j] += matrix[i][k] * coords[k][j];
        }
      }
    }
    coords = result;
  }
}
