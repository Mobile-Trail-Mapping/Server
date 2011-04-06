var menuYloc = null;
var previewYloc = null;
var _left = null;

$(document).ready(function() {

  // small initial changes
  $('#header #nav li:last').addClass('nobg');
  $('.block-head ul').each(function() { $('li:first', this).addClass('nobg'); });
  $('.list-view > li').hover(function() {
    $(this).find('.tools').show();
  }, function() {
    $(this).find('.tools').hide();
  });
  $('.list-view-problem > li').hover(function() {
    $(this).find('.tools').show();
  }, function() {
    $(this).find('.tools').hide();
  });
  $('.content').css('top',$(this).find("h1").height()+5+'px');
  $('.trail-desc').fadeTo('fast',0.5);
  $('.trail').mouseenter(function() {
    $(this).find('.trail-desc').fadeTo('fast',0.8);    
  }).mouseleave(function() {
    $(this).find('.trail-desc').fadeTo('fast',0.5);
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
    
    // set the gmaps
    $('#map_canvas').css('width', _width.replace('px','') - 10 + 'px');
    $('#map_canvas').css('height', '200px');
    
    // set the slider
    // $('div.anythingSlider').css('width', _width.replace('px','') - 10 + 'px');
  }
     
  // trail slideshow cycler
  $('.trail-slideshow').cycle({
    fx: 'fade', 
    speed: 1000, 
    next: '.trail-slideshow', 
    timeout: 4000 
  });
  
  // trail masonry
  $('#trails').masonry({
    columnWidth: 230, 
    animate: true,
    singleMode: true,
    animationOptions: {
      duration: 750,
      easing: 'linear',
      queue: false
    }
  });
  
  // click on the problem list
  $('.list-view-problem > li').click(function(){
    // gather the information
    var id = $(this).find('.more').attr('href').replace('#problem_','');
    var url = $(this).find('.more').attr('href');
    
    // post and get the json
    $.getJSON('/problem/get/' + id, function(data) {
        if(data) {
          // load the data into the panel
          $("#problem-title").html(data.problem.title);
          $("#problem-coords").html(data.problem.lat + ', ' + data.problem.long);
          $("#problem-desc").html(data.problem.desc)
          // pictures
          $("ul#slider").html("");
          $("ul#slider").append('<li><img src="http://s3.amazonaws.com/mtm_test_data/images/test/' + data.problem.pic + '" /></li>');
         
          $('#slider')
          	.anythingSlider({
          		startStopped : true,
          	})
          	.anythingSliderFx({
          		'.caption-top'    : [ 'caption-Top', '50px' ],
          		'.caption-right'  : [ 'caption-Right', '130px' ],
          		'.caption-bottom' : [ 'caption-Bottom', '50px' ],
          		'.caption-left'   : [ 'caption-Left', '130px' ]
          	})
          	.find('div[class*=caption]')
          		.css({ position: 'absolute' })
          		.prepend('<span class="close">x</span>')
          		.find('.close').click(function(){
          			var cap = $(this).parent(),
          				ani = { bottom : -50 }; // bottom
          			if (cap.is('.caption-top')) { ani = { top: -50 }; }
          			if (cap.is('.caption-left')) { ani = { left: -150 }; }
          			if (cap.is('.caption-right')) { ani = { right: -150 }; }
          			cap.animate(ani, 400, function(){ cap.hide(); } );
          	});
        }
    });
        
    // slide the panel out
    if (!$(this).parents('li').hasClass('current')) {
      $('.preview-pane .preview').animate({left: _left}, 300, function(){
        $(this).animate({left: '-32px'}, 300);
        $(url).show();
      });
    } else {
      $('.preview-pane .preview').animate({left: _left}, 300);
    }
    $(this).toggleClass('current').siblings().removeClass('current');

    return false;
  });

  // click on the trail list
  $('.list-view > li').click(function(){
    // gather the information
    var url = $(this).find('.more').attr('href');
    var id = $(this).find('.more').attr('href').replace('#point_','');
    var name = $('.trail-name').text();
    
    // post and get the json
    $.getJSON('/trails/get/' + name + '/point/' + id, function(data) {
        if(data) {
          // load the data into the panel
          $("#trail-name").html(data.point.name);
          $("#trail-coords").html(data.point.lat + ', ' + data.point.long);
          $("#trail-desc").html(data.point.desc)
          // pictures
          if(data.point.photos) {  
            $("ul#slider").html("");
            $.each(data.point.photos, function(i) {
              $("ul#slider").append('<li><img src="' + data.point.photos[i] + '" /></li>');
            });       
             
            $('#slider')
            	.anythingSlider({
            		startStopped : true,
            	})
            	.anythingSliderFx({
            		'.caption-top'    : [ 'caption-Top', '50px' ],
            		'.caption-right'  : [ 'caption-Right', '130px' ],
            		'.caption-bottom' : [ 'caption-Bottom', '50px' ],
            		'.caption-left'   : [ 'caption-Left', '130px' ]
            	})
            	.find('div[class*=caption]')
            		.css({ position: 'absolute' })
            		.prepend('<span class="close">x</span>')
            		.find('.close').click(function(){
            			var cap = $(this).parent(),
            				ani = { bottom : -50 }; // bottom
            			if (cap.is('.caption-top')) { ani = { top: -50 }; }
            			if (cap.is('.caption-left')) { ani = { left: -150 }; }
            			if (cap.is('.caption-right')) { ani = { right: -150 }; }
            			cap.animate(ani, 400, function(){ cap.hide(); } );
            	});
            }
        }
    });    
    
    // slide the panel out
    if (!$(this).parents('li').hasClass('current')) {
      $('.preview-pane .preview').animate({left: _left}, 300, function(){
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
    $('.list-view-problem li').removeClass('current');
    return false;
  });

  // floating menu and preview pane
  if ($('.preview-pane .preview').length>0) { 
    previewYloc = parseInt($('.preview-pane .preview').css('top').substring(0,$('.preview').css('top').indexOf('px')), 10); 
  }
  // float the menu when the window scrolls
  $(window).scroll(function () {
    var offset = 0;
    var pane_height = $('.preview').height();
    console.log(pane_height);
    if ($('.preview-pane .preview').length>0) {
      offset = previewYloc + $(document).scrollTop() + 400 >= $('.main-section').height() ? offset = $('.main-section').height()-400 : previewYloc + $(document).scrollTop() + 55;
      $('.content').animate({top:offset},{duration:500,queue:false});
    }
  });
    
  // messages
  $('.message').hide().append('<span class=\'close-me\' title=\'Dismiss\'></span>').fadeIn('slow');
  $('.message .close').hover(
    function() { $(this).addClass('hover'); },
    function() { $(this).removeClass('hover'); }
  );
    
  // click functions
  $('.close-me').click(function() {
    $(this).parent().fadeOut('slow', function() { $(this).remove(); });
  });
  
  $('.delete').click(function(e) {
    e.preventDefault();
    $.post($(this).attr('href'));
    return false;phew
  });

  $('#submit_point').click(function(e) {
    e.preventDefault();
    alert("Add?");
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
