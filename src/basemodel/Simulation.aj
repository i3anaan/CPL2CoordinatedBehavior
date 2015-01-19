package basemodel;

public aspect Simulation {

	public static final int SIMULATION_STEPS = 30;
	
	public static void main(String[] args) {
		System.out.println("Starting Simulation");
		Map map = new Map(15, 15, 20);
	}

	public String Map.showSimulationState(){
		String output = "\n";
		for(int y=0; y<getTiles()[0].length;y++){
			for(int x=0; x<getTiles().length;x++){
				output += getTile(x,y).showSimulationState();
			}
			output += "\n";
		}
		
		return output;
	}
	
	
	public String Tile.showSimulationState(){
		return isOccupied() ? "["+getOccupation()+"]" : (isDirty() ? "[.]" : "[ ]");
	}
	
	
	
	public void Elf.doSimulationStep() {
		if (targetTile != null) {
			moveTowardsTarget();
			// Instantly clean
			if (getX() == targetTile.getX() && getY() == targetTile.getY()) {
				cleanCurrentTile(targetTile);
			}
		} else {
			requestNewTarget();
			if (targetTile != null) {
				moveTowardsTarget();
			}
		}
	}

	public void Map.doSimulationStep() {
		for (Elf e : getElves()) {
			e.doSimulationStep();
		}
		System.out.println(showSimulationState());
	}

	pointcut mapMade(Map m): target(m) && execution(Map.new(..));

	after(Map m): mapMade(m){
		for (int i = 0; i < SIMULATION_STEPS; i++) {
			System.out.println(">> SimulationStep " + i + " Start\n");
			m.doSimulationStep();
			System.out.println("\n<< SimulationStep " + i + " Done");
		}
	}
}
