.pragma library

function shuffle(array) {
  var currentIndex, tmp;
  for (var i = 0; i < array.length; i++) {
    currentIndex = Math.floor(Math.random() * (i + 1));
    tmp = array[i];
    array[i] = array[currentIndex];
    array[currentIndex] = tmp;
  }
}

function generateCardIndexes(imageCount, repeatCount) {
  var cardIndexes = [];
  var i, j;
  for (i = 0; i < imageCount; i++) {
    for (j = 0; j < repeatCount; j++) {
      cardIndexes.push(i + 1);
    }
  }
  shuffle(cardIndexes);
  return cardIndexes;
}


//function shuffle(model){
//    var currentIndex = model.count, temporaryValue, randomIndex;
//    /* While there remain elements to shuffle.. */
//    while (0 !== currentIndex) {
//        /* Pick a remaining element... */
//        randomIndex = Math.floor(Math.random() * currentIndex)
//        currentIndex -= 1
//        /* And swap it with the current element. */
//        /* the dictionaries maintain their reference so a copy should be made */
//        temporaryValue = JSON.parse(JSON.stringify(model.get(currentIndex)))
//        model.set(currentIndex, model.get(randomIndex))
//        model.set(randomIndex, temporaryValue);
//    }
//    return model;
//}
