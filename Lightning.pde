Worm[] worms;

void setup() {
	worms = new Worm[50];
	size(1000, 1000);

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
	float x, y, direction, speed;
	color col;

	public Worm() {
		speed = 2.0;
		x = (float) Math.random() * width;
		y = (float) Math.random() * height;

		col = color((int) (Math.random() * 256), (int) (Math.random() * 256), (int) (Math.random() * 256));

		direction = (int) (Math.random() * 4) * HALF_PI;
	}

	public void step() {
		speed = 30.0 / dist(x, y, mouseX, mouseY);

		float lastX, lastY;
		lastX = x;
		lastY = y;
		x += speed * Math.cos(direction);
		y += speed * Math.sin(direction);

		stroke(col);
		line(lastX, lastY, x, y);

		if (Math.random() > 0.9) {
			direction += Math.random() > 0.5 ? HALF_PI : -HALF_PI;
		}
	}
}