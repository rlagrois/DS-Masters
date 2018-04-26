bg bg;
features feat;
wallpaper wp;
//#BF0000
//#00BF8D
//#008118

void setup(){
 size(900, 900);
 
 wp = new wallpaper();
 bg = new bg();
 feat = new features();
 
 wp.wall("Boba the Cat", width * .15, height * .9, #BF0000);
 
 //#02EDE7
 bg.head(#355F2D);
 
 feat.reds(#CE0003);
 feat.blacks(#000000);
 feat.yellows(#CEBA00);
 feat.ant(#898886);
 
}