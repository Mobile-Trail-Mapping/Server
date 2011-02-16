var menuYloc = null;
var previewYloc = null;

$(document).ready(function() {
// Image actions menu
	$('ul.imglist li').hover(
		function() { $(this).find('ul').css('display', 'none').fadeIn('fast').css('display', 'block'); },
		function() { $(this).find('ul').fadeOut(100); }
	);
	
	$('#header #nav li:last').addClass('nobg');
	$('.block_head ul').each(function() { $('li:first', this).addClass('nobg'); });
		
	// Image delete confirmation
	$('ul.imglist .delete a').click(function() {
		if (confirm("Are you sure you want to delete this image?")) {
			return true;
		} else {
			return false;
		}
	});
	
	//$('a[rel*=facebox]').facebox()
	
  // preview pane setup
	$('.preview-pane .preview').css("height",$('.main-section .block').height()-40+"px");
  $('.list-view > li').click(function(){
		var url = $(this).find('.more').attr('href');
		if (!$(this).parents('li').hasClass('current')) {
			$('.preview-pane .preview').animate({left: "-475px"}, 300, function(){
				$(this).animate({left: "-27px"}, 300).html('<img src="images/ajax-loader.gif" />').html("Testing");
			});
		} else {
			$('.preview-pane .preview').animate({left: "-475px"}, 300);
		}
		$(this).toggleClass('current').siblings().removeClass('current');
		return false;
  });

  $('.preview-pane .preview .close').live('click', function(){
		$('.preview-pane .preview').animate({left: "-375px"}, 300);
		$('.list-view li').removeClass('current');
		return false;
  });
  // preview pane setup end

	// floating menu and preview pane
	if ($('.preview-pane .preview').length>0) { previewYloc = parseInt($('.preview-pane .preview').css("top").substring(0,$('.preview').css("top").indexOf("px")), 10); }
	$(window).scroll(function () {
		var offset = 0;
		if ($('.preview-pane .preview').length>0) {
			offset = previewYloc+$(document).scrollTop()+400>=$('.main-section').height()? offset=$('.main-section').height()-400 : previewYloc+$(document).scrollTop();
			$('.preview-pane .preview').animate({top:offset},{duration:500,queue:false});
    }
	});
	
});
