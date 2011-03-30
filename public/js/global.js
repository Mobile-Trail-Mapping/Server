var menuYloc = null;
var previewYloc = null;
var _left = null;

$(document).ready(function() {
	
	// image actions menu
	$('ul.imglist li').hover(
		function() { $(this).find('ul').css('display', 'none').fadeIn('fast').css('display', 'block'); },
		function() { $(this).find('ul').fadeOut(100); }
	);
	
	// small changes
	$('#header #nav li:last').addClass('nobg');
	$('.block-head ul').each(function() { $('li:first', this).addClass('nobg'); });
	$('.list-view > li').hover(function() {
		$(this).find('.tools').show();
	}, function() {
		$(this).find('.tools').hide();
	});
	
	// image delete confirmation
	$('ul.imglist .delete a').click(function() {
		if (confirm('Are you sure you want to delete this image?')) {
			return true;
		} else {
			return false;
		}
	});

	// initial
	resizePanel();
	
  // preview pane height
	$('.preview-pane .preview').css('height',$('.main-section .block').height()-40+'px');
	
	// resize the panel as browser is resized
	$(window).resize(function() {
		resizePanel();
	});
	
	function resizePanel() {
		// set the width
		var _width = 
			($('.main-section').width() - $('.main-section .block').width()) - 
			($('.main-section').width() - $('.main-section .block').width() - $('.help').width()) + 'px';
			
		$('.preview-pane .preview').css('width', _width);
		
		// set the left
		_left = '-' + $('.preview-pane .preview').width() - 80 + 'px';
		$('.preview-pane .preview').css('left',_left);
	}

  // click on the list
	$('.list-view > li').click(function(){
		var url = $(this).find('.more').attr('href');
		if (!$(this).parents('li').hasClass('current')) {
			$('.preview-pane .preview').animate({left: _left}, 300, function(){
				$(this).find('.desc').hide();
				$(this).animate({left: '-32px'}, 300);
				$(url).show();
			});
		} else {
			$('.preview-pane .preview').animate({left: _left}, 300);
		}
		$(this).toggleClass('current').siblings().removeClass('current');
		return false;
  });
	
	// close the panel
  $('.preview-pane .preview .close').live('click', function(){
		$('.preview-pane .preview').animate({left: _left}, 300);
		$('.list-view li').removeClass('current');
		return false;
  });

	// floating menu and preview pane
	if ($('.preview-pane .preview').length>0) { 
		previewYloc = parseInt($('.preview-pane .preview').css('top').substring(0,$('.preview').css('top').indexOf('px')), 10); 
	}
	$(window).scroll(function () {
		var offset = 0;
		if ($('.preview-pane .preview').length>0) {
			offset = previewYloc+$(document).scrollTop()+400>=$('.main-section').height()? offset=$('.main-section').height()-400 : previewYloc+$(document).scrollTop();
			$('.content').animate({top:offset},{duration:500,queue:false});
    }
	});
		
	// messages
	$('.message').hide().append('<span class=\'close_me\' title=\'Dismiss\'></span>').fadeIn('slow');
	$('.message .close').hover(
		function() { $(this).addClass('hover'); },
		function() { $(this).removeClass('hover'); }
	);
		
	// click functions
	$('.close_me').click(function() {
		$(this).parent().fadeOut('slow', function() { $(this).remove(); });
	});
	
	$('.delete').click(function(e) {
		e.preventDefault();
		$.post($(this).attr('href'));
		return false;phew
	});

	$('#submit_point').click(function(e) {
		e.preventDefault();
		var dataString = $('#add_point').serialize();	
		$.post('/point/add', dataString,
			function(data) {
				window.location.href = '/trails';
		 	},'html'
		);
		return false;
	});

	$('#submit_edit').click(function(e) {
		e.preventDefault();
		alert('CRICKED');
		var dataString = $('#edit_point').serialize();	
		$.post('/point/update/'+$(this).attr('href'), dataString,
			function(data) {
				alert('WE BACK');
		 	},'html'
		);
		return false;
	});

});
