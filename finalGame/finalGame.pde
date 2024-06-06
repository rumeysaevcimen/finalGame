PImage wall, wall1_1, wall2_1, wall3_1;
PImage character1, character2, character3;
PImage heartIcon;
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
float jump = -19;
float velocityY = 0;
float velocityX = 0;
float moveSpeed = 5;
boolean onGround = true;
boolean upPressed = false;

int livesCollected = 0;
int livesRemaining = 1; 

ArrayList<Live>[][] lives;
ArrayList<ArrayList<ArrayList<float[]>>> characterPlatforms;
ArrayList<ArrayList<ArrayList<float[]>>> gameOverZones;

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
  heartIcon = loadImage("heart.png");

  character1.resize(150, 150);
  character2.resize(200, 200);
  character3.resize(110, 110);
  heartIcon.resize(40, 40);
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
  character1Scene1.add(new float[]{790, 413, 0, 20});
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
  character3Scene0.add(new float[]{270, 320, 200, 20});
  character3Scene0.add(new float[]{498, 223, 200, 20});
  character3Scene0.add(new float[]{755, 286, 200, 20});
  character3Platforms.add(character3Scene0);

  ArrayList<float[]> character3Scene1 = new ArrayList<float[]>();
  character3Scene1.add(new float[]{125, 260, 150, 20});
  character3Scene1.add(new float[]{357, 330, 150, 20});
  character3Scene1.add(new float[]{510, 186, 150, 20});
  character3Scene1.add(new float[]{739, 260, 150, 20});
  character3Platforms.add(character3Scene1);

  ArrayList<float[]> character3Scene2 = new ArrayList<float[]>();
  character3Scene2.add(new float[]{94, 308, 200, 20});
  character3Scene2.add(new float[]{278, 239, 200, 20});
  character3Scene2.add(new float[]{505, 185, 200, 20});
  character3Scene2.add(new float[]{692, 130, 100, 20});
  character3Scene2.add(new float[]{858, 210, 100, 20});
  character3Platforms.add(character3Scene2);

  characterPlatforms.add(character3Platforms);

  // game over durumları
  gameOverZones = new ArrayList<ArrayList<ArrayList<float[]>>>();

  ArrayList<ArrayList<float[]>> character1GameOverZones = new ArrayList<ArrayList<float[]>>();
  ArrayList<float[]> character1GameOverScene0 = new ArrayList<float[]>();
  character1GameOverScene0.add(new float[]{230, 415, 0, 20});
  character1GameOverScene0.add(new float[]{747, 415, 0, 20});
  character1GameOverZones.add(character1GameOverScene0);

  ArrayList<float[]> character1GameOverScene1 = new ArrayList<float[]>();
  character1GameOverScene1.add(new float[]{500, 490, 30, 20}); // Example zone
  character1GameOverZones.add(character1GameOverScene1);

  ArrayList<float[]> character1GameOverScene2 = new ArrayList<float[]>();
  character1GameOverScene2.add(new float[]{195, 130, 0, 0}); 
  character1GameOverScene2.add(new float[]{418, 430, 0, 0}); 
  character1GameOverScene2.add(new float[]{634, 438, 0, 0});
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
  character2GameOverScene1.add(new float[]{0, 0, 1000, 20}); // Example zone
  character2GameOverZones.add(character2GameOverScene1);

  ArrayList<float[]> character2GameOverScene2 = new ArrayList<float[]>();
  character2GameOverScene2.add(new float[]{0, 0, 1000, 20}); // Example zone
  character2GameOverZones.add(character2GameOverScene2);

  gameOverZones.add(character2GameOverZones);

  ArrayList<ArrayList<float[]>> character3GameOverZones = new ArrayList<ArrayList<float[]>>();
  ArrayList<float[]> character3GameOverScene0 = new ArrayList<float[]>();
  character3GameOverScene0.add(new float[]{0, 0, 1000, 20}); // Example zone
  character3GameOverZones.add(character3GameOverScene0);

  ArrayList<float[]> character3GameOverScene1 = new ArrayList<float[]>();
  character3GameOverScene1.add(new float[]{0, 0, 1000, 20}); // Example zone
  character3GameOverZones.add(character3GameOverScene1);

  ArrayList<float[]> character3GameOverScene2 = new ArrayList<float[]>();
  character3GameOverScene2.add(new float[]{0, 0, 1000, 20}); // Example zone
  character3GameOverZones.add(character3GameOverScene2);

  gameOverZones.add(character3GameOverZones);
  //resetCharacterPosition();
}

void resetCharacterPosition() {
  characterX = 50;
  characterY = height / 2;
  velocityX = 0;
  velocityY = 0;
  onGround = true;
}

void displayCharacterSelection() {
  image(wall, 0, 0, width, height);

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

  fill(#3E0B0C);
  textSize(22); 
  textAlign(LEFT, TOP);
  text("LIVES: " + livesRemaining, 15, 15);
  textSize(12);

  if (characterX + characterWidth >= width) {
    currentScene++;
    if (currentScene >= backgrounds[characterIndex].length) {
      currentScene = 0;
    }
    characterX = 0;
  }
}


void displayLives() {
  for (Live live : lives[selectedCharacter - 1][currentScene]) {
    if (!live.collected) {
      image(heartIcon, live.x, live.y);
    }
  }
}

void checkLiveCollision() {
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
  int characterIndex = selectedCharacter - 1;
  ArrayList<float[]> currentGameOverZones = gameOverZones.get(characterIndex).get(currentScene);
  
  for (float[] zone : currentGameOverZones) {
    if (characterX + characterWidth > zone[0] && characterX < zone[0] + zone[2] &&
        characterY + characterHeight > zone[1] && characterY < zone[1] + zone[3]) {
      reduceLife();
      if (livesRemaining > 0) {
        characterX = characterX - 70;
      }
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
    checkLiveCollision();
    checkPlatformCollision();
    checkGameOverZoneCollision(); // Check for game over zones collision
    displayLives();
    checkGameOver(); // Can sayısını kontrol et
  }
}

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

void reduceLife() {
  livesRemaining--;
  if (livesRemaining < 0) {
    livesRemaining = 0;
  } else {
    //resetCharacterPosition(); // Karakter pozisyonunu sıfırla
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

class Live {
  float x, y;
  boolean collected;

  Live(float x, float y) {
    this.x = x;
    this.y = y;
    this.collected = false;
  }
}
