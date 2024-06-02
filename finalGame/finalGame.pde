PImage wall, character1, character2, character3;
int selectedCharacter = 0;
boolean characterSelected = false;
boolean gameStarted = false;

void setup() {
  size(1000, 550);
  wall = loadImage("wall0.png");

  // Karakter resimlerini yükleyin
  character1 = loadImage("character1.png");
  character2 = loadImage("character2.png");
  character3 = loadImage("character3.png");

  // Karakter resimlerinin boyutlarını ayarlayın
  character1.resize(200, 200);
  character2.resize(200, 200);
  character3.resize(130, 130);
}

void draw() {
  if (!gameStarted) {
    displayCharacterSelection();
  } else {
    displayGameScene();
  }
}

void displayCharacterSelection() {
  image(wall, 0, 0, width, height);

  // Seçilen karakterin üzerine "Selected" yazısı ekle
  if (selectedCharacter == 1) {
    fill(255);
    textAlign(CENTER, CENTER);
    text("SELECTED", width/4, height/2 - character1.height/2 - 20);
  } else if (selectedCharacter == 2) {
    fill(255);
    textAlign(CENTER, CENTER);
    text("SELECTED", width/2, height/2 - character2.height/2 - 20);
  } else if (selectedCharacter == 3) {
    fill(255);
    textAlign(CENTER, CENTER);
    text("SELECTED", 3*width/4, height/2 - character3.height/2 - 20);
  }
}

void displayGameScene() {
  image(wall, 0, 0, width, height); // Arka plan duvarı tekrar çiz
  if (selectedCharacter == 1) {
    fill(255, 0, 0); // Kırmızı arka plan
    rect(0, 0, width, height);
    image(character1, 50, height/2 - character1.height/2); // Seçilen karakteri sol tarafta göster
  } else if (selectedCharacter == 2) {
    fill(0, 255, 0); // Yeşil arka plan
    rect(0, 0, width, height);
    image(character2, 50, height/2 - character2.height/2); // Seçilen karakteri sol tarafta göster
  } else if (selectedCharacter == 3) {
    fill(0, 0, 255); // Mavi arka plan
    rect(0, 0, width, height);
    image(character3, 50, height/2 - character3.height/2); // Seçilen karakteri sol tarafta göster
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