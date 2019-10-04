ArrayList<Worm> worms;
boolean[][] coords;
boolean wooly;
int keyCounter;

final int diameter = 2;
final int scalar = 4;
final int startingWorms = 1;
final float wooliness = 8;
final boolean showCoords = false;

void setup() {
	size(1000, 1000);
	frameRate(-1);
	wooly = false;

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
    		for (int i = 0; i < keyCounter/4; i++)  {
    			worms.add(new Worm());
    		}
    	}
    	
    	keyCounter++;
    } else {
    	keyCounter = 0;
    }

    if (showCoords) 
    	drawCoords();
}

void mousePressed() {
	wooly = !wooly;
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
	keyCounter = 1;

	for (boolean[] row : coords) {
		for (int i = 0; i < row.length; i++) {
			row[i] = true;
		}
	}

	for (int i = 0; i < startingWorms; i++) {
		worms.add(new Worm());
	}
}