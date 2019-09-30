import java.util.*;

Worm[] worms;
boolean[][] coords;

void setup() {
	size(1000, 1000);

	worms = new Worm[100];

	coords = new boolean[height / 5][width / 5];

	for (boolean[] row : coords) {
		Arrays.fill(row, true);
	}


	for (int i = 0; i < worms.length; i++) {
		worms[i] = new Worm();
	}
}

void draw() {
    for (Worm worm : worms) {
    	worm.step();
    }
}

class Worm {
	int x, y;

	public Worm() {
		setCoords((int) (Math.random() * (width / 5 - 1)), (int) (Math.random() * (height / 5 - 1)));
	}

	public void setCoords(int xPos, int yPos) {
		x = xPos;
		y = yPos;

		coords[y][x] = false;
	}

	public void step() {
		ArrayList<Integer[]> validCoords = new ArrayList();

		if (isValid(x+1, y)) validCoords.add(new Integer[]{x+1, y});
		if (isValid(x, y+1)) validCoords.add(new Integer[]{x, y+1});
		if (isValid(x-1, y)) validCoords.add(new Integer[]{x-1, y});
		if (isValid(x, y-1)) validCoords.add(new Integer[]{x, y-1});

		if (validCoords.size() == 0) return;

		Integer[] rand = validCoords.get((int) (Math.random() * validCoords.size()));

		fill(150);
		line(x * 5, y * 5, rand[0] * 5, rand[1] * 5);

		setCoords(rand[0], rand[1]);
	}

	public boolean isValid(int xPos, int yPos) {
		return ((yPos < coords.length && xPos < coords.length) && (yPos >= 0 && xPos >= 0)) && coords[yPos][xPos];
	}
}