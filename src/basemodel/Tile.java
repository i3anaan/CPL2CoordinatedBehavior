package basemodel;

public class Tile {
	
	private int x;
	private int y;
	private boolean dirty = false;
	private int currentObstacles = 0;

	public Tile(int x, int y){
		this.x = x;
		this.y = y;
	}
	
	public int getX(){ return x;}
	public int getY(){ return y;}
	public void setDirty(boolean state){ dirty = state;}
	public boolean isDirty(){ return dirty;}
	public void leaveTile(){ currentObstacles--;}
	public void enterTile(){ currentObstacles++;}
	public boolean isOccupied(){return currentObstacles>0;}
	public int getOccupation(){return currentObstacles;}
	
	public boolean clean(){ dirty = false; return dirty;}
	
	public String toString(){
		return "Tile ("+x+","+y+")";
	}
	
}
