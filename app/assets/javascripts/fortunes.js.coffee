
root = exports ? this

root.randomColor= () ->
	#alert "random color"
	colors = ["#60003", "#CC0F00", "#331C00", "#16FF00", "#900F66","#33F550", "#C11F66", "#99C110", "#933114", "#131C71", "#263F20", "#9A0F60", "#13FA5A"]
	index = parseInt ( (colors.length - 1) * Math.random() )
	colors[index]

	
root.createFortuneDiv= (fortune) ->
	#alert "create fortune div"
	template = $("div#fallingFortuneTemplate")
	fortuneDiv = template.clone()
	fortuneDiv.removeAttr('id')
	fortuneDiv.css('background-color', randomColor())

	html = fortuneDiv.html()
	pattern = ''
	for prop of fortune 
		pattern = "\\$\\{" + prop + "\\}"
		html = html.replace(new RegExp(pattern, 'g'), eval("fortune." + prop))

	fortuneDiv.html(html)
	fortuneDiv
	
root.animationSuccess= () ->
	#alert "anim success"
	fortuneDiv = $(@)
	fortuneDiv.hide('fade', {}, 400)
	setTimeout(fortuneDiv.remove, 400)


root.scrollUpAndDown= (comicDiv) ->
	#alert "sscroll up and down"
	if(comicDiv.is(":visible"))
		content = $("p.text", comicDiv)
		step = 12
		settings =  
			direction: "up",
			step: step,
			onEdge:() -> setTimeout( (() -> content.autoscroll("reverse") )  ,  2000 )
	content.autoscroll(settings)	

root.fallingFortune_mouseEnter= () ->
	#alert "mouse enter"
	$(@).css('z-index', '101')
	$(@).stop()
	contentDiv = $('div.content', $(@))
	comicBalloon = $('div.comicBalloon', $(@));

	balloonPosition = 
		top: $(@).position().top - comicBalloon.height(),
		left: $(@).position().left - comicBalloon.width() + 30
		

	comicBalloon.offset(balloonPosition)
	comicBalloon.show('fade', {}, 500)
	root.scrollUpAndDown(comicBalloon)


root.fallingFortune_mouseLeave= () ->
	#alert "mouse leave"
	root.animateFallingDiv($(@), true)
	contentDiv = $('div.content', $(@))
	comicBalloon = $('div.comicBalloon', $(@))
	comicContent = $('p.text', comicBalloon);
	comicContent.autoscroll("destroy");

	comicBalloon.hide('fade', {}, 500)


root.fallingFortune_clicked= () ->
	#alert "falling clicked"
	fortuneId = $("div.fortuneId", $(@)).text()
	window.location = fortuneId

root.connectEventHandlers= (fortuneDiv) ->
	#alert "connect event Handlers"
	fortuneDiv.mouseenter(root.fallingFortune_mouseEnter)
	fortuneDiv.mouseleave(root.fallingFortune_mouseLeave)
	fortuneDiv.click(root.fallingFortune_clicked)

root.animateFallingDiv= (fortuneDiv, continueOnly) ->
	#alert "animate falling div"
	continueOnly = (typeof(continueOnly) != 'undefined') ? continueOnly : false

	fallingArea = $("div#fallingArea")
	
	topPosition = 
		top: fallingArea.offset().top,
		left: fallingArea.offset().left + parseInt(Math.random() * (fallingArea.width() - fortuneDiv.width()) )
	startPosition = if continueOnly then fortuneDiv.offset() else topPosition

	endPosition = 
		top: topPosition.top + fallingArea.height() - fortuneDiv.height(),
		left: startPosition.left
	distance = endPosition.top - startPosition.top
	fallingSpeed = distance * 25 + Math.random() * distance * 25

	fortuneDiv.offset(startPosition)
	fortuneDiv.css('z-index', Math.random() * 100)

	properties = 
		top: endPosition.top
		
	root.connectEventHandlers(fortuneDiv)

	if !continueOnly 
		fortuneDiv.delay(Math.random()*2000 + 1000).show('fade', {}, 400)

	fortuneDiv.animate(properties, fallingSpeed, 'linear', animationSuccess)
	

root.fallingFortunesLoaded= (data) ->
	#alert "falling fortunes Loaded"
	fallingArea = $("div#fallingArea")
	for i in data
		fortuneDiv = root.createFortuneDiv(data[_i])
		fallingArea.append(fortuneDiv);	

		root.animateFallingDiv(fortuneDiv)
		
	setTimeout(loadFallingFortunes, 6000)


root.loadFallingFortunes= () ->
	#alert "loadFallingOptions"
	options = 
		success: fallingFortunesLoaded
	$.ajax('random_fortunes.json', options)

root.showHideFullContent= () ->
	#alert "showHideFullContent"
	fullContent = $(".fullContent", $(@))
	shortContent = $(".shortContent", $(@))
	if fullContent.is(":visible") 
		return
		
	$('div.shortContent').show()
	$("div.fullContent").hide()

	shortContent.hide()
	fullContent.show('fast')


root.registerEventHandlers= () ->
	#alert "Reg"
	$('div.fortuneBig').click(showHideFullContent)

$ ->
	registerEventHandlers()
	#alert "Coffee"
	if $("div#fallingArea").length == 1 
		loadFallingFortunes()
