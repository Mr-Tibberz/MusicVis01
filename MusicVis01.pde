import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer player;
AudioInput input;
BeatDetect beat;

float size;
float colors = 255;
float rotation = .1;

void setup() {
  size(800, 500);
  background(0);

  minim = new Minim(this);

  player = minim.loadFile("GangnamStyle.mp3");//song here
  player.play();
  player.loop();

  input = minim.getLineIn(Minim.STEREO, int(1024));

  beat = new BeatDetect(input.bufferSize(), input.sampleRate());
}

void draw() {
  
  pushMatrix();
  
 // rotate(rotation += .1);
  translate(width/2, height/2);
  fill(0,0,0, 30);
  noStroke();

  rect(-width/2, -height/2, 800, 500);


  beat.detectMode(BeatDetect.FREQ_ENERGY);
  beat.detect(input.mix);
  if (beat.isKick()) {
    size *= .6;
    colors *= .2;
    fill(random(0, 255), random(0, 255), random(0, 255));
    ellipse(random(-width/2, width/2), random(-height/2, height/2), 20, 20);
  }
  if (beat.isSnare()) {
    size *= .6;
    colors *= .2;
    fill(random(0, 255), random(0, 255), random(0, 255));
    ellipse(random(0, 800), random(0, 500), 20, 20);
  }
  if (beat.isHat()) {
    size *= .6;
    colors *= .2;
    fill(random(0, 255), random(0, 255), random(0, 255));
     ellipse(random(0, 800), random(0, 500), 20, 20);
  }
  if(colors <= 150) colors = 150;
  fill(colors, 0, 0);
  
  if (size <= 20) size = 20;
  ellipse(0, 0, size, size);
  colors *= 1.1;
  size *= 1.05;
  if (size >= 100) size = 100;
  
  popMatrix();
}


void stop() {
  player.close();
  input.close();
  minim.stop();
  super.stop();
}

