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
    for (Worm worm : worms) 
    	worm.step();

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
	color col;
	int x, y;

	public Worm() {
		int xPos = (int) (Math.random() * (width / scalar - 1));
		int yPos = (int) (Math.random() * (height / scalar - 1));

		col = color((int) (Math.random() * 125),
		(int) (Math.random() * 125),
		(int) (Math.random() * 125));

		while (!(coords[yPos][xPos])) {
			xPos = (int) (Math.random() * (width / scalar - 1));
			yPos = (int) (Math.random() * (height / scalar - 1));
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

		if (validCoords.size() == 0) return;

		Integer[] rand = validCoords.get((int) (Math.random() * validCoords.size()));

		stroke(col);
		strokeWeight(diameter);
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