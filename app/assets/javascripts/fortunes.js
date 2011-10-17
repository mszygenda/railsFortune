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
});
