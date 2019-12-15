

import de.voidplus.leapmotion.*;

import KinectPV2.KJoint;
import KinectPV2.*;

import oscP5.*;
import netP5.*;

int num=0;
int numFound = 0;
int num2=0;

PFont myFont, myBigFont;

LeapMotion leap;


OscP5 oscP5;
NetAddress dest;
KinectPV2 kinect;

float[] features = new float [23];


void setup() {
  size(1920, 1080, P3D);
  
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,1234);
  dest = new NetAddress("127.0.0.1",6448);

  kinect = new KinectPV2(this);

 kinect.enableSkeletonColorMap(true);
  kinect.enableColorImg(false);

  kinect.init();
  
 leap = new LeapMotion(this);
}

void draw() {
  background(0);

  image(kinect.getColorImage(), 0, 0, width, height);

  ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();
  
    int fps = leap.getFrameRate();

//LEAP LEAP LEAP LEAP LEAP LEAP LEAP LEAP 


  // ========= HANDS =========
numFound = 0;
  for (Hand hand : leap.getHands ()) {
      numFound++;

    // ----- BASICS -----

    int     hand_id          = hand.getId();
    PVector hand_position    = hand.getPosition();
    PVector hand_stabilized  = hand.getStabilizedPosition();
    PVector hand_direction   = hand.getDirection();
    PVector hand_dynamics    = hand.getDynamics();
    float   hand_roll        = hand.getRoll();
    float   hand_pitch       = hand.getPitch();
    float   hand_yaw         = hand.getYaw();
    boolean hand_is_left     = hand.isLeft();
    boolean hand_is_right    = hand.isRight();
    float   hand_grab        = hand.getGrabStrength();
    float   hand_pinch       = hand.getPinchStrength();
    float   hand_time        = hand.getTimeVisible();
    PVector sphere_position  = hand.getSpherePosition();
    float   sphere_radius    = hand.getSphereRadius();


    // ----- SPECIFIC FINGER -----

    Finger  finger_thumb     = hand.getThumb();
    // or                      hand.getFinger("thumb");
    // or                      hand.getFinger(0);

    Finger  finger_index     = hand.getIndexFinger();
    // or                      hand.getFinger("index");
    // or                      hand.getFinger(1);

    Finger  finger_middle    = hand.getMiddleFinger();
    // or                      hand.getFinger("middle");
    // or                      hand.getFinger(2);

    Finger  finger_ring      = hand.getRingFinger();
    // or                      hand.getFinger("ring");
    // or                      hand.getFinger(3);

    Finger  finger_pink      = hand.getPinkyFinger();
    // or                      hand.getFinger("pinky");
    // or                      hand.getFinger(4);        


    // ----- DRAWING -----

    hand.draw();
    // hand.drawSphere();


    // ========= ARM =========

    if (hand.hasArm()) {
      Arm     arm               = hand.getArm();
      float   arm_width         = arm.getWidth();
      PVector arm_wrist_pos     = arm.getWristPosition();
      PVector arm_elbow_pos     = arm.getElbowPosition();
    }


    // ========= FINGERS =========

    for (Finger finger : hand.getFingers()) {
      // Alternatives:
      // hand.getOutstrechtedFingers();
      // hand.getOutstrechtedFingersByAngle();

      // ----- BASICS -----

      int     finger_id         = finger.getId();
      PVector finger_position   = finger.getPosition();
      PVector finger_stabilized = finger.getStabilizedPosition();
      PVector finger_velocity   = finger.getVelocity();
      PVector finger_direction  = finger.getDirection();
      float   finger_time       = finger.getTimeVisible();


      // ----- SPECIFIC FINGER -----

      switch(finger.getType()) {
      case 0:
        // System.out.println("thumb");
        PVector pos = finger.getPosition();
        features[0] = pos.x;
        features[1] = pos.y;
        features[2] = pos.z;
        
        break;
      case 1:
        // System.out.println("index");
                pos = finger.getPosition();
        features[3] = pos.x;
        features[4] = pos.y;
        features[5] = pos.z;
        break;
      case 2:
        // System.out.println("middle");
                pos = finger.getPosition();
        features[6] = pos.x;
        features[7] = pos.y;
        features[8] = pos.z;
        break;
      case 3:
        // System.out.println("ring");
         pos = finger.getPosition();
        features[9] = pos.x;
        features[10] = pos.y;
        features[11] = pos.z;
        break;
      case 4:
        // System.out.println("pinky");
         pos = finger.getPosition();
        features[12] = pos.x;
        features[13] = pos.y;
        features[14] = pos.z;
        break;
      }


      // ----- SPECIFIC BONE -----

      Bone    bone_distal       = finger.getDistalBone();
      // or                       finger.get("distal");
      // or                       finger.getBone(0);

      Bone    bone_intermediate = finger.getIntermediateBone();
      // or                       finger.get("intermediate");
      // or                       finger.getBone(1);

      Bone    bone_proximal     = finger.getProximalBone();
      // or                       finger.get("proximal");
      // or                       finger.getBone(2);

      Bone    bone_metacarpal   = finger.getMetacarpalBone();
      // or                       finger.get("metacarpal");
      // or                       finger.getBone(3);


      // ----- DRAWING -----

      // finger.draw(); // = drawLines()+drawJoints()
      // finger.drawLines();
      // finger.drawJoints();


      // ----- TOUCH EMULATION -----

      int     touch_zone        = finger.getTouchZone();
      float   touch_distance    = finger.getTouchDistance();

      switch(touch_zone) {
      case -1: // None
        break;
      case 0: // Hovering
        // println("Hovering (#"+finger_id+"): "+touch_distance);
        break;
      case 1: // Touching
        // println("Touching (#"+finger_id+")");
        break;
      }
    }


    // ========= TOOLS =========

    for (Tool tool : hand.getTools ()) {


      // ----- BASICS -----

      int     tool_id           = tool.getId();
      PVector tool_position     = tool.getPosition();
      PVector tool_stabilized   = tool.getStabilizedPosition();
      PVector tool_velocity     = tool.getVelocity();
      PVector tool_direction    = tool.getDirection();
      float   tool_time         = tool.getTimeVisible();


      // ----- DRAWING -----

      // tool.draw();


      // ----- TOUCH EMULATION -----

      int     touch_zone        = tool.getTouchZone();
      float   touch_distance    = tool.getTouchDistance();

      switch(touch_zone) {
      case -1: // None
        break;
      case 0: // Hovering
        // println("Hovering (#"+tool_id+"): "+touch_distance);
        break;
      case 1: // Touching
        // println("Touching (#"+tool_id+")");
        break;
      }
    }
}


  // ========= DEVICES =========

  for (de.voidplus.leapmotion.Device device : leap.getDevices ()) {
    float device_horizontal_view_angle = device.getHorizontalViewAngle();
    float device_verical_view_angle = device.getVerticalViewAngle();
    float device_range = device.getRange();
  }
  
  // =========== OSC ============
  //if (num % 3 == 0) {
  //   //sendOsc();
  //}
  //num++;





///// KINECT KINECT KINECT KINECT KINECT KINECT KINECT
  //individual JOINTS
  for (int i = 0; i < skeletonArray.size(); i++) {
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    if (skeleton.isTracked()) { 


      KJoint[] joints = skeleton.getJoints();
    float a =  joints[KinectPV2.JointType_HandTipRight].getX();
    float b =  joints[KinectPV2.JointType_HandTipRight].getY();
    float z =  joints[KinectPV2.JointType_HandRight].getX();
    float w =  joints[KinectPV2.JointType_HandRight].getY();
    float v =  joints[KinectPV2.JointType_ThumbRight].getX();
    float g =  joints[KinectPV2.JointType_ThumbRight].getY();
    float s =  joints[KinectPV2.JointType_WristRight].getX();
    float t =  joints[KinectPV2.JointType_WristRight].getY();

    



    ellipse(a, b, 50, 50);
    features [15] =  a;
    features [16] =  b;
    features [17] =  z;
    features [18] =  w;
    features [19] =  v;
    features [20] =  g;
    features [21] =  s;
    features [22] =  t;

   
      color col  = skeleton.getIndexColor();
      fill(col);
      stroke(col);
      drawBody(joints);

      //draw different color for each hand state
      drawHandState(joints[KinectPV2.JointType_HandRight]);
      //drawHandState(joints[KinectPV2.JointType_HandLeft]);
    }
  }

  fill(255, 0, 0);
  text(frameRate, 50, 50);
}

