// ======================================================================
// Lydia Spin
// By Ajay Kapur, Nathan Turczan & McLean Macionis
// Music Technology: Interaction, Intelligence & Design, 2018
// File: lydiaSpin.ck
// ======================================================================

public class lydiaSpin extends serialBot {
    // lydiaBeat Arduino ID is 1
    // lydiaSpin Arduino ID is 2

    // MIDI notes
    [60,61,62,63,64,65,66,67,68,69,
     70,71,72,73,74,75,76,77,78,79] @=> int scl[];

    rescale(scl);

    2 => int ID;
    "/lydiaSpin" => string address;
    IDCheck(ID, address) => int check;
    if (check >= 0) {
        spork ~ oscrecv(check, address);
    }
}
