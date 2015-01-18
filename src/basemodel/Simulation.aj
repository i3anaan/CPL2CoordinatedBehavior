package basemodel;

public aspect Simulation {

	public static void main(String[] args) {
		System.out.println("Starting Simulation");
		Map map = new Map(3, 5, 1);
	}

	public void Elf.doSimulationStep() {
		if (targetTile != null) {
			moveTowardsTarget();
			// Instantly clean
			if (x == targetTile.getX() && y == targetTile.getY()) {
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
		System.out.println(this);
	}

	pointcut mapMade(Map m): target(m) && execution(Map.new(..));

	after(Map m): mapMade(m){
		for (int i = 0; i < 10; i++) {
			System.out.println(">> SimulationStep " + i + " Start");
			m.doSimulationStep();
			System.out.println("<< SimulationStep " + i + " Done");
		}
	}
}
