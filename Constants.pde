//NOTE: SCALE IS  ¯\_(ツ)_/¯

//Constants
int BLUE = 0;
int RED = 1;

//Fuel constants
float FUEL_RADIUS = 2.5;
float DRAG_FUEL = -0.1;
float GRAVITY = -9.8;

//Gear constants
float GEAR_RADIUS = 5.5;
float DRAG_GEAR = -0.5;

//Timestep
float DT = 0.02;

//Field dimensions
int FIELD_LENGTH = 648;
int FIELD_WIDTH = 324;
int PERIMETER_WIDTH = 4;

//Center of the field
float centerX = 640;
float centerY = 320;

//Airship locations
float hexTopY = 255;
float hexTopMidY = 290;
float hexBotMidY = 357;
float hexBotY = 395;

float hexLL = 287;
float hexLM = 345;
float hexLR = 404;

float hexRL = 877;
float hexRM = 935;
float hexRR = 994;

//Field wall locations

//Top/Bottom wall points
float twY = 52;
float twlX = 225;
float twrX = 1055;
float bwY = 589;
float bwlX = 163;
float bwrX = 1116;

//Side wall points
float lwX = 98;
float swtY = 119;
float swbY = 523;
float rwX = 1182;

//Boilers
float boilerHeight = 588;
float rBoiler = 1176;
float lBoiler = 103;


//Colors
color fuelColor = color(230, 252, 30);
color gearColor = color(255, 208, 0);
color firstRed = color(237, 28, 36);
color firstBlue = color(0, 101, 179);
color carpetGreen = color(23, 61, 26);