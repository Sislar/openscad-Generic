
$fn=40;

Tol = 0.1;

module Box (){
difference() {
    cube ([40,20,10]);
    translate([1.4,1.4,1.4])cube ([40-2.8,20-2.8,10]);
}
}

module nub(ipH=2, ipR=2.5, ipLip = 0.4) {
difference() 
    {        
     union() 
       {
       cylinder(r1=ipR-Tol, r2=ipR-Tol, h=ipH);
       translate([0,0,ipH])cylinder(r1=ipR-Tol+ipLip, r2=ipR, h=1.4);
       }      
    cube([2,50,50],center=true);         
    }
}

Box();
translate([0,40,0])Box();

translate([20,20,5])rotate([-90,0,0])nub(ipH=2);
translate([20,0,5])rotate([90,0,0])nub(ipH=2);

translate([30,60,5])rotate([-90,0,0])nub(ipH=2);
translate([30,40,5])rotate([90,0,0])nub(ipH=2);

// Connector
translate([10,-20,0]) difference(){
    hull() {
      cylinder(r1=4,r2=4,h=1.4);
       translate([14.14,0,0]) cylinder(r1=4,r2=4,   h=1.4);
      }
      cylinder(r1=2.6,r2=2.6,h=5);
      translate([14.14,0,0]) cylinder(r1=2.6,r2=2.6,h=5);
}