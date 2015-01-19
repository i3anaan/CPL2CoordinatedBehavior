package basemodel;

public class Map {
	
	private Elf[] elves;
	private Tile[][] tiles;
	
	public Map(int xdim, int ydim, int elfAmount){
		tiles = new Tile[xdim][ydim];
		for(int x=0;x<xdim;x++){
			for(int y=0;y<ydim;y++){
				tiles[x][y] = new Tile(x,y);
				if(((x+y) % 5) == 2){
					tiles[x][y].setDirty(true);
				}
			}
		}
		
		elves = new Elf[elfAmount];
		for(int i=0;i<elfAmount;i++){
			elves[i] = new Elf(this,0,0);
		}
	}
	
	public Tile getDirtyTileToClean(){
		//Central command method
		//Something requests a tile here, this method fullfils that request
		for(Tile[] ts : tiles){
			for(Tile t : ts){
				if(t.needsCleaning()){
					return t;
				}
			}
		}
		return null;
	}
	
	public Elf[] getElves(){return elves;}
	public Tile[][] getTiles(){ return tiles;}
	public Tile getTile(int x, int y){
		if(x>=0 && x<tiles.length && y>=0 && y<tiles[0].length){
			return tiles[x][y];
		}else{
			return null;
		}
	}
	
	
	public String toString(){
		return "Map ("+tiles.length+"x"+tiles[0].length+")\nElves: "+elves.length;
	}
}
