PImage wall, wall1_1, wall2_1, wall2_2;
PImage character1, character2, character3;
int selectedCharacter = 0;
boolean characterSelected = false;
boolean gameStarted = false;

float characterX = 50;
float characterY;
float characterWidth;
float characterHeight;
float gravity = 0.6;
float jump = -15;
float velocityY = 0;
float velocityX = 0;
float moveSpeed = 5;
boolean onGround = true;
boolean upPressed = false;

int coinsCollected = 0;

ArrayList<Platform> platforms;
ArrayList<Coin> coins;

void setup() {
  size(1000, 550);
  wall = loadImage("wall0.png");
  
  // Yeni duvar resimlerini yükleyin
  wall1_1 = loadImage("wall1.1.png");
  wall2_1 = loadImage("wall2.1.png");
  wall2_2 = loadImage("wall2.2.png");

  // Karakter resimlerini yükleyin
  character1 = loadImage("character1.png");
  character2 = loadImage("character2.png");
  character3 = loadImage("character3.png");

  // Karakter resimlerinin boyutlarını ayarlayın
  character1.resize(200, 200);
  character2.resize(200, 200);
  character3.resize(130, 130);
  
  // Başlangıç karakter yüksekliği
  characterY = height / 2;
  
  // Platformları tanımla
  platforms = new ArrayList<Platform>();
  platforms.add(new Platform(200, 400, 200, 20));
  platforms.add(new Platform(500, 300, 200, 20));
  platforms.add(new Platform(800, 200, 200, 20));
  
  // Coinleri tanımla
  coins = new ArrayList<Coin>();
  coins.add(new Coin(250, 370, 30));
  coins.add(new Coin(550, 270, 30));
  coins.add(new Coin(850, 170, 30));
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
    displayPlatforms();
    displayCoins();
  }
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
  if (selectedCharacter == 1) {
    image(wall1_1, 0, 0, width, height); // Duvar resmi wall1_1 tam ekran
    image(character1, characterX, characterY); // Seçilen karakteri hareket ettir
    characterWidth = character1.width;
    characterHeight = character1.height;
  } else if (selectedCharacter == 2) {
    image(wall2_1, 0, 0, width, height); // Duvar resmi wall2_1 tam ekran
    image(character2, characterX, characterY); // Seçilen karakteri hareket ettir
    characterWidth = character2.width;
    characterHeight = character2.height;
  } else if (selectedCharacter == 3) {
    image(wall2_2, 0, 0, width, height); // Duvar resmi wall2_2 tam ekran
    image(character3, characterX, characterY); // Seçilen karakteri hareket ettir
    characterWidth = character3.width;
    characterHeight = character3.height;
  }
  
  // Coin sayısını ekrana yazdır
  fill(255);
  textAlign(LEFT, TOP);
  text("Coins: " + coinsCollected, 10, 10);
}

void displayPlatforms() {
  fill(139, 69, 19);
  for (Platform platform : platforms) {
    rect(platform.x, platform.y, platform.width, platform.height);
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
  for (Platform platform : platforms) {
    if (characterX + characterWidth > platform.x && characterX < platform.x + platform.width &&
        characterY + characterHeight >= platform.y && characterY + characterHeight - velocityY <= platform.y &&
        velocityY >= 0) {
      characterY = platform.y - characterHeight; // Karakterin platforma tam oturmasını sağlamak için
      velocityY = 0;
      onGround = true;
    }
  }
}

void mousePressed() {
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
