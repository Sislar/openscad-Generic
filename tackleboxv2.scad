
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

module pinhole(h=10, r=4, lh=3, lt=1, t=0.3, tight=true) {
  // h = shaft height
  // r = shaft radius
  // lh = lip height
  // lt = lip thickness
  // t = tolerance
  // tight = set to false if you want a joint that spins easily
  
  union() {
    pin_solid(h, r+(t/2), lh, lt);
    cylinder(h=h+0.2, r=r);
    // widen the cylinder slightly
    // cylinder(h=h+0.2, r=r+(t-0.2/2));
    if (tight == false) {
      cylinder(h=h+0.2, r=r+(t/2)+0.25);
    }
    // widen the entrance hole to make insertion easier
    translate([0, 0, -0.1]) cylinder(h=lh/3, r2=r, r1=r+(t/2)+(lt/2));
  }
}


// this is mainly to make the pinhole module easier
module pin_solid(h=10, r=4, lh=3, lt=1) {
  union() {
    // shaft
    cylinder(h=h-lh, r=r, $fn=30);
    translate([0, 0, h-lh]) cylinder(h=lh*0.25, r1=r, r2=r+(lt/2), $fn=30);
    translate([0, 0, h-lh+lh*0.25]) cylinder(h=lh*0.25, r=r+(lt/2), $fn=30);    
    translate([0, 0, h-lh+lh*0.50]) cylinder(h=lh*0.50, r1=r+(lt/2), r2=r-(lt/2), $fn=30);    
  }
}


module pin(h=10, r=4, lh=3, lt=1) {
  // h = shaft height
  // r = shaft radius
  // lh = lip height
  // lt = lip thickness

  difference() {
    pin_solid(h, r, lh, lt);
    
    // center cut
    translate([-r*0.5/2, -(r*2+lt*2)/2, h/4]) cube([r*0.5, r*2+lt*2, h]);
    translate([0, 0, h/4]) cylinder(h=h+lh, r=r/2.5, $fn=20);
    // center curve
    // translate([0, 0, h/4]) rotate([90, 0, 0]) cylinder(h=r*2, r=r*0.5/2, center=true, $fn=20);
  
    // side cuts
    translate([-r*2, -lt-r*1.125, -1]) cube([r*4, lt*2, h+2]);
    translate([-r*2, -lt+r*1.125, -1]) cube([r*4, lt*2, h+2]);
  }
}




//Box();
translate([0,40,0])Box();


//translate([20,20,5])rotate([-90,0,0])   pin(h=5, r=3, lh=3, lt=1);
//translate([20,0,5])rotate([90,0,0])   pin(h=5, r=3, lh=3, lt=1);
translate([30,60,5])rotate([-90,0,0])   pin(h=5, r=3, lh=3, lt=1);
translate([30,40,5])rotate([90,0,0])   pin(h=5, r=3, lh=3, lt=1);

// Connector
translate([10,-20,0]) difference(){
    hull() {
      cylinder(r1=5,r2=5,h=3);
       translate([14.14,0,0]) cylinder(r1=5,r2=5,   h=3);
      }
      pinhole(h=3, r=3, lh=3, lt=1, t=0.2, tight=false);
      translate([14.14,0,0]) pinhole(h=3, r=3, lh=3, lt=1, t=0.2, tight=false);
}


translate([10,-35,0]) difference(){
    hull() {
      cylinder(r1=5,r2=5,h=3);
       translate([14.14,0,0]) cylinder(r1=5,r2=5,   h=3);
      }
      pinhole(h=3, r=3, lh=3, lt=1, t=0.2, tight=false);
      translate([14.14,0,0]) pinhole(h=3, r=3, lh=3, lt=1, t=0.2, tight=false);
}