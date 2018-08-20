// ======================================================================
// Lydia Robot Server
// By Ajay Kapur, Nathan Turczan & McLean Macionis
// Music Technology: Interaction, Intelligence & Design, 2018
// File: initialize.ck
// ======================================================================

// Add communication classes
Machine.add(me.dir() + "classes/handshake.ck");
Machine.add(me.dir() + "classes/handshakeID.ck");
Machine.add(me.dir() + "classes/serialBot.ck");

// Add class files for each robot
Machine.add(me.dir() + "classes/lydiaBeat.ck");
Machine.add(me.dir() + "classes/lydiaSpin.ck");
1::second => now;

// Add the main server
Machine.add("mainSerialServer.ck");
1::second => now;
