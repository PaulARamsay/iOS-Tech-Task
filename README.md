# MoneyBox Tech Test

Hey thanks for taking a look at my coding test. It's not perfect and there's a lot i'd change but i'd love explain what i've done. 


# Outline

I'm a big fan of MVP and I thought this project would be perfect for it. Each screen is fairly simple. Could be built with reusable components and it should be fairly scalable. I used the coordinator pattern to handle moving between screens. 

## What I would add if I had more time  

* Localizable strings file that my Strings.Swift class would point to. We do something similar in my current role. 
* Use a Currency Amount model over the double values you decode to
* An improved networking library over what was provided, Alamofire or something. I felt the current testing framework was challenging to fully test the app.
* I'd have used a Singleton for my APISessions object over passing around the one instance, i know I made a mistake there.
* More extensive use of extensions

### Known Issues

* I am aware that because I have a loading screen that loads in the product details the balance will not be immediately updated when the user enters the app. This was an architectural decision based on my presumption that the balance wasn't updated immediately. We do a similar thing here at SB, it was possibly a mistake but oh well.

## Questions I have

* I couldn't fully test my solution because the API was returning "Your annual lifetime limit is £4000,  you can add £x". This was returned on both accounts? Hopefully this wasn't a me thing. I've done my best to work around this though through unit testing. 

