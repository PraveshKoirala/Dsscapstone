Next Word Prediction using ngram model
========================================================
author: Pravesh Koirala
date: 2016/01/21

Introduction
========================================================
<br>
This app (named, unsurprisingly, NextWord), outputs a probable next word
given the words preceding it. 
<br>
<br>
Inspired from apps like Swiftkey, NextWord uses a corpus to build upto 3-gram models to give predictions.

![Intro](introduction.JPG)

Algorithm
========================================================
<small>
<small>
NextWord uses Kneser-Ney interpolation which functions as both smoothing
and backoff model.
<br>
<br>
*[Kneser-Ney Interpolation](http://www.stats.ox.ac.uk/~teh/research/compling/hpylm.pdf) in a nutshell* 
<br>
![kneser-ney](kneser-ney.JPG)

$Where:$ <br>

$P^{IKN}_{\pi(u)}(w)$ is the interpolated kneser-ney probability for word $w$ given context $u$ <br>
$c_u$  is the count for the context u <br>
$c_{uw}$  is the count for the word w under context u <br>
$d_{|u|}$  is the discount value for context length u <br>
$t_u$  is the count for the context u <br>
$P^{IKN}_{\pi(u)}(w)$  is the backoff probability of word w under context u

</small>
</small>


Algorithm.. creating the model
========================================================
<small>
Cleaning: 

- change all text to lowercase
- remove profanities
- remove all numbers, punctuations except for apostrophes (')

The input is then tokenized and upto 3 grams model is created (using quanteda).

Only those trigrams or bigrams with their count > 1 are selected.

Any input I is cleaned in similar fashion as the corpus and then the Kneser-Ney Interpolation is used to give a prediction.

</small>

The APP *badum tiss*
=======================================================

<small>
The app is hosted [here](https://praveshkoirala.shinyapps.io/NextWord/)<br><br>
![app](app.JPG)
<br><br>
Simply type the phrase in the textbox and the app will give the top three predictions. (first prediction might be a bit slow)
</small>



