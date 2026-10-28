Table table;
String[] days = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday"};

void setup() {
  size(900, 650);
  table = loadTable("daydreams.csv", "header");
  println("Rows loaded: " + table.getRowCount());
  noStroke();
}

void draw() {
  background(20);
  int[] counts = new int[5];   // how many circles so far for each day

  for (TableRow row : table.rows()) {
    int d = dayIndex(row.getString("day"));
    if (d == -1) continue;     // skip anything that isn't Mon-Fri

    float mins = row.getFloat("duration");
    float x = map(d, 0, 4, 120, width - 120);
    float y = height - 40 - counts[d] * 28;
    counts[d]++;

    fill(lessonColor(row.getString("lesson_type")));
    ellipse(x, y, sizeFor(mins), sizeFor(mins));
  }
}

// Methods that return a value
int dayIndex(String day) {
  for (int i = 0; i < days.length; i++) {
    if (days[i].equals(day)) {
      return i;
    }
  }
  return -1;
}

float sizeFor(float minutes) {
  return 8 + minutes * 1.5;
}

color lessonColor(String type) {
  if (type.equals("Lecture")) return color(255, 180, 80, 200);
  if (type.equals("Seminar")) return color(100, 180, 255, 200);
  return color(120, 220, 150, 200);   // Online
}
