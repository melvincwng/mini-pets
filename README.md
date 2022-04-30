# Mini Pets
Mini Pets is a digital pet game where you raise a virtual pet slime by feeding it, playing with it and cleaning it every 8 hours. 

As you feed, play or clean your pet slime, it will gain levels and upon hitting certain levels/milestones, it will evolve and change color.

Have fun unlocking the various pet slimes available!

Will you be the lucky one to unlock the RARE and SPECIAL FIRE SLIME???? :D
 
# Development Process
Development of the game: 21/05/2021 - 29/05/2021

Ideation (1 day) > Planning (1 day) > Rough Design (1 day) > Gathering assets (1 day) > Coding & Internal testing (5 days) > Release of Version 1.0

After initial release of Version 1.0, I spent a couple of hours every once in a while to update the game with new features and bug fixes. Current version: Version 2.0 (as of 30/04/2022)

# Useful Links (for personal reference)
    https://melvinng.itch.io/mini-pets
    https://sites.google.com/view/mini-pets-news 
    https://sites.google.com/view/mini-pets-privacy-policy/
    
# Troubleshooting
When re-exporting the app in future, you may encounter some issues/errors/app crashes. I have compiled a list of issues which I've encountered before when debugging in logcat (Android Studio):
 1. java.lang.RuntimeException (see local screenshot for reference) ---> If you see this error in logcat, it means you forgot to or did not configure correctly the Admob App ID on the AndroidManifest.xml. This will cause your app to crash when launched. Refer to links 1 & 2 below, and follow their documentation to re-setup the project AND follow their troubleshooting.
 2. java.lang.VerifyError (see local screenshot for reference) ---> If you see this error in logcat, it probably means you are using an incompatible version of the Godot Game Engine & the Godot-Android-Admob-Plugin. What happened previously was that I was using the latest version of Godot Game Engine (V3.4.4) that supported API level 30 (Android 11 OS), however the Admob-Plugin (V4.1.1) which I used was only supporting API level 29 (Android 10 OS). Due to this mismatch/incompatibility, it will cause crashes when the app is launched. The solution is to use a version of Godot Game Engine (e.g. v3.4.4) and a version of the Admob-Plugin (e.g. V5.1.0) that are compatible (in this case, both versions support API level 30).
 3. Check if you have the latest versions/packages for Android SDK installed. Outdated versions/packages could result in app crashes/issues. See link 3 below for reference on where to find the latest packages to install
 4. Before exporting to HTML game, please make sure that you tick/allow hiDPI in your project settings. Otherwise, the exported HTML game will be of lower/poorer resolution.
 5. References:
	 - https://developers.google.com/admob/android/quick-start (Refer to their 'Configure your app - Step 3' to see what you need to configure in the AndroidManifest.xml)
	 - https://github.com/Shin-NiL/Godot-Android-Admob-Plugin (Refer to their a) Documentation on how to use the plugin && b) 'Troubleshooting' section to debug as well) 			 
	 - https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_android.html (To check if you've installed the latest Android SDK)
	 - https://godotengine.org/qa/106290/game-runs-with-poor-graphics-quality-running-mobile-browser (Issue regarding low resolution when exporting to HTML)

# Updates (if any)
- 01/09/2021 - Mini Pets officially reached 1000+ downloads in Google Play Store! :)
- Since it's inaugural release in May 2021, incremental updates/enhancements have been regularly added to the game.

&copy; 2022 - Proudly developed by: Melvin Ng
