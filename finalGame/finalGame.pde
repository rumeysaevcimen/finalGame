PImage wall, wall1_1, wall2_1, wall3_1;
PImage character1, character2, character3;
PImage[][] backgrounds;
int currentScene = 0;
int selectedCharacter = 0;
boolean characterSelected = false;
boolean gameStarted = false;

float characterX = 50;
float characterY;
float characterWidth;
float characterHeight;
float gravity = 0.6;
float jump = -16;
float velocityY = 0;
float velocityX = 0;
float moveSpeed = 5;
boolean onGround = true;
boolean upPressed = false;

int coinsCollected = 0;

ArrayList<Coin> coins;

// Her karakter ve sahne için platform koordinatları
float[][][] characterPlatforms;

void setup() {
  size(1000, 550);
  wall = loadImage("wall0.png");

  wall1_1 = loadImage("wall1.1.png");
  PImage wall1_2 = loadImage("wall1.2.png");
  PImage wall1_3 = loadImage("wall1.3.png");

  wall2_1 = loadImage("wall2.1.png");
  PImage wall2_2 = loadImage("wall2.2.png");
  PImage wall2_3 = loadImage("wall2.3.png");

  wall3_1 = loadImage("wall3.1.png");
  PImage wall3_2 = loadImage("wall3.2.png");
  PImage wall3_3 = loadImage("wall3.3.png");

  backgrounds = new PImage[][]{
    {wall1_1, wall1_2, wall1_3},
    {wall2_1, wall2_2, wall2_3},
    {wall3_1, wall3_2, wall3_3}
  };

  character1 = loadImage("c1move.png");
  character2 = loadImage("character2.png");
  character3 = loadImage("character3.png");

  character1.resize(150, 150);
  character2.resize(200, 200);
  character3.resize(130, 130);
  characterY = height / 2;

  // Coinleri tanımla
  coins = new ArrayList<Coin>();
  coins.add(new Coin(250, 370, 30));
  coins.add(new Coin(550, 270, 30));
  coins.add(new Coin(850, 170, 30));

  // Her karakter ve sahne için platform koordinatlarını tanımlayın
  characterPlatforms = new float[][][] {
    { // Karakter 1'in sahneleri
      {226, 300, 30, 20}, {498, 235, 20, 20}, {700, 300, 80, 20}, // Sahne 0
      {260, 413, 150, 20}, {513, 229, 90, 20}, {790, 413, 150, 20}, // Sahne 1
      {90, 500, 200, 20}, {90, 500, 200, 20}, {90, 500, 200, 20}  // Sahne 2
    },
    { // Karakter 2'nin sahneleri
      {130, 402, 0, 0}, {498, 402, 0, 0}, {755, 402, 0, 0}, // Sahne 0
      {257, 402, 0, 0}, {257, 402, 0, 0}, {257, 402, 0, 0}, // Sahne 1
      {100, 402, 0, 0}, {100, 402, 0, 0}, {100, 402, 0, 0}  // Sahne 2
    },
    { // Karakter 3'ün sahneleri
      {226, 269, 200, 20}, {498, 223, 200, 20}, {755, 286, 200, 20}, // Sahne 0
      {257, 402, 150, 20}, {513, 216, 150, 20}, {786, 401, 150, 20}, // Sahne 1
      {100, 450, 200, 20}, {400, 350, 200, 20}, {700, 250, 200, 20}  // Sahne 2
    }
  };
}

void displayCharacterSelection() {
  image(wall, 0, 0, width, height);

  // Seçilen karakterin üzerine "Selected" yazısı ekle
  if (selectedCharacter == 1) {
    fill(255);
    textAlign(CENTER, CENTER);
    text("SELECTED", width / 4, height / 2 - character1.height / 2 - 20);
  } else if (selectedCharacter == 2) {
    fill(255);
    textAlign(CENTER, CENTER);
    text("SELECTED", width / 2, height / 2 - character2.height / 2 - 20);
  } else if (selectedCharacter == 3) {
    fill(255);
    textAlign(CENTER, CENTER);
    text("SELECTED", 3 * width / 4, height / 2 - character3.height / 2 - 20);
  }
}

