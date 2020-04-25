#UQS

## About
----------------------------------------------------------
The problem and how we solved it
----------------------------------------------------------

Here in the Philippines, queues in banks, schools, and government agencies could consume a lot of time and energy from people. People complain about waiting in long line. In certain cases, there are some who stay in a queue, while wanting to run some errands. But they can’t do them simultaneously. This is a type of a problem that almost every one of us encounter daily. Hence, we created a solution.

When it comes to software for digital queuing, there's a bunch of them out there, but they are specific to one service. We created a Unified digital queuing software, where at a glance, you can see services, and queue without worrying about staying in the vicinity the whole time because it notifies you when your turn is near.

If you are a student like us or someone who needs to pay bills over the counter and want to manage time efficiently, you will surely benefit using UQS. Now you can attend your classes and meeting or go shopping while queuing online, anytime, anywhere and not worry about missing the line. Our goal is simple and straight forward. It is to create an app that provides efficient service not only for people but also for institutions (by helping them provide better quality of service) and make the long waiting in-line a thing in the past.

----------------------------------------------------------
Requirements
----------------------------------------------------------
<ol>
  <li> Node Js </li>
   <li> Flutter </li>
    <li> Android Studio </li>
  </ol>
  

  
----------------------------------------------------------
Installing/Running Locally
---------------------------------------------------------- 
 Compiled Apk for Android available <a href="https://drive.google.com/drive/folders/1crLvFfFH5p2f_DIsXlRHr77LdZ1SWp59" target="_blank"> here. </a>
<ol>
  <li> Get the source code: git clone:  </li>
   <li> install the dependencies by running pub get </li>
    <li> flutter run </li>
  </ol>
  
  Note: The app has been tested with
<ol>
  <li> Pixel Xl with (Latest Api Available) [For development] </li>
   <li> Samsung A20s (Android 9) [Build Test] </li>
  </ol>
  
 
 ----------------------------------------------------------
Using the app
---------------------------------------------------------- 
  <ul>
  <li> 1. Register and verify email address then login. </li>
   <li> 2. In the navigation bar click on services then find your service of choice. </li>
    <li> 3. Tap on it you will be navigated to the service information from here you can see the live queue or queue </li>
     <ul>
       <li> Live queue is where you can see what teller is online. </li>
        <li> Queue is where you can subscribe to this service. </li>
       </ul>
  </ul>
  <ul>
   <li> 4. Tap on queue then select a trigger  </li>
       <ul>
       <li> A trigger is a number where if that is the difference from your ticket number it will notify you. </li>
       <li> You may see some service's that the trigger is not available this is because there should be atleast 5 tickets pending on the          service. </li>
  </ul>
   <li> 5. You can enable email notification where you will recieve notification about your ticket through email. An FCM notification will still notify you by default.  </li>
  <li> 6. After creating a ticket you will see the ticket in Home(Active tickets) from here you can see infrmation's such how many peron's before you, your ticket timeline, and you can also cancel your ticket. </li>
   <li> 7. You will be notified if next in the queue </li>
   </ul>
  
  
  
----------------------------------------------------------
Flutter Dependencies
----------------------------------------------------------
<ul>
 <li> cloud_firestore: ^0.13.4+2 </li>
 <li> cupertino_icons: ^0.1.2 </li>
 <li> splashscreen: ^1.2.0 </li>
 <li> firebase_core: ^0.4.3 </li>
 <li> firebase_auth: ^0.15.4 </li>
 <li> provider: ^4.0.5 </li>
 <li> flutter_spinkit: "^4.0.0" </li>
 <li> progress_dialog: ^1.2.0 </li>
 <li> cached_network_image: ^2.0.0 </li>
 <li> expandable: ^4.1.2 </li>
 <li> intl: ^0.16.1 </li>
 <li> http: ^0.12.0+4 </li>
 <li> firebase_messaging: ^6.0.13 </li>
 <li> simple_animations: ^1.3.11 </li>
 <li> flutter_screenutil: ^1.1.0 </li>
 <li> dio: ^3.0.9 </li>
 <li> firebase_storage: ^3.1.5 </li>
 <li> image_picker: ^0.6.5 </li>
 <li> image_cropper: ^1.2.1 </li>
 <li> numberpicker: ^1.2.0 </li>
  </ul>


## Developers
----------------------------------------------------------
Dancedrick Alegroso | Lead developer, Full Stack  <br/>
Carl Palisan | Flutter Lead developer <br/>
Steve Felizard | Flutter front end, UI <br/>
Gaille Cabanggay | Firebase, Flutter <br/>

<hr>
© THE UQSTEAM 2020. All Rights Reserved.
