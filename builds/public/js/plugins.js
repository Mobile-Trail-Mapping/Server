
$(document).ready(function(){

	// Fancy indents
	
	$(".nightly-toggle a, .stable-toggle a, #nightly li a").hover(function(){
		$(this).stop().animate({marginLeft:'5px'},{queue:false, duration:300, easing: 'easeOutQuart'})
	},function(){
		$(this).stop().animate({marginLeft:'0px'},{queue:false, duration:300, easing: 'easeOutQuart'})
	});

	// Content Sliding
	
	$("#android .tab-content, #iphone .tab-content").hide(); 
	$("#android .tab-content:first, #iphone .tab-content:first").show();
	$(".stable-toggle").hide();
	
	var speed = 500;
	$(".nightly-toggle").click(function() {
		$(this).hide();
		$(this).parent().find(".tab-content").slideUp(speed);
		$(this).parent().parent().find(".stable-toggle").fadeIn(speed);
		var activeTab = $(this).find("a").attr("href");
		$(this).parent().find(activeTab).slideDown(speed);
		return false;
	});
	
	$(".stable-toggle").click(function() {
		$(this).hide();
		$(this).parent().find(".tab-content").slideUp(speed);
		$(this).parent().parent().find(".nightly-toggle").fadeIn(speed);
		var activeTab = $(this).find("a").attr("href");
		$(this).parent().find(activeTab).slideDown(speed);
		return false;
	});

	$('#nightly').accordion({
		header: '.head',
		autoheight: false
	});
});