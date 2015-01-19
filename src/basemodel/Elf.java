package basemodel;

public class Elf implements Obstacle{

	private Map map;
	private int x;
	private int y;

	// Have to open up a lot of visibility to let aspects use it
	protected Tile targetTile;

	public Elf(Map map, int x, int y) {
		this.map = map;
		this.x = x;
		this.y = y;
	}

	public void moveTowardsTarget() {
		if (x != targetTile.getX()) {
			moveStep(x + Math.round(Math.signum(targetTile.getX() - x)), y);
		} else if (y != targetTile.getY()) {
			moveStep(x, y + Math.round(Math.signum(targetTile.getY() - y)));
		}
	}

	public void moveStep(int x, int y) {
		if ((Math.abs(x - this.x) + Math.abs(y - this.y)) <= 1) {
			this.x = x;
			this.y = y;
		} else {
			// TODO Exception van maken
			System.err
					.println("Illegal move: elf is moving more than 1 tile per turn");
		}
	}

	public void requestNewTarget() {
		targetTile = map.getDirtyTileToClean();
	}

	public void cleanCurrentTile(Tile tile) {
		tile.setDirty(false);
		targetTile = null;
	}

	public String toString() {
		return "Elf(" + x + "," + y + ")" + (targetTile!=null ? ("  Target: (" + targetTile.getX()
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
}
