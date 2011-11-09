function createFortuneDiv(fortune) {
		var template = $("div#fallingFortuneTemplate").clone();
		template.removeAttr('id');

		var html = template.html();
		var pattern = '';
		for(prop in fortune) {
				pattern = "\\$\\{" + prop + "\\}";
				html = html.replace(new RegExp(pattern, 'g'), eval("fortune." + prop));
		}

		template.html(html);
		return template;
}

function animationSuccess() {
		var fortuneDiv = $(this);
		fortuneDiv.hide('fade', {}, 400);
		setTimeout(fortuneDiv.remove, 400);
}

function fallingFortune_mouseOver() {
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
}

function fallingFortune_mouseOut() {
		animateFallingDiv($(this), true);
		var contentDiv = $('div.content', $(this));
		var comicBalloon = $('div.comicBalloon', $(this));

		comicBalloon.hide('fade', {}, 500);
}

function fallingFortune_clicked() {
		var fortuneId = $("div.fortuneId", $(this)).text();
		window.location = fortuneId;
}

function connectEventHandlers(fortuneDiv) {
		fortuneDiv.hover(fallingFortune_mouseOver, fallingFortune_mouseOut);
		fortuneDiv.click(fallingFortune_clicked);
}

function animateFallingDiv(fortuneDiv, continueOnly) {
		var fallingArea = $("div#fallingArea");
		continueOnly = (typeof(continueOnly) != 'undefined') ? continueOnly : false;
		if(!continueOnly) {
				var startPosition = {
						top: fallingArea.offset().top,
						left: fallingArea.offset().left + parseInt(Math.random() * (fallingArea.width() - fortuneDiv.width()) )
				};
		}
		else
		{
				var startPosition = fortuneDiv.offset();
		}

		var fallingSpeed = fallingArea.height() * 10 + Math.random() * 20000 + 10000;
		var distance = startPosition.top + fallingArea.height() - fortuneDiv.height();

		fortuneDiv.offset(startPosition);
		fortuneDiv.css('z-index', Math.random() * 100);

		var properties = {
				top: distance,
		};

		connectEventHandlers(fortuneDiv);
		fallingArea.append(fortuneDiv);
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
