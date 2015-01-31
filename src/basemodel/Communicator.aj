package basemodel;

public aspect Communicator {
	
	private Elf Tile.incomingElf = null;
	private int Obstacle.sanityDistance = 2;
	
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
	
	pointcut obstacleStepCall(Obstacle obst,int x, int y): target(obst) && args(x,y) && call(* *.moveStep(..));
	void around(Obstacle obst, int x, int y): obstacleStepCall(obst, x, y){
		boolean allowed = true;
		for(int xd=-obst.sanityDistance;xd<obst.sanityDistance;xd++){
			for(int yd=-obst.sanityDistance;yd<obst.sanityDistance;yd++){
				Tile tile = obst.getMap().getTile(x + xd, y + yd);
				if (tile != null
						&& Math.sqrt(xd * xd + yd * yd) <= obst.sanityDistance
						&& tile.isOccupied()) {
					double newDist = Math.sqrt(xd * xd + yd * yd);
					double oldDist = Math.sqrt((-obst.getX() + x + xd)
							* (-obst.getX() +x + xd)
							+ (-obst.getY() + y + yd)
							* (-obst.getY() + y + yd));
					if (newDist <= oldDist) {
						allowed = false;
					}
				}
			}
		}
		
		if(allowed && !obst.getMap().getTile(x, y).isOccupied()){
			proceed(obst,x,y);
		}else{
			return;
		}
	}
}
