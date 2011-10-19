Array::shuffle = -> @sort -> 0.5 - Math.random()
@randomColors = () -> (fortunes = $("div.fortuneBig")
colors = ["#66CC33", "#33CC4D", "#B3CC33", "#75D175", "#CCCC33"]
colors.shuffle
($(fortune).css("background-color", colors[0])
colors.shuffle() 
) for fortune in fortunes)
jQuery().ready(randomColors);
