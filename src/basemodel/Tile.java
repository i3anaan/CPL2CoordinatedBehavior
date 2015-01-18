package basemodel;

public class Tile {
	
	private int x;
	private int y;
	private boolean dirty = false;
	private boolean occupied = false;

	public Tile(int x, int y){
		this.x = x;
		this.y = y;
	}
	
	public int getX(){ return x;}
	public int getY(){ return y;}
	public void setDirty(boolean state){ dirty = state;}
	public boolean isDirty(){ return dirty;}
	public void setOccupied(boolean state){ occupied = state;}
	public boolean isOccupied(){return occupied;}
	
	public String toString(){
		return occupied ? "[e]" : (dirty ? "[.]" : "[ ]");
	}
	
}
