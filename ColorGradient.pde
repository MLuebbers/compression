public class ColorGradient{
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
