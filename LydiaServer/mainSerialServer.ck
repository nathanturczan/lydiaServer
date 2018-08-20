// ======================================================================
// Main Serial Server
// By Eric Heep
// Music Technology: Interaction, Intelligence & Design, 2018
// File: mainSerialServer.ck
// ======================================================================

// give it some time to breathe
handshakeID talk;
0.5::second => now;

// initial handshake between ChucK and Arduinos
talk.talk.init();
1::second => now;
<<<"-----------------">>>;
<<< "Handshakes done" >>>;
<<<"-----------------">>>;
// bring on the bots
lydiaBeat lydiabeat_;
lydiaSpin lydiaspin_;
4::second => now;
<<<"-----------------">>>;

while (true) {
    1::second => now;
}
