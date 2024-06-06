PImage wall, wall1_1, wall2_1, wall3_1;
PImage character1, character2, character3;
PImage endScene; 
PImage heartIcon, dragon, crab, jellyfish, shark, diver, finish2, finish3;
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
float jump = -20;
float velocityY = 0;
float velocityX = 0;
float moveSpeed = 5;
boolean onGround = true;
boolean upPressed = false;

float dragonX = 200; 
float dragonY = 240; 
float dragonSpeed = 3; 

float crabX = 310;
float crabY = 450;
float crabSpeed = 2;

float jellyfishX = 600;
float jellyfishY = 450;
float jellyfishSpeed = 3;

float sharkX1 = 800; 
float sharkY1 = 200;

float sharkSpeed = 4; 

int livesCollected = 0;
int livesRemaining = 3; 

ArrayList<Live>[][] lives;
ArrayList<ArrayList<ArrayList<float[]>>> characterPlatforms;
ArrayList<ArrayList<ArrayList<float[]>>> gameOverZones;

void setup() {
  size(1000, 550);
  wall = loadImage("wall0.png");
  endScene = loadImage("endScene.png");
  
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
  dragon = loadImage("dragon.png");
  crab = loadImage("crab.png");
  jellyfish = loadImage("jellyfish.png");
  shark = loadImage("shark.png");
  diver = loadImage("diver.png");
  finish2 = loadImage("finish2.png");
  finish3 = loadImage("finish3.png");
  
  character1 = loadImage("c1move.png");
  character2 = loadImage("character2.png");
  character3 = loadImage("character3.png");
  heartIcon = loadImage("heart.png");

  character1.resize(140, 140);
  character2.resize(200, 200);
  character3.resize(110, 110);
  heartIcon.resize(40, 40);
  diver.resize(300, 300);
  dragon.resize(140, 140);
  crab.resize(100, 100);
  jellyfish.resize(90,90);
  shark.resize(160, 120);
  finish2.resize(200, 200);
  finish3.resize(110, 110);
  characterY = height / 2;

  lives = new ArrayList[backgrounds.length][];
  for (int i = 0; i < backgrounds.length; i++) {
    lives[i] = new ArrayList[backgrounds[i].length];
    for (int j = 0; j < backgrounds[i].length; j++) {
      lives[i][j] = new ArrayList<Live>();
    }
  }

  lives[0][0].add(new Live(225, 240));
  lives[0][0].add(new Live(483, 175));
  lives[0][0].add(new Live(740, 245));

  lives[0][1].add(new Live(500, 170));

  lives[0][2].add(new Live(290, 445));
  lives[0][2].add(new Live(515, 445));
  
  lives[1][0].add(new Live(296, 182));
  lives[1][0].add(new Live(682, 142));
  
  lives[1][1].add(new Live(645, 110));
  
  lives[1][2].add(new Live(273, 278));

  lives[2][0].add(new Live(290, 245));
  lives[2][0].add(new Live(778, 420));
  
  lives[2][1].add(new Live(570, 120));
  
  lives[2][2].add(new Live(321, 190));
  lives[2][2].add(new Live(730, 85));

  //karakterlerin bulunacağı konumların koordinatları
  
  characterPlatforms = new ArrayList<ArrayList<ArrayList<float[]>>>();

  ArrayList<ArrayList<float[]>> character1Platforms = new ArrayList<ArrayList<float[]>>();
  ArrayList<float[]> character1Scene0 = new ArrayList<float[]>();
  character1Scene0.add(new float[]{226, 300, 30, 20});
  character1Scene0.add(new float[]{498, 235, 20, 20});
  character1Scene0.add(new float[]{700, 300, 80, 20});
  character1Platforms.add(character1Scene0);

  ArrayList<float[]> character1Scene1 = new ArrayList<float[]>();
  character1Scene1.add(new float[]{260, 413, 0, 20});
  character1Scene1.add(new float[]{513, 229, 0, 20});
  character1Scene1.add(new float[]{735, 413, 0, 20});
  character1Platforms.add(character1Scene1);

  ArrayList<float[]> character1Scene2 = new ArrayList<float[]>();
  character1Scene2.add(new float[]{90, 500, 200, 20});
  character1Platforms.add(character1Scene2);

  characterPlatforms.add(character1Platforms);

  ArrayList<ArrayList<float[]>> character2Platforms = new ArrayList<ArrayList<float[]>>();
  ArrayList<float[]> character2Scene0 = new ArrayList<float[]>();
  character2Scene0.add(new float[]{130, 402, 0, 0});
  character2Scene0.add(new float[]{498, 402, 0, 0});
  character2Scene0.add(new float[]{755, 402, 0, 0});
  character2Platforms.add(character2Scene0);

  ArrayList<float[]> character2Scene1 = new ArrayList<float[]>();
  character2Scene1.add(new float[]{257, 402, 0, 0});
  character2Platforms.add(character2Scene1);

  ArrayList<float[]> character2Scene2 = new ArrayList<float[]>();
  character2Scene2.add(new float[]{100, 402, 0, 0});
  character2Platforms.add(character2Scene2);

  characterPlatforms.add(character2Platforms);

  ArrayList<ArrayList<float[]>> character3Platforms = new ArrayList<ArrayList<float[]>>();
  ArrayList<float[]> character3Scene0 = new ArrayList<float[]>();
  character3Scene0.add(new float[]{90, 410, 350, 0});
  character3Scene0.add(new float[]{270, 310, 0, 20});
  character3Scene0.add(new float[]{498, 223, 0, 20});
  character3Scene0.add(new float[]{755, 286, 0, 20});
  character3Scene0.add(new float[]{300, 510, 1000, 20});
  character3Platforms.add(character3Scene0);

  ArrayList<float[]> character3Scene1 = new ArrayList<float[]>();
  character3Scene1.add(new float[]{129, 255, 170, 20});
  character3Scene1.add(new float[]{357, 330, 100, 20});
  character3Scene1.add(new float[]{510, 186, 140, 20});
  character3Scene1.add(new float[]{739, 260, 180, 20});
  character3Platforms.add(character3Scene1);

  ArrayList<float[]> character3Scene2 = new ArrayList<float[]>();
  character3Scene2.add(new float[]{94, 308, 200, 20});
  character3Scene2.add(new float[]{278, 239, 200, 20});
  character3Scene2.add(new float[]{505, 185, 200, 20});
  character3Scene2.add(new float[]{692, 130, 100, 20});
  character3Scene2.add(new float[]{858, 210, 100, 20});
  character3Platforms.add(character3Scene2);

  characterPlatforms.add(character3Platforms);

  // karakterin can sayısını etkileyen durumlar
  
  gameOverZones = new ArrayList<ArrayList<ArrayList<float[]>>>();
  
  //karakter 1
  ArrayList<ArrayList<float[]>> character1GameOverZones = new ArrayList<ArrayList<float[]>>();
  ArrayList<float[]> character1GameOverScene0 = new ArrayList<float[]>();
  character1GameOverScene0.add(new float[]{230, 415, 0, 20});
  character1GameOverScene0.add(new float[]{747, 415, 0, 20});
  character1GameOverZones.add(character1GameOverScene0);

  ArrayList<float[]> character1GameOverScene1 = new ArrayList<float[]>();
  character1GameOverScene1.add(new float[]{500, 490, 30, 20});
  character1GameOverZones.add(character1GameOverScene1);

  ArrayList<float[]> character1GameOverScene2 = new ArrayList<float[]>();
  character1GameOverScene2.add(new float[]{195, 430, 0, 0}); 
  character1GameOverScene2.add(new float[]{400, 430, 0, 0}); 
  character1GameOverScene2.add(new float[]{615, 430, 0, 0});
  character1GameOverZones.add(character1GameOverScene2);

  gameOverZones.add(character1GameOverZones);
  
  //karakter 2
  ArrayList<ArrayList<float[]>> character2GameOverZones = new ArrayList<ArrayList<float[]>>();
  ArrayList<float[]> character2GameOverScene0 = new ArrayList<float[]>();
  character2GameOverScene0.add(new float[]{175, 140, 0, 0});
  character2GameOverScene0.add(new float[]{447, 140, 0, 0});
  character2GameOverScene0.add(new float[]{844, 140, 0, 0});
  character2GameOverZones.add(character2GameOverScene0);

  ArrayList<float[]> character2GameOverScene1 = new ArrayList<float[]>();
  character2GameOverScene1.add(new float[]{0, 0, 1000, 20}); 
  character2GameOverZones.add(character2GameOverScene1);

  ArrayList<float[]> character2GameOverScene2 = new ArrayList<float[]>();
  character2GameOverScene2.add(new float[]{0, 0, 1000, 20}); 
  character2GameOverZones.add(character2GameOverScene2);

  gameOverZones.add(character2GameOverZones);
  
  //karakter 3
  ArrayList<ArrayList<float[]>> character3GameOverZones = new ArrayList<ArrayList<float[]>>();
  ArrayList<float[]> character3GameOverScene0 = new ArrayList<float[]>();
  character3GameOverScene0.add(new float[]{410, 440, 0, 20}); 
  character3GameOverZones.add(character3GameOverScene0);

  ArrayList<float[]> character3GameOverScene1 = new ArrayList<float[]>();
  //character3GameOverScene1.add(new float[]{120, 250, 0, 20}); 
  character3GameOverZones.add(character3GameOverScene1);

  ArrayList<float[]> character3GameOverScene2 = new ArrayList<float[]>();
  //character3GameOverScene2.add(new float[]{0, 0, 0, 20}); 
  character3GameOverZones.add(character3GameOverScene2);

  gameOverZones.add(character3GameOverZones);
}

