Array::shuffle = -> @sort -> 0.5 - Math.random()
@randomColors = () -> (fortunes = $("div.fortuneBig")
colors = ["#71D439"]
colors.shuffle
($(fortune).css("background-color", colors[0])
colors.shuffle() 
) for fortune in fortunes)
jQuery().ready(randomColors);
