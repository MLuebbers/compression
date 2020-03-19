import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class compression extends PApplet {

ColorGradient cg;

public void setup() {
  
  cg = new ColorGradient(Integer.parseInt(args[2]));
  print(Integer.parseInt(args[2]));
  cg.addStop(color(0,0,51), color(51,0,0), 1);
  cg.addStop(color(0,51,51), color(255,255,255), 1.15f);
  // cg.addStop(color(255,255,255), color(255,153,153), 1);
  
  if(args != null) {
    switch(args[0]){
      case "create":
        image(createPerlin(30.0f, cg),0,0);
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
        int c = g.getColor(noise(i/r, j/r));
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
      int c = loadedImage.pixels[i];
      int mc = cg.getColor(hue(c)/255.0f);
      colorMode(HSB,255);
      loadedImage.pixels[i] = color(hue(mc), saturation(mc), brightness(mc));
      colorMode(RGB,255);
    }
  loadedImage.updatePixels();
  return loadedImage;
}
public class ColorGradient{
  private float _len;
  private int _resolution;
  private ArrayList<Stop> _stops;
  
  public ColorGradient(int resolution) {
    _stops = new ArrayList<Stop>();
    _resolution = resolution;
    
  }
  
  public void addStop(int from, int to, float len) {
    _len += len;
    _stops.add(new Stop(from, to, len));
  }
  
  public int getColor(float pos){
    float scaledPos = pos * _len;
    float totalLen = 0;
    int i = 0;
    Stop currStop = _stops.get(i);
    
    while(totalLen + currStop.getLen() < scaledPos) { 
      i ++;
      totalLen += currStop.getLen();
      currStop = _stops.get(i);
    }
    return currStop.getColor(map(round(map((scaledPos - totalLen), 0, _len, 0, PApplet.parseFloat(_resolution))), 0, PApplet.parseFloat(_resolution), 0, _len));
    
  }
  
  private class Stop {
    private float _len;
    private int _from;
    private int _to;
    
    public Stop(int from, int to, float len) {
      _len = len;
      _from = from;
      _to = to;
    }
    public int getColor(float pos) {
      return lerpColor(_from, _to, pos/_len);
    }
    public float getLen() {
      return _len;
    }
  }
}
  public void settings() {  size(200, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "compression" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
