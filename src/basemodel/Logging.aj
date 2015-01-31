package basemodel;

public aspect Logging {

	declare precedence : Communicator, Logging;
	
	
	pointcut cleaningTile(Elf e): target(e) && execution(* cleanCurrentTile(..));
	
	before(Elf e): cleaningTile(e){
		//System.out.println(e+"  Cleaning tile");
	}
	
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
}
