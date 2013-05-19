$(document).ready(function() {
$("a#hide").click(function(event) {
event.preventDefault();

$(this).next('#visable-div').toggle('slow');
if ($(this).children('span').text() == "-") 
	$(this).children('span').text("+");
	else 
	$(this).children('span').text("-");

});


});


 