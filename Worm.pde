public class Worm {
	private boolean dead;
	private color col;
	private int x, y;

	public Worm() {
		dead = false;
		col = color((int) (Math.random() * 125), (int) (Math.random() * 125), (int) (Math.random() * 125));

		int xPos = (int) (Math.random() * (width / scalar - 1));
		int yPos = (int) (Math.random() * (height / scalar - 1));
		int counter = 0;

		while (!(coords[yPos][xPos])) {
			if (counter > 50) {
				dead = true;
				return;
			} else {
				xPos = (int) (Math.random() * (width / scalar - 1));
				yPos = (int) (Math.random() * (height / scalar - 1));
				counter++;
			}
		}

		setCoords(xPos, yPos);
	}

	private boolean isValid(int xPos, int yPos) {
		return ((yPos < coords.length && xPos < coords.length) && (yPos >= 0 && xPos >= 0)) && coords[yPos][xPos];
	}

	private void setCoords(int xPos, int yPos) {
		x = xPos;
		y = yPos;

		coords[y][x] = false;
	}

	public boolean isDead() {
		return dead;
	}

	public void step() {
		ArrayList<Integer[]> validCoords = new ArrayList();

		if (isValid(x+1, y)) validCoords.add(new Integer[]{x+1, y});
		if (isValid(x, y+1)) validCoords.add(new Integer[]{x, y+1});
		if (isValid(x-1, y)) validCoords.add(new Integer[]{x-1, y});
		if (isValid(x, y-1)) validCoords.add(new Integer[]{x, y-1});

		if (validCoords.size() == 0) {
			dead = true;
			return;
		}

		Integer[] rand = validCoords.get((int) (Math.random() * validCoords.size()));

		stroke(col);
		strokeWeight(diameter);
		line(x * scalar + (wooliness != 0 ? scalar / wooliness : 0), y * scalar + (wooliness != 0 ? scalar / wooliness : 0), rand[0] * scalar, rand[1] * scalar);

		setCoords(rand[0], rand[1]);
	}
}