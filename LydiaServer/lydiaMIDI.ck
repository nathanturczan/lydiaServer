// =================================================================
//connects to IAC midi drivers
//pass long midi from your MIDI driver to Lydia
// =================================================================

// the midi event
MidiIn min;
// the message for retrieving data
MidiMsg msg;
// connect to lydia server
OscOut out;
("localhost", 50001) => out.dest;

0 => int MIDIStatusByte;
0 => int MIDINote;
0 => int MIDIVel;



// number of the device to open (see: chuck --probe)
0 => int device;
// get command line
if( me.args() ) me.arg(0) => Std.atoi => device;



// open the device
if( !min.open( device ) ) me.exit();

// print out device that was opened
<<< "MIDI device:", min.num(), " -> ", min.name() >>>;

// infinite time-loop
while( true )
{
    
    //(msg.data1 & 0xF0)>>4 => status; // midi status byte
    //(msg.data1 & 0x0F) => chan;      // midi channel
            
    //msg.data1 => MIDIStatusByte;
    //msg.data2 => MIDINote;
    // msg.data3 => MIDIVel;
    // wait on the event 'min'
    min => now;
    
    // get the message(s)
    while( min.recv(msg) )
    {
        msg.data1 => MIDIStatusByte;
        msg.data2 => MIDINote;
        msg.data3 => MIDIVel;
        
        
        <<< MIDIStatusByte, MIDINote, MIDIVel>>>;
        if ((MIDIStatusByte >= 144) && (MIDIStatusByte <= 159)) {
            // print out midi message
            <<< "if within noteon range:", MIDIStatusByte, MIDINote, MIDIVel>>>;
            spork ~ lydiaBeatPlay(MIDINote, MIDIVel, 90);
            spork ~ lydiaSpinPlay(MIDINote, MIDIVel, 90);
        }
    }
}

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