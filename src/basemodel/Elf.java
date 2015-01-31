package basemodel;

public class Elf implements Obstacle {

	private Map map;
	private int x;
	private int y;
	protected Tile targetTile;

	public Elf(Map map, int x, int y) {
		this.map = map;
		this.x = x;
		this.y = y;
	}

	public void moveTowardsTarget() {
		try {
			if (x != targetTile.getX()) {
				moveStep(x + Math.round(Math.signum(targetTile.getX() - x)), y);
			} else if (y != targetTile.getY()) {
				moveStep(x, y + Math.round(Math.signum(targetTile.getY() - y)));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void moveStep(int x, int y) throws IllegalMoveException {
		if ((Math.abs(x - this.x) + Math.abs(y - this.y)) <= 1) {
			this.x = x;
			this.y = y;
		} else {
			throw new IllegalMoveException();
		}
	}

	public void requestNewTarget() {
		targetTile = map.getDirtyTileToClean();
	}

	public void cleanTile(Tile tile) {
		if (tile.equals(targetTile) && !tile.clean()) {
			targetTile = null;
			requestNewTarget();
		}
	}

	public String toString() {
		return "Elf("
				+ x
				+ ","
				+ y
				+ ")"
				+ (targetTile != null ? ("  Target: (" + targetTile.getX()
						+ "," + targetTile.getY() + ")") : "");
	}

	@Override
	public Map getMap() {
		return map;
	}

	@Override
	public int getX() {
		return x;
	}

	@Override
	public int getY() {
		return y;
	}

	public class IllegalMoveException extends Exception {
		public IllegalMoveException(){
			super("Move is not allowed!");
		}
	}
}
