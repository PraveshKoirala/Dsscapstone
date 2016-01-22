# NextWord

An app to predict the next word given the preceding phrases based on trigrams and lower order grams. It uses Kneser-Ney Interpolation for the prediction. The discount function used here is log(max(C<sub>uw</sub>)) where u is the context and w is the word.

The app is hosted on shinyio and can be found [here](https://praveshkoirala.shinyapps.io/NextWord/)

The presentation slides (hosted on rpubs) can be found [here](https://rpubs.com/praveshkoirala/nextword)