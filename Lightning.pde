import java.util.*;

ArrayList<Worm> worms;
boolean[][] coords;

final int scalar = 10;
final boolean showCoords = false;

void setup() {
	size(1000, 1000);
	frameRate(-1);
	worms = new ArrayList();
	coords = new boolean[height / scalar][width / scalar];

	for (boolean[] row : coords) 
		Arrays.fill(row, true);

	for (int i = 0; i < 100; i++) 
		worms.add(new Worm());

}

void draw() {
    for (Worm worm : worms) 
    	worm.step();

    if (keyPressed) 
    	worms.add(new Worm());

    if (showCoords) 
    	drawCoords();
}

class Worm {
	int x, y;

	public Worm() {
		int x = (int) (Math.random() * (width / scalar - 1));
		int y = (int) (Math.random() * (height / scalar - 1));

		while (!(isValid(x, y))) {
			x = (int) (Math.random() * (width / scalar - 1));
			y = (int) (Math.random() * (height / scalar - 1));
		}

		setCoords(x, y);
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
		line(x * scalar, y * scalar, rand[0] * scalar, rand[1] * scalar);

		setCoords(rand[0], rand[1]);
	}

	public boolean isValid(int xPos, int yPos) {
		return ((yPos < coords.length && xPos < coords.length) && (yPos >= 0 && xPos >= 0)) && coords[yPos][xPos];
	}
}

void drawCoords() {
	for (int y = 0; y < coords.length; y++) {
    	for (int x = 0; x < coords[0].length; x++) {
    		fill(coords[y][x] ? 255 : 0, 0, 0);
    		ellipse(x * scalar, y * scalar, scalar / 2, scalar / 2);
    	}
    }
}
