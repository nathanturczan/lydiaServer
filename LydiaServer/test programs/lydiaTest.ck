OscOut out;
("localhost", 50000) => out.dest;

// lydiaSpin MIDI notes
[60, 61, 62, 63, 64, 65, 66, 67, 68, 69,
70, 71, 72, 73, 74, 75, 76, 77, 78, 79] @=> int lydiaSpinScl[];

fun void lydiaSpinSend(int note, int vel){
    out.start("/lydiaSpin");
    out.add(note);
    out.add(vel);
    out.send();
}

fun void lydiaSpinPlay(int note, int vel, int msDelay){
    lydiaSpinSend(note, vel);
    msDelay::ms => now;
    lydiaSpinSend(note, 0);
}

// lydiaBeat MIDI notes
[60, 61, 62, 63, 64, 65, 66, 67, 68, 69,
70, 71, 72, 73, 74, 75, 76, 77, 78, 79] @=> int lydiaBeatScl[];

fun void lydiaBeatSend(int note, int vel){
    out.start("/lydiaBeat");
    out.add(note);
    out.add(vel);
    out.send();
}

fun void lydiaBeatPlay(int note, int vel, int msDelay){
    lydiaBeatSend(note, vel);
    msDelay::ms => now;
    lydiaBeatSend(note, 0);
}

fun void smoothSaw() {
    // will play the saw for 5 seconds
    for (int i; i < 50; i++){
        lydiaSpinPlay(lydiaSpinScl[19], 127, 100);
    }
}

fun void testSpinners(int speed) {
    <<<"Playing all spinners">>>;
    // lydiaSpin test
    // They are not really 'tuned' but the
    // lower the note the lower pitch 
    for(0 => int i; i<lydiaSpinScl.size(); i++){
        100 => int vel;
        spork ~ lydiaSpinPlay(lydiaSpinScl[i], vel, 1000);
        speed::ms => now;
    }      
}

fun void testBeaters(int speed) {
    <<<"Playing all beaters">>>;
    // lydiaBeat test
    // 60 (0)  is the backboard beater
    // 79 (19) is the woodblock beater
    // 61 - 68 are notes 
    
    // C, G, B, C, F#, G, B, C, E, F, G,  B,  C,  E,  G,  C,  G,  C
    // 1, 2, 3, 4, 5,  6, 7, 8, 9, 10 11, 12, 13, 14, 15, 16, 17, 18
    for(0 => int i; i<lydiaBeatScl.size(); i++){
        100 => int vel;
        lydiaBeatPlay(lydiaBeatScl[i], vel, speed);
    }    
}

fun void machineGunBeater() {
    <<<"Machine gun Beater">>>;
    for (2 => int i; i < 55; i++){
        for (int t; t < 4; t++) {
            lydiaBeatPlay(lydiaBeatScl[0], i, 50);
        }
    }   
}

// main loop
while(true) {
    testSpinners(200);
    testBeaters(100);
    smoothSaw();
    machineGunBeater();
    2::second => now;
}
