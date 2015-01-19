package basemodel;

public aspect Logging {

	declare precedence : Communicator, Logging;
	
	
	pointcut cleaningTile(Elf e): target(e) && execution(* cleanCurrentTile(..));
	
	before(Elf e): cleaningTile(e){
		//System.out.println(e+"  Cleaning tile");
	}
	
	//If you want to really separate concerns, it can cause duplicate code in aspects.
	//In this case Logging and Other aspects
	
	pointcut obstacleStepExec(Obstacle obst,int x, int y): target(obst) && args(x,y) && execution(* *.moveStep(..));
	
	before(Obstacle obst, int x, int y) : obstacleStepExec(obst, x , y){
		if(obst.getMap().getTile(x, y).isOccupied()){
			//System.out.println("Collision at tile ("+x+","+y+")!");
		}
	}
	
	pointcut obstacleMoveTowardsTarget(Obstacle obst): target(obst) && call(* *.moveTowardsTarget(..));
	before(Obstacle obst): obstacleMoveTowardsTarget(obst){
		//System.out.println(obst);
	}
	
	
	
	
	//Cannot match on Map.toString() unless Map explicitly override toString from object
	//Map.toString() seems to never be called, just object.toString()
	//pointcut mapToString(Map m): target(m) && within(Map) && execution(String *.toString());
	
	//before(Map m): mapToString(m){
	//	System.out.println("Before Map.toString() overriding");
	//}
	/*
	
	//Cannot override toString.
	//Using an interface does not allow access to getTiles()
	//Thus need to use this.
	String around(Map m): mapToString(m){
		String output = "";
		Tile[][] tiles = m.getTiles();
		for(int y=0;y<tiles[0].length;y++){
			for(int x=0;x<tiles.length;x++){
				output += tiles[x][y].toString();
			}
			output += "\n";
		}
		return output;
	}
	*/
	
	
	/*
	private interface DebugMap{};
	declare parent
	public String DebugMap.toString(){
		String output = "";
		Tile[][] tiles = m.getTiles();
		for(int y=0;y<tiles[0].length;y++){
			for(int x=0;x<tiles.length;x++){
				output += tiles[x][y].toString();
			}
			output += "\n";
		}
		return output;
	}
	*/
	
	
	//pointcut simulationStep(Map m): target(m) && execution(Map.new(..));
	//before(Map m): simulationStep(m){
	//	System.out.println("Starting simulation");
	//}
	//
	//after(Map m) returning: simulationStep(m){
	//	System.out.println(m);
	//}
}
