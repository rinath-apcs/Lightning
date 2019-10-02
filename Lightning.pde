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
    		for (int i = 0; i < (int) keyCounter; i++)  {
    			worms.add(new Worm());
    		}
    	}
    	
    	keyCounter += 0.25;
    } else {
    	keyCounter = 0;
    }

    if (showCoords) 
    	drawCoords();
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

	for (int i = 0; i < startingWorms; i++) {
		worms.add(new Worm());
	}
}