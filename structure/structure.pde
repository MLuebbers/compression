
ColorGradient cg;

void setup() {
  size(200, 800);
  cg = new ColorGradient(256);
  cg.addStop(color(200,100,255), color(255,255,100), 2);
  cg.addStop(color(255,255,100), color(255,255,255), 1);
  cg.addStop(color(255,255,255), color(60,100,255), 3);
  
}


public PImage restructureImage(String filename) {
  PImage loadedImage = loadImage(filename);
  loadedImage.loadPixels();
    for(int i = 0; i < loadedImage.pixels.length; i ++) {
      color c = loadedImage.pixels[i];
      loadedImage.pixels[i] = cg.getColor(hue(c)/255.0);
    }
  loadedImage.updatePixels();
  return loadedImage;
}


public class ColorGradient {
  private float _len;
  private int _resolution;
  private ArrayList<Stop> _stops;
  
  public ColorGradient(int resolution) {
    _stops = new ArrayList<Stop>();
    _resolution = resolution;
    
  }
  
  public void addStop(color from, color to, float len) {
    _len += len;
    _stops.add(new Stop(from, to, len));
  }
  
  public color getColor(float pos){
    float scaledPos = pos * _len;
    float totalLen = 0;
    int i = 0;
    Stop currStop = _stops.get(i);
    
    while(totalLen + currStop.getLen() < scaledPos) { 
      i ++;
      totalLen += currStop.getLen();
      currStop = _stops.get(i);
    }
    return currStop.getColor(map(round(map((scaledPos - totalLen), 0, _len, 0, float(_resolution))), 0, float(_resolution), 0, _len));
    
  }
  
  private class Stop {
    private float _len;
    private color _from;
    private color _to;
    
    public Stop(color from, color to, float len) {
      _len = len;
      _from = from;
      _to = to;
    }
    public color getColor(float pos) {
      return lerpColor(_from, _to, pos/_len);
    }
    public float getLen() {
      return _len;
    }
  }
}
