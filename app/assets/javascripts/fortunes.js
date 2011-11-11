function randomColor() {
		colors = ["#66CC33", "#CCFF00", "#33CC00", "#66FF00", "#99FF66","#33FF00", "#CCFF66", "#99CC00"];
		var index = parseInt ( (colors.length - 1) * Math.random() );
		return colors[index];
}

function createFortuneDiv(fortune) {
		var template = $("div#fallingFortuneTemplate");
		var fortuneDiv = template.clone();
		fortuneDiv.removeAttr('id');
		fortuneDiv.width(template.width());
		fortuneDiv.height(template.height());
		fortuneDiv.css('background-color', randomColor());

		var html = fortuneDiv.html();
		var pattern = '';
		for(prop in fortune) {
				pattern = "\\$\\{" + prop + "\\}";
				html = html.replace(new RegExp(pattern, 'g'), eval("fortune." + prop));
		}

		fortuneDiv.html(html);
		return fortuneDiv;
}

function animationSuccess() {
		var fortuneDiv = $(this);
		fortuneDiv.hide('fade', {}, 400);
		setTimeout(fortuneDiv.remove, 400);
}

function scrollUpAndDown(comicDiv) {
		if(comicDiv.is(":visible")) {
				var content = $("p.text", comicDiv);
				var step = 20;
				var settings = { 
						direction: "down",
						step: step,
						onEdge: function () {
								content.autoscroll("reverse");
						}
				};
				content.autoscroll(settings);
				setInterval(function() {
						content.autoscroll("toggle");
				}, 2000);
		}
}

function fallingFortune_mouseEnter() {
		$(this).css('z-index', '101');
		$(this).stop();
		var contentDiv = $('div.content', $(this));
		var comicBalloon = $('div.comicBalloon', $(this));

		var balloonPosition = {
				top: $(this).position().top - comicBalloon.height(),
				left: $(this).position().left - comicBalloon.width() + 30
		}

		comicBalloon.offset(balloonPosition);
		comicBalloon.show('fade', {}, 500);
		setTimeout(function() { 
				scrollUpAndDown(comicBalloon)
		}, 2000);
}

function fallingFortune_mouseLeave() {
		animateFallingDiv($(this), true);
		var contentDiv = $('div.content', $(this));
		var comicBalloon = $('div.comicBalloon', $(this));
		var comicContent = $('p.text', comicBalloon);
		comicContent.autoscroll("destroy");

		comicBalloon.hide('fade', {}, 500);
}

function fallingFortune_clicked() {
		var fortuneId = $("div.fortuneId", $(this)).text();
		window.location = fortuneId;
}

function connectEventHandlers(fortuneDiv) {
		fortuneDiv.mouseenter(fallingFortune_mouseEnter);
		fortuneDiv.mouseleave(fallingFortune_mouseLeave);
		fortuneDiv.click(fallingFortune_clicked);
}

function animateFallingDiv(fortuneDiv, continueOnly) {
		continueOnly = (typeof(continueOnly) != 'undefined') ? continueOnly : false;

		var fallingArea = $("div#fallingArea");

		var topPosition = {
				top: fallingArea.offset().top,
				left: fallingArea.offset().left + parseInt(Math.random() * (fallingArea.width() - fortuneDiv.width()) )
		};
		var startPosition = continueOnly ? fortuneDiv.offset() : topPosition;
		var endPosition = {
				top: topPosition.top + fallingArea.height() - fortuneDiv.height(),
				left: startPosition.left
		};

		var distance = endPosition.top - startPosition.top;
		var fallingSpeed = distance * 25 + Math.random() * distance * 25;

		fortuneDiv.offset(startPosition);
		fortuneDiv.css('z-index', Math.random() * 100);

		var properties = {
				top: endPosition.top,
		};

		connectEventHandlers(fortuneDiv);
		fallingArea.append(fortuneDiv);

		// If it's new animation randomize show up time
		if(!continueOnly) {
				fortuneDiv.delay(Math.random()*2000 + 1000).show('fade', {}, 400);
		}

		fortuneDiv.animate(properties, fallingSpeed, 'linear', animationSuccess);
}

function fallingFortunesLoaded(data) {
		for(var i = 0; i < data.length; i++) {
				var fortuneDiv = createFortuneDiv(data[i]);

				animateFallingDiv(fortuneDiv);
		}
		
		setTimeout(loadFallingFortunes, 6000);
}

function loadFallingFortunes() {
		var options = {
				success: fallingFortunesLoaded
		};
		$.ajax('random_fortunes.json', options);
}

function showHideFullContent()
{
		var fullContent = $(".fullContent", $(this));
		var shortContent = $(".shortContent", $(this));
		if(fullContent.is(":visible"))
				return;
		$('div.shortContent').show();
		$("div.fullContent").hide();

		shortContent.hide();
		fullContent.show('fast');
}

function registerEventHandlers() {
		$('div.fortuneBig').click(showHideFullContent);
}

$(document).ready(function() {
		registerEventHandlers();
		if( $("div#fallingArea").length == 1 ) {
				loadFallingFortunes();
		}
});
