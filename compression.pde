ColorGradient cg;

void setup() {
  size(200, 800);
  cg = new ColorGradient(Integer.parseInt(args[2]));
  print(Integer.parseInt(args[2]));
  cg.addStop(color(0,0,51), color(51,0,0), 1);
  cg.addStop(color(0,51,51), color(255,255,255), 1.15);
  // cg.addStop(color(255,255,255), color(255,153,153), 1);
  
  if(args != null) {
    switch(args[0]){
      case "create":
        image(createPerlin(30.0, cg),0,0);
        save("prints/bitmaps/noise-" + args[1] + ".bmp");
        exit();
        break;
      case "restructure":
        image(restructureImage("prints/jpegs/noise-" + (Integer.parseInt(args[1])-1) + ".jpg"),0,0);
        save("prints/bitmaps/noise-" + args[1] + ".bmp");
        exit();
        break;      
    }
  }
}

public PImage createPerlin(float r, ColorGradient g) {
   PImage noiseMap = createImage(width, height, RGB);
   noiseMap.loadPixels();
   for(int j = 0; j < height; j ++) {
     for(int i = 0; i < width; i ++) {
        color c = g.getColor(noise(i/r, j/r));
        noiseMap.pixels[(i % width) + (j * width)] = c;
     }
   }
   noiseMap.updatePixels();
   return noiseMap;
}

public PImage restructureImage(String filename) {
  PImage loadedImage = loadImage(filename);
  loadedImage.loadPixels();
    for(int i = 0; i < loadedImage.pixels.length; i ++) {
      color c = loadedImage.pixels[i];
      color mc = cg.getColor(hue(c)/255.0);
      colorMode(HSB,255);
      loadedImage.pixels[i] = color(hue(mc), saturation(mc), brightness(mc));
      colorMode(RGB,255);
    }
  loadedImage.updatePixels();
  return loadedImage;
}
