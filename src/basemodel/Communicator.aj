package basemodel;

public aspect Communicator {
	
	private Elf Tile.incomingElf = null;
	
	public boolean Tile.needsCleaning(){
		return isDirty() && incomingElf==null;
	}
	
	pointcut obstacleStepExec(Obstacle obst): target(obst) && execution(* *.moveStep(..));
	
	before(Obstacle obst) : obstacleStepExec(obst){
		obst.getMap().getTile(obst.getX(), obst.getY()).leaveTile();
	}
	after(Obstacle obst) returning: obstacleStepExec(obst) || (target(obst) && execution(*.new(..))){
		obst.getMap().getTile(obst.getX(), obst.getY()).enterTile();
	}
	
	
	pointcut requestingTile(Elf elf) : target(elf) && execution(* *.requestNewTarget(..));
	after(Elf elf) returning: requestingTile(elf){
		if(elf.targetTile!=null){
			elf.targetTile.incomingElf = elf;
		}
	}
	
	/*
	
	pointcut obstacleStepCall(Obstacle obst,int x, int y): target(obst) && args(x,y) && call(* *.moveStep(..));
	void around(Obstacle obst, int x, int y): obstacleStepCall(obst, x, y){
		if(!obst.getMap().getTile(x, y).isOccupied()){
			proceed(obst,x,y);
		}else{
			return;
		}
	}
	
	
	
	
	/*
	 * Decided not to go with this, as it requires rewriting the pathing logic
	pointcut obstacleRouting(Obstacle obst): target(obst) && call(* *.moveTowardsTarget(..));
	void around(Obstacle obst) : obstacleRouting(obst){
		//Rewrite pathing logic
	}
	*/
}
