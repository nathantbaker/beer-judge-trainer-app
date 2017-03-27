# BrewJudge #

The BrewJudge is a native iOS app built in Swift that allows you to train to become a [Beer Judge Certification Program](http://www.bjcp.org/) (BJCP) beer judge.

First you select a beer and rate its in various categories such as aroma, appearance, and flavor. You assign up to 50 points.

Then you see how closely your scores stack up against certified beer judges. The app is powered by an API built for this app using the Django REST Framework.

Author: [Nathan T. Baker](http://nathantbaker.com/)

## Steps to User Test This App On Your Phone ##

I do have plans to the deploy the app to the iTunes store, but with a few steps you can get it running on your iPhone if you'd like to test it out now.

1. Download Xcode: https://itunes.apple.com/us/app/xcode/id497799835?mt=12
1. Download the app files: https://github.com/nathantbaker/beer-judge-trainer-app/archive/master.zip
1. Unzip it and open “BrewJudge.xcodeproj”
1. Connect your iPhone to your computer with with a USB charger cable.
1. In Xcode where it says “Beer Judge Trainer > blah blah” select your device from the list.
1. In Xcode click the play button.
1. You’ll get an error that the phone hasn’t given you permission. Go to your phone settings > general  > device management > developer app > and click trust.
1. Now click OK in Xcode. There will be a new BrewJudge app on your phone.

Please send any feedback to nathantbaker@gmail.com.
