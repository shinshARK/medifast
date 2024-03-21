


class LayarScreens {
  double width;
  double height;
  
  LayarScreens({
    required this.height,
    required this.width
  });

  void setwidth(double width){
    while(width / pembagianlayar > 500){
      pembagianlayar++;
    }
    this.width = width;
  }

}


var screens = LayarScreens(height: 0, width: 0);
int pembagianlayar = 1;


