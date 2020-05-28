class Stars {
  int starCount;

  Stars(int count) {
    this.starCount = count;
  }

  void printStars() {
    for (int i = 0; i < starCount; i++) {
      print(i);
    }
  }
}
