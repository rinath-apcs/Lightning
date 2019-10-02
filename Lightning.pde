ArrayList<Worm> worms;
boolean[][] coords;
float keyCounter;

final int diameter = 1;
final int scalar = 3;
final int startingWorms = 100;
final boolean showCoords = false;

void setup() {
	size(1000, 1000);
	frameRate(-1);

	init();
}

void draw() {
    for (int i = 0; i < worms.size(); i++) {
		if (worms.get(i).isDead()) {
			worms.remove(i);
		} else {
			worms.get(i).step();
		}
	}

    if (keyPressed) {
    	if (key == 'r') {
    		worms.clear();
    		init();
    	} else {
    		for (int i = 0; i < (int) keyCounter; i++) 
    			worms.add(new Worm());
    	}
    	keyCounter += 0.25;
    } else {
    	keyCounter = 0;
    }

    if (showCoords) 
    	drawCoords();
}

class Worm {
	boolean dead;
	color col;
	int x, y;

	public Worm() {
		dead = false;

		int xPos = (int) (Math.random() * (width / scalar - 1));
		int yPos = (int) (Math.random() * (height / scalar - 1));

		col = color((int) (Math.random() * 125),
		(int) (Math.random() * 125),
		(int) (Math.random() * 125));

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

		if (validCoords.size() == 0) {
			dead = true;
			return;
		}

		Integer[] rand = validCoords.get((int) (Math.random() * validCoords.size()));

		stroke(col);
		strokeWeight(diameter);
		line(x * scalar, y * scalar, rand[0] * scalar, rand[1] * scalar);

		setCoords(rand[0], rand[1]);
	}

	public boolean isValid(int xPos, int yPos) {
		return ((yPos < coords.length && xPos < coords.length) && (yPos >= 0 && xPos >= 0)) && coords[yPos][xPos];
	}

	public boolean isDead() {
		return dead;
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

void init() {
	background(211);

    worms = new ArrayList();
	coords = new boolean[height / scalar][width / scalar];
	keyCounter = 1.0;

	for (boolean[] row : coords) {
		for (int i = 0; i < row.length; i++) {
			row[i] = true;
		}
	}

	for (int i = 0; i < startingWorms; i++) 
		worms.add(new Worm());
}