//DRAW BODY
void drawBody(KJoint[] joints) {
  drawBone(joints, KinectPV2.JointType_Head, KinectPV2.JointType_Neck);
  drawBone(joints, KinectPV2.JointType_Neck, KinectPV2.JointType_SpineShoulder);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_SpineMid);
  drawBone(joints, KinectPV2.JointType_SpineMid, KinectPV2.JointType_SpineBase);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderRight);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderLeft);
  drawBone(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipRight);
  drawBone(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipLeft);

 //  Right Arm
  drawBone(joints, KinectPV2.JointType_ShoulderRight, KinectPV2.JointType_ElbowRight);
  drawBone(joints, KinectPV2.JointType_ElbowRight, KinectPV2.JointType_WristRight);
  drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_HandRight);
  drawBone(joints, KinectPV2.JointType_HandRight, KinectPV2.JointType_HandTipRight);
  drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_ThumbRight);

  // Left Arm
  drawBone(joints, KinectPV2.JointType_ShoulderLeft, KinectPV2.JointType_ElbowLeft);
  drawBone(joints, KinectPV2.JointType_ElbowLeft, KinectPV2.JointType_WristLeft);
  drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_HandLeft);
  drawBone(joints, KinectPV2.JointType_HandLeft, KinectPV2.JointType_HandTipLeft);
  drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_ThumbLeft);

   //Right Leg
  drawBone(joints, KinectPV2.JointType_HipRight, KinectPV2.JointType_KneeRight);
  drawBone(joints, KinectPV2.JointType_KneeRight, KinectPV2.JointType_AnkleRight);
  drawBone(joints, KinectPV2.JointType_AnkleRight, KinectPV2.JointType_FootRight);

  // Left Leg
  drawBone(joints, KinectPV2.JointType_HipLeft, KinectPV2.JointType_KneeLeft);
  drawBone(joints, KinectPV2.JointType_KneeLeft, KinectPV2.JointType_AnkleLeft);
  drawBone(joints, KinectPV2.JointType_AnkleLeft, KinectPV2.JointType_FootLeft);

  drawJoint(joints, KinectPV2.JointType_HandTipLeft);
  drawJoint(joints, KinectPV2.JointType_HandTipRight);
  drawJoint(joints, KinectPV2.JointType_FootLeft);
  drawJoint(joints, KinectPV2.JointType_FootRight);

  drawJoint(joints, KinectPV2.JointType_ThumbLeft);
  drawJoint(joints, KinectPV2.JointType_ThumbRight);

  drawJoint(joints, KinectPV2.JointType_Head);
}