void resetCharacterPosition() {
  characterX = 50;
  characterY = height / 2;
  velocityX = 0;
  velocityY = 0;
  onGround = true;
}

//karakter seçimi ilk sahne
void displayCharacterSelection() {
  image(wall, 0, 0, width, height);

  textSize(24); 
  fill(255, 0, 0); 

  if (selectedCharacter == 1) {
    textAlign(CENTER, CENTER);
    text("SELECTED", width / 4, height / 2 - character1.height / 2 - 20);
  } else if (selectedCharacter == 2) {
    textAlign(CENTER, CENTER);
    text("SELECTED", width / 2, height / 2 - character2.height / 2 - 20);
  } else if (selectedCharacter == 3) {
    textAlign(CENTER, CENTER);
    text("SELECTED", 3 * width / 4, height / 2 - character3.height / 2 - 20);
  }
}

//oyundaki sahnelerin yönetildiği fonksiyon
void displayGameScene() {
  int characterIndex = selectedCharacter - 1;

  if (currentScene >= backgrounds[characterIndex].length) {
    image(endScene, 0, 0, width, height);
    fill(255);
    noLoop();
    return;
  }

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
  if (currentScene == 2 && selectedCharacter == 2) {
  image(diver, 470, 5); 
  image(finish2, 830, 335);
}
  if (currentScene == 2 && selectedCharacter == 3) {
  image(finish3, 900, 110); 
}
  fill(#3E0B0C);
  textSize(22); 
  textAlign(LEFT, TOP);
  text("LIVES: " + livesRemaining, 15, 15);
  textSize(12);

  if (characterX + characterWidth >= width) {
    currentScene++;
    if (currentScene >= backgrounds[characterIndex].length) {
      currentScene = backgrounds[characterIndex].length; 
    }
    characterX = 0;
  }
}

void displayLives() {
  if (currentScene >= backgrounds[selectedCharacter - 1].length) return;

  for (Live live : lives[selectedCharacter - 1][currentScene]) {
    if (!live.collected) {
      image(heartIcon, live.x, live.y);
    }
  }
}

void checkLiveCollision() {
  if (currentScene >= backgrounds[selectedCharacter - 1].length) return;

  for (Live live : lives[selectedCharacter - 1][currentScene]) {
    if (!live.collected && 
        characterX < live.x + heartIcon.width / 2 && 
        characterX + characterWidth > live.x - heartIcon.width / 2 && 
        characterY < live.y + heartIcon.height / 2 && 
        characterY + characterHeight > live.y - heartIcon.height / 2) {
      live.collected = true;
      livesCollected++;
      increaseLife(); // Can toplandığında can sayısını artır
    }
  }
}

void increaseLife() {
  livesRemaining++; // Can sayısını artır
}

void checkPlatformCollision() {
  if (currentScene >= backgrounds[selectedCharacter - 1].length) return;

  onGround = false;

  int characterIndex = selectedCharacter - 1;
  ArrayList<float[]> currentPlatforms = characterPlatforms.get(characterIndex).get(currentScene);
  
  for (float[] platform : currentPlatforms) {
    if (characterX + characterWidth > platform[0] && characterX < platform[0] + platform[2] &&
        characterY + characterHeight >= platform[1] && characterY + characterHeight - velocityY <= platform[1] &&
        velocityY >= 0) {
      characterY = platform[1] - characterHeight;
      velocityY = 0;
      onGround = true;
    }
  }
}

//can sayısı 0 olduğunda Game Over yazısının görünmesi
void checkGameOver() {
  if (livesRemaining <= 0) {
    fill(255, 0, 0);
    textSize(64);
    textAlign(CENTER, CENTER);
    text("GAME OVER", width / 2, height / 2);
    noLoop();
  }
}

void checkGameOverZoneCollision() {
  if (currentScene >= backgrounds[selectedCharacter - 1].length) return;

  int characterIndex = selectedCharacter - 1;
  ArrayList<float[]> currentGameOverZones = gameOverZones.get(characterIndex).get(currentScene);
  
  for (float[] zone : currentGameOverZones) {
    if (characterX + characterWidth > zone[0] && characterX < zone[0] + zone[2] &&
        characterY + characterHeight > zone[1] && characterY < zone[1] + zone[3]) {
      reduceLife();
      if (livesRemaining > 0) {
        characterX = characterX - 70; // Can azaldığında karakterin pozisyonunu geriye al
      }
    }
  }

  // Karakter 2 nin crab ve jellyfish ile teması
  if (currentScene == 0 && selectedCharacter == 2) {
    // crab ile temas kontrolü
    if (characterX + characterWidth > crabX && characterX < crabX + crab.width &&
        characterY + characterHeight > crabY && characterY < crabY + crab.height) {
      reduceLife();
    }
    // jellyfish ile temas kontrolü
    if (characterX + characterWidth > jellyfishX && characterX < jellyfishX + jellyfish.width &&
        characterY + characterHeight > jellyfishY && characterY < jellyfishY + jellyfish.height) {
      reduceLife();
    }
  }
}

// karakter 1 in ejderha ile teması
void displayDragon() {
  // Karakterle çarpışma kontrolü
  if (currentScene == 1 && selectedCharacter == 1) { 
    image(dragon, dragonX, dragonY); // Dragon nesnesini ekrana göster
  }
}

void moveDragon() {
  // Karakterle çarpışma kontrolü
  if (currentScene == 1 && selectedCharacter == 1) { 
    // Dragon'un hareketini güncelle
    dragonX += dragonSpeed;

    // Dragon ekranın sağ veya sol kenarına ulaştığında yönünü değiştir
    if (dragonX <= 0 || dragonX + dragon.width >= width) {
      dragonSpeed *= -1;
    }

    // Karakterle çarpışma kontrolü
    if (characterX < dragonX + dragon.width && 
        characterX + characterWidth > dragonX && 
        characterY < dragonY + dragon.height && 
        characterY + characterHeight > dragonY) {
      // Karakterle çarpışma olduğunda can sayısını azalt
      reduceLife();
      // Karakterin ölmemesi için karakterin pozisyonunu sıfırla veya başka bir işlem yap
      resetCharacterPosition();
    }
  }
}

void moveCrab() {
  // Crab'ın hareketini güncelle
  crabY += crabSpeed;

  // Yörüngenin üst veya alt sınırına ulaşıldığında, hareketi tersine çevir
  if (crabY <= 150 || crabY + crab.width >= width) {
    crabSpeed *= -1;
  }
}

void moveJellyfish() {
  // Jellyfish'in hareketini güncelle
  jellyfishY += jellyfishSpeed;

  // Yörüngenin alt sınırına veya üst sınırına ulaşıldığında, hızı tersine çevir
  if (jellyfishY <= 150 || jellyfishY + jellyfish.width >= width) {
    jellyfishSpeed *= -1;
  }
}

void displayCrabAndJellyfish() {
  // Sadece hareketli olan crab ve jellyfish'i görüntüle
  if (currentScene == 0 && selectedCharacter == 2) {
    // crab resmini çiz
    image(crab, crabX, crabY);
    // jellyfish resmini çiz
    image(jellyfish, jellyfishX, jellyfishY);
  }
}

//köpekbalığı kontrolü

void moveSharks() {
  if (currentScene == 2 && selectedCharacter == 2) { 
    sharkX1 -= sharkSpeed; 

    // Sahnenin sınırlarına ulaştığında geri dön
    if (sharkX1 <= 0 || sharkX1 + shark.width >= width) {
      sharkSpeed *= -1; 
    }

    // Karakterle çarpışma kontrolü
    if (characterX < sharkX1 + shark.width && 
        characterX + characterWidth > sharkX1 && 
        characterY < sharkY1 + shark.height && 
        characterY + characterHeight > sharkY1) {
      // Karakterle çarpışma olduğunda can sayısını azalt
      reduceLife();
      // Karakterin ölmemesi için karakterin pozisyonunu sıfırla veya başka bir işlem yap
      resetCharacterPosition();
    }
  }
}

void displaySharks() {
  if (currentScene == 2 && selectedCharacter == 2) {
    // İlk köpek balığı resmini çiz
    image(shark, sharkX1, sharkY1);
  }
}

//hareket fonksiyonlarının ve diğer eylemlerin tanımlandığı draw fonksiyonu

void draw() {
  if (!gameStarted) {
    displayCharacterSelection();
  } else {
    if (currentScene >= backgrounds[selectedCharacter - 1].length) {
      displayGameScene(); // Handle the end scene
    } else {
      displayGameScene();
      applyGravity();
      checkGround();
      updateCharacterPosition();
      handleMovement();
      checkLiveCollision();
      checkPlatformCollision();
      checkGameOverZoneCollision(); 
      displayLives();
      checkGameOver(); 
      displayDragon();
      moveDragon();
      moveCrab(); // Crab hareket
      moveJellyfish(); // Jellyfish hareket 
      displayCrabAndJellyfish();
      moveSharks(); // Köpek balığı hareket 
      displaySharks();
    }
  }
}

//oyun içindeki eylemleri şekillendiren mouse işlemleri

void mousePressed() {
  println("Mouse tıklandı: (" + mouseX + ", " + mouseY + ")");
  if (!gameStarted) {
    if (mouseX > 150 && mouseX < 350 && mouseY > 200 && mouseY < 400) {
      selectedCharacter = 1;
      characterSelected = true;
    } else if (mouseX > 400 && mouseX < 600 && mouseY > 200 && mouseY < 400) {
      selectedCharacter = 2;
      characterSelected = true;
    } else if (mouseX > 650 && mouseX < 780 && mouseY > 200 && mouseY < 400) {
      selectedCharacter = 3;
      characterSelected = true;
    }

    if (characterSelected && mouseX > 450 && mouseX < 550 && mouseY > 450 && mouseY < 500) {
      gameStarted = true;
    }
  } else {
    if (currentScene >= backgrounds[selectedCharacter - 1].length) {
      // EndScene'de tıklama işlemi
      if (mouseX > 370 && mouseX < 610 && mouseY > 320 && mouseY < 370) {
        currentScene = 0; 
        resetCharacterPosition(); // Karakterin pozisyonunu sıfırla
        loop(); // Loop'u tekrar başlat
      }
    }
  }
}

//yerçekimi(gravity) ve hız(velocity) kontrolü
void applyGravity() {
  if (!onGround) {
    velocityY += gravity;
  }
  characterY += velocityY;
}

//zemin sınırı kontrolü
void checkGround() {
  if (characterY + characterHeight >= height) {
    characterY = height - characterHeight;
    velocityY = 0;
    onGround = true;
  }
}

void updateCharacterPosition() {
  characterX += velocityX;

  if (characterX < 0) {
    characterX = 0;
  } else if (characterX + characterWidth > width) {
    characterX = width - characterWidth;
  }
}

//key hareketleri
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
    velocityX = 0;
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) {
      upPressed = false;
    }
  }
}

//can sayısı azalması işlemi
void reduceLife() {
  livesRemaining--;
  if (livesRemaining < 0) {
    livesRemaining = 0;
  }
}

//sahne içindeki platformlar için tanımlanan class
class Platform {
  float x, y, width, height;

  Platform(float x, float y, float width, float height) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
  }
}

//can sayısı için tanımlanan class
class Live {
  float x, y;
  boolean collected;

  Live(float x, float y) {
    this.x = x;
    this.y = y;
    this.collected = false;
  }
}