void displayGameScene() {
  int characterIndex = selectedCharacter - 1;
  image(backgrounds[characterIndex][currentScene], 0, 0, width, height);

  if (selectedCharacter == 1) {
    image(character1, characterX, characterY);
    characterWidth = character1.width;
    characterHeight = character1.height;
  } else if (selectedCharacter == 2) {
    image(character2, characterX, characterY);
    characterWidth = character2.width;
    characterHeight = character2.height;
  } else if (selectedCharacter == 3) {
    image(character3, characterX, characterY);
    characterWidth = character3.width;
    characterHeight = character3.height;
  }

  fill(255);
  textAlign(LEFT, TOP);
  text("Coins: " + coinsCollected, 10, 10);

  // Sahne değişimi
  if (characterX + characterWidth >= width) {
    currentScene++;
    if (currentScene >= backgrounds[characterIndex].length) {
      currentScene = 0; // Eğer son sahneye gelindiyse tekrar başa döner.
    }
    characterX = 0; // Karakter başlangıç noktasına döner
  }
}

void displayCoins() {
  fill(255, 215, 0);
  for (Coin coin : coins) {
    if (!coin.collected) {
      ellipse(coin.x, coin.y, coin.size, coin.size);
    }
  }
}

void checkCoinCollision() {
  for (Coin coin : coins) {
    if (!coin.collected && 
        characterX < coin.x + coin.size / 2 && 
        characterX + characterWidth > coin.x - coin.size / 2 && 
        characterY < coin.y + coin.size / 2 && 
        characterY + characterHeight > coin.y - coin.size / 2) {
      coin.collected = true;
      coinsCollected++;
    }
  }
}

void checkPlatformCollision() {
  onGround = false;

  int characterIndex = selectedCharacter - 1;
  int platformStartIndex = currentScene * 3;
  
  for (int i = 0; i < 3; i++) {
    float[] platform = characterPlatforms[characterIndex][platformStartIndex + i];
    if (characterX + characterWidth > platform[0] && characterX < platform[0] + platform[2] &&
        characterY + characterHeight >= platform[1] && characterY + characterHeight - velocityY <= platform[1] &&
        velocityY >= 0) {
      characterY = platform[1] - characterHeight;
      velocityY = 0;
      onGround = true;
    }
  }
}

void draw() {
  if (!gameStarted) {
    displayCharacterSelection();
  } else {
    displayGameScene();
    applyGravity();
    checkGround();
    updateCharacterPosition();
    handleMovement();
    checkCoinCollision();
    checkPlatformCollision();
    displayCoins();
  }
}

void mousePressed() {
  println("Mouse tıklandı: (" + mouseX + ", " + mouseY + ")");
  if (!gameStarted) {
    // Karakter 1'in koordinatları (Örnek olarak)
    if (mouseX > 150 && mouseX < 350 && mouseY > 200 && mouseY < 400) {
      selectedCharacter = 1;
      characterSelected = true;
    }
    // Karakter 2'nin koordinatları (Örnek olarak)
    else if (mouseX > 400 && mouseX < 600 && mouseY > 200 && mouseY < 400) {
      selectedCharacter = 2;
      characterSelected = true;
    }
    // Karakter 3'ün koordinatları (Örnek olarak)
    else if (mouseX > 650 && mouseX < 780 && mouseY > 200 && mouseY < 400) {
      selectedCharacter = 3;
      characterSelected = true;
    }

    // Start butonunun koordinatları (Örnek olarak)
    if (characterSelected && mouseX > 450 && mouseX < 550 && mouseY > 450 && mouseY < 500) {
      gameStarted = true; // Start button clicked
    }
  }
}

void applyGravity() {
  if (!onGround) {
    velocityY += gravity;
  }
  characterY += velocityY;
}

void checkGround() {
  if (characterY + characterHeight >= height) {
    characterY = height - characterHeight;
    velocityY = 0;
    onGround = true;
  }
}

void updateCharacterPosition() {
  characterX += velocityX;

  // Kenarlara çarpmasını önleyin
  if (characterX < 0) {
    characterX = 0;
  } else if (characterX + characterWidth > width) {
    characterX = width - characterWidth;
  }
}

void handleMovement() {
  if (keyPressed) {
    if (key == CODED) {
      if (keyCode == LEFT) {
        velocityX = -moveSpeed;
      } else if (keyCode == RIGHT) {
        velocityX = moveSpeed;
      } else if (keyCode == UP && onGround && !upPressed) {
        velocityY = jump;
        onGround = false;
        upPressed = true;
      }
    }
  } else {
    velocityX = 0; // Tuş bırakıldığında yatay hareket durur
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) {
      upPressed = false;
    }
  }
}

class Platform {
  float x, y, width, height;

  Platform(float x, float y, float width, float height) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
  }
}

class Coin {
  float x, y, size;
  boolean collected;

  Coin(float x, float y, float size) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.collected = false;
  }
}