//draw joint
void drawJoint(KJoint[] joints, int jointType) {
  pushMatrix();
  translate(joints[jointType].getX(), joints[jointType].getY(), joints[jointType].getZ());
 ellipse(0, 0, 25, 25);
  popMatrix();
}


//draw bone
void drawBone(KJoint[] joints, int jointType1, int jointType2) {
  pushMatrix();
  translate(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ());
  ellipse(0, 0, 25, 25);
  popMatrix();
  line(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ(), joints[jointType2].getX(), joints[jointType2].getY(), joints[jointType2].getZ());
}

//draw hand state
void drawHandState(KJoint joint) {
  noStroke();
  handState(joint.getState());
  pushMatrix();
  translate(joint.getX(), joint.getY(), joint.getZ());
  ellipse(0, 0, 70, 70);
  popMatrix();
}

/*
Different hand state
 KinectPV2.HandState_Open
 KinectPV2.HandState_Closed
 KinectPV2.HandState_Lasso
 KinectPV2.HandState_NotTracked
 */
void handState(int handState) {
  switch(handState) {
  case KinectPV2.HandState_Open:
    fill(0, 255, 0);
    num2=0;
    break;
  case KinectPV2.HandState_Closed:
    fill(255, 0, 0);
    sendOsc();
    num2++;
    break;
  //case KinectPV2.HandState_Lasso:
    //fill(0, 0, 255);
    //sendOsc();
    //num2=0;
    //break;
  case KinectPV2.HandState_NotTracked:
    fill(255, 255, 255);
    num2=0;
    break;
  }
}


//====== OSC SEND ======
void sendOsc() {
  OscMessage msg = new OscMessage("/wek/inputs");
  if (numFound>0 && num2 > 0 ){
    for (int i = 0; i < 23; i++) {
      msg.add(features[i]);
    }
  
  } else {
    for (int i = 0; i < 23; i++) {
      msg.add(0.);
    }
  }

  oscP5.send(msg, dest);
}
