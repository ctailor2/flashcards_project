$(document).ready(function() {
	$("#next_card").on("submit", function(event) {
		event.preventDefault();
		// make the next card request with ajax
		var form = $(this);
		var action = form.attr("action");
		// $.post submits the post request and receives a response
		// which is the get request
		$.post(action, function(response) {
		// when it responds show the next card
		form.closest('.container').remove();
		// $('.container').append(response);
		});
	})
});


// $ means jQuery (jQuery object)
// AJAX is a jquery library, post is an ajax request(?)

// See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
