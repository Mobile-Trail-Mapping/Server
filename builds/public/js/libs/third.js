/*
 * jQuery Easing v1.1.1 - http://gsgd.co.uk/sandbox/jquery.easing.php
 *
 * Uses the built in easing capabilities added in jQuery 1.1
 * to offer multiple easing options
 *
 * Copyright (c) 2007 George Smith
 * Licensed under the MIT License:
 *   http://www.opensource.org/licenses/mit-license.php
 */

jQuery.extend(jQuery.easing, {
	easein: function(x, t, b, c, d) {
		return c*(t/=d)*t + b; // in
	},
	easeinout: function(x, t, b, c, d) {
		if (t < d/2) return 2*c*t*t/(d*d) + b;
		var ts = t - d/2;
		return -2*c*ts*ts/(d*d) + 2*c*ts/d + c/2 + b;		
	},
	easeout: function(x, t, b, c, d) {
		return -c*t*t/(d*d) + 2*c*t/d + b;
	},
	expoin: function(x, t, b, c, d) {
		var flip = 1;
		if (c < 0) {
			flip *= -1;
			c *= -1;
		}
		return flip * (Math.exp(Math.log(c)/d * t)) + b;		
	},
	expoout: function(x, t, b, c, d) {
		var flip = 1;
		if (c < 0) {
			flip *= -1;
			c *= -1;
		}
		return flip * (-Math.exp(-Math.log(c)/d * (t-d)) + c + 1) + b;
	},
	expoinout: function(x, t, b, c, d) {
		var flip = 1;
		if (c < 0) {
			flip *= -1;
			c *= -1;
		}
		if (t < d/2) return flip * (Math.exp(Math.log(c/2)/(d/2) * t)) + b;
		return flip * (-Math.exp(-2*Math.log(c/2)/d * (t-d)) + c + 1) + b;
	},
	bouncein: function(x, t, b, c, d) {
		return c - jQuery.easing['bounceout'](x, d-t, 0, c, d) + b;
	},
	bounceout: function(x, t, b, c, d) {
		if ((t/=d) < (1/2.75)) {
			return c*(7.5625*t*t) + b;
		} else if (t < (2/2.75)) {
			return c*(7.5625*(t-=(1.5/2.75))*t + .75) + b;
		} else if (t < (2.5/2.75)) {
			return c*(7.5625*(t-=(2.25/2.75))*t + .9375) + b;
		} else {
			return c*(7.5625*(t-=(2.625/2.75))*t + .984375) + b;
		}
	},
	bounceinout: function(x, t, b, c, d) {
		if (t < d/2) return jQuery.easing['bouncein'] (x, t*2, 0, c, d) * .5 + b;
		return jQuery.easing['bounceout'] (x, t*2-d,0, c, d) * .5 + c*.5 + b;
	},
	elasin: function(x, t, b, c, d) {
		var s=1.70158;var p=0;var a=c;
		if (t==0) return b;  if ((t/=d)==1) return b+c;  if (!p) p=d*.3;
		if (a < Math.abs(c)) { a=c; var s=p/4; }
		else var s = p/(2*Math.PI) * Math.asin (c/a);
		return -(a*Math.pow(2,10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )) + b;
	},
	elasout: function(x, t, b, c, d) {
		var s=1.70158;var p=0;var a=c;
		if (t==0) return b;  if ((t/=d)==1) return b+c;  if (!p) p=d*.3;
		if (a < Math.abs(c)) { a=c; var s=p/4; }
		else var s = p/(2*Math.PI) * Math.asin (c/a);
		return a*Math.pow(2,-10*t) * Math.sin( (t*d-s)*(2*Math.PI)/p ) + c + b;
	},
	elasinout: function(x, t, b, c, d) {
		var s=1.70158;var p=0;var a=c;
		if (t==0) return b;  if ((t/=d/2)==2) return b+c;  if (!p) p=d*(.3*1.5);
		if (a < Math.abs(c)) { a=c; var s=p/4; }
		else var s = p/(2*Math.PI) * Math.asin (c/a);
		if (t < 1) return -.5*(a*Math.pow(2,10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )) + b;
		return a*Math.pow(2,-10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )*.5 + c + b;
	},
	backin: function(x, t, b, c, d) {
		var s=1.70158;
		return c*(t/=d)*t*((s+1)*t - s) + b;
	},
	backout: function(x, t, b, c, d) {
		var s=1.70158;
		return c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b;
	},
	backinout: function(x, t, b, c, d) {
		var s=1.70158;
		if ((t/=d/2) < 1) return c/2*(t*t*(((s*=(1.525))+1)*t - s)) + b;
		return c/2*((t-=2)*t*(((s*=(1.525))+1)*t + s) + 2) + b;
	}
});

/* Copyright (c) 2007 Paul Bakaus (paul.bakaus@googlemail.com) and Brandon Aaron (brandon.aaron@gmail.com || http://brandonaaron.net)
 * Dual licensed under the MIT (http://www.opensource.org/licenses/mit-license.php)
 * and GPL (http://www.opensource.org/licenses/gpl-license.php) licenses.
 *
 * $LastChangedDate: 2007-10-06 20:11:15 +0200 (Sa, 06 Okt 2007) $
 * $Rev: 3581 $
 *
 * Version: @VERSION
 *
 * Requires: jQuery 1.2+
 */

(function($){
	
$.dimensions = {
	version: '@VERSION'
};

// Create innerHeight, innerWidth, outerHeight and outerWidth methods
$.each( [ 'Height', 'Width' ], function(i, name){
	
	// innerHeight and innerWidth
	$.fn[ 'inner' + name ] = function() {
		if (!this[0]) return;
		
		var torl = name == 'Height' ? 'Top'    : 'Left',  // top or left
		    borr = name == 'Height' ? 'Bottom' : 'Right'; // bottom or right
		
		return num( this, name.toLowerCase() ) + num(this, 'padding' + torl) + num(this, 'padding' + borr);
	};
	
	// outerHeight and outerWidth
	$.fn[ 'outer' + name ] = function(options) {
		if (!this[0]) return;
		
		var torl = name == 'Height' ? 'Top'    : 'Left',  // top or left
		    borr = name == 'Height' ? 'Bottom' : 'Right'; // bottom or right
		
		options = $.extend({ margin: false }, options || {});
		
		return num( this, name.toLowerCase() )
				+ num(this, 'border' + torl + 'Width') + num(this, 'border' + borr + 'Width')
				+ num(this, 'padding' + torl) + num(this, 'padding' + borr)
				+ (options.margin ? (num(this, 'margin' + torl) + num(this, 'margin' + borr)) : 0);
	};
});

// Create scrollLeft and scrollTop methods
$.each( ['Left', 'Top'], function(i, name) {
	$.fn[ 'scroll' + name ] = function(val) {
		if (!this[0]) return;
		
		return val != undefined ?
		
			// Set the scroll offset
			this.each(function() {
				this == window || this == document ?
					window.scrollTo( 
						name == 'Left' ? val : $(window)[ 'scrollLeft' ](),
						name == 'Top'  ? val : $(window)[ 'scrollTop'  ]()
					) :
					this[ 'scroll' + name ] = val;
			}) :
			
			// Return the scroll offset
			this[0] == window || this[0] == document ?
				self[ (name == 'Left' ? 'pageXOffset' : 'pageYOffset') ] ||
					$.boxModel && document.documentElement[ 'scroll' + name ] ||
					document.body[ 'scroll' + name ] :
				this[0][ 'scroll' + name ];
	};
});

$.fn.extend({
	position: function() {
		var left = 0, top = 0, elem = this[0], offset, parentOffset, offsetParent, results;
		
		if (elem) {
			// Get *real* offsetParent
			offsetParent = this.offsetParent();
			
			// Get correct offsets
			offset       = this.offset();
			parentOffset = offsetParent.offset();
			
			// Subtract element margins
			offset.top  -= num(elem, 'marginTop');
			offset.left -= num(elem, 'marginLeft');
			
			// Add offsetParent borders
			parentOffset.top  += num(offsetParent, 'borderTopWidth');
			parentOffset.left += num(offsetParent, 'borderLeftWidth');
			
			// Subtract the two offsets
			results = {
				top:  offset.top  - parentOffset.top,
				left: offset.left - parentOffset.left
			};
		}
		
		return results;
	},
	
	offsetParent: function() {
		var offsetParent = this[0].offsetParent;
		while ( offsetParent && (!/^body|html$/i.test(offsetParent.tagName) && $.css(offsetParent, 'position') == 'static') )
			offsetParent = offsetParent.offsetParent;
		return $(offsetParent);
	}
});

function num(el, prop) {
	return parseInt($.css(el.jquery?el[0]:el,prop))||0;
};

})(jQuery);

/*
 * jQuery UI Accordion 1.6
 * 
 * Copyright (c) 2007 JÃ¶rn Zaefferer
 *
 * http://docs.jquery.com/UI/Accordion
 *
 * Dual licensed under the MIT and GPL licenses:
 *   http://www.opensource.org/licenses/mit-license.php
 *   http://www.gnu.org/licenses/gpl.html
 *
 * Revision: $Id: jquery.accordion.js 4876 2008-03-08 11:49:04Z joern.zaefferer $
 *
 */

;(function($) {
	
// If the UI scope is not available, add it
$.ui = $.ui || {};

$.fn.extend({
	accordion: function(options, data) {
		var args = Array.prototype.slice.call(arguments, 1);

		return this.each(function() {
			if (typeof options == "string") {
				var accordion = $.data(this, "ui-accordion");
				accordion[options].apply(accordion, args);
			// INIT with optional options
			} else if (!$(this).is(".ui-accordion"))
				$.data(this, "ui-accordion", new $.ui.accordion(this, options));
		});
	},
	// deprecated, use accordion("activate", index) instead
	activate: function(index) {
		return this.accordion("activate", index);
	}
});

$.ui.accordion = function(container, options) {
	
	// setup configuration
	this.options = options = $.extend({}, $.ui.accordion.defaults, options);
	this.element = container;
	
	$(container).addClass("ui-accordion");
	
	if ( options.navigation ) {
		var current = $(container).find("a").filter(options.navigationFilter);
		if ( current.length ) {
			if ( current.filter(options.header).length ) {
				options.active = current;
			} else {
				options.active = current.parent().parent().prev();
				current.addClass("current");
			}
		}
	}
	
	// calculate active if not specified, using the first header
	options.headers = $(container).find(options.header);
	options.active = findActive(options.headers, options.active);

	if ( options.fillSpace ) {
		var maxHeight = $(container).parent().height();
		options.headers.each(function() {
			maxHeight -= $(this).outerHeight();
		});
		var maxPadding = 0;
		options.headers.next().each(function() {
			maxPadding = Math.max(maxPadding, $(this).innerHeight() - $(this).height());
		}).height(maxHeight - maxPadding);
	} else if ( options.autoheight ) {
		var maxHeight = 0;
		options.headers.next().each(function() {
			maxHeight = Math.max(maxHeight, $(this).outerHeight());
		}).height(maxHeight);
	}

	options.headers
		.not(options.active || "")
		.next()
		.hide();
	options.active.parent().andSelf().addClass(options.selectedClass);
	
	if (options.event)
		$(container).bind((options.event) + ".ui-accordion", clickHandler);
};

$.ui.accordion.prototype = {
	activate: function(index) {
		// call clickHandler with custom event
		clickHandler.call(this.element, {
			target: findActive( this.options.headers, index )[0]
		});
	},
	
	enable: function() {
		this.options.disabled = false;
	},
	disable: function() {
		this.options.disabled = true;
	},
	destroy: function() {
		this.options.headers.next().css("display", "");
		if ( this.options.fillSpace || this.options.autoheight ) {
			this.options.headers.next().css("height", "");
		}
		$.removeData(this.element, "ui-accordion");
		$(this.element).removeClass("ui-accordion").unbind(".ui-accordion");
	}
}

function scopeCallback(callback, scope) {
	return function() {
		return callback.apply(scope, arguments);
	};
}

function completed(cancel) {
	// if removed while animated data can be empty
	if (!$.data(this, "ui-accordion"))
		return;
	var instance = $.data(this, "ui-accordion");
	var options = instance.options;
	options.running = cancel ? 0 : --options.running;
	if ( options.running )
		return;
	if ( options.clearStyle ) {
		options.toShow.add(options.toHide).css({
			height: "",
			overflow: ""
		});
	}
	$(this).triggerHandler("change.ui-accordion", [options.data], options.change);
}

function toggle(toShow, toHide, data, clickedActive, down) {
	var options = $.data(this, "ui-accordion").options;
	options.toShow = toShow;
	options.toHide = toHide;
	options.data = data;
	var complete = scopeCallback(completed, this);
	
	// count elements to animate
	options.running = toHide.size() == 0 ? toShow.size() : toHide.size();
	
	if ( options.animated ) {
		if ( !options.alwaysOpen && clickedActive ) {
			$.ui.accordion.animations[options.animated]({
				toShow: jQuery([]),
				toHide: toHide,
				complete: complete,
				down: down,
				autoheight: options.autoheight
			});
		} else {
			$.ui.accordion.animations[options.animated]({
				toShow: toShow,
				toHide: toHide,
				complete: complete,
				down: down,
				autoheight: options.autoheight
			});
		}
	} else {
		if ( !options.alwaysOpen && clickedActive ) {
			toShow.toggle();
		} else {
			toHide.hide();
			toShow.show();
		}
		complete(true);
	}
}

function clickHandler(event) {
	var options = $.data(this, "ui-accordion").options;
	if (options.disabled)
		return false;
	
	// called only when using activate(false) to close all parts programmatically
	if ( !event.target && !options.alwaysOpen ) {
		options.active.parent().andSelf().toggleClass(options.selectedClass);
		var toHide = options.active.next(),
			data = {
				instance: this,
				options: options,
				newHeader: jQuery([]),
				oldHeader: options.active,
				newContent: jQuery([]),
				oldContent: toHide
			},
			toShow = options.active = $([]);
		toggle.call(this, toShow, toHide, data );
		return false;
	}
	// get the click target
	var clicked = $(event.target);
	
	// due to the event delegation model, we have to check if one
	// of the parent elements is our actual header, and find that
	if ( clicked.parents(options.header).length )
		while ( !clicked.is(options.header) )
			clicked = clicked.parent();
	
	var clickedActive = clicked[0] == options.active[0];
	
	// if animations are still active, or the active header is the target, ignore click
	if (options.running || (options.alwaysOpen && clickedActive))
		return false;
	if (!clicked.is(options.header))
		return;

	// switch classes
	options.active.parent().andSelf().toggleClass(options.selectedClass);
	if ( !clickedActive ) {
		clicked.parent().andSelf().addClass(options.selectedClass);
	}

	// find elements to show and hide
	var toShow = clicked.next(),
		toHide = options.active.next(),
		//data = [clicked, options.active, toShow, toHide],
		data = {
			instance: this,
			options: options,
			newHeader: clicked,
			oldHeader: options.active,
			newContent: toShow,
			oldContent: toHide
		},
		down = options.headers.index( options.active[0] ) > options.headers.index( clicked[0] );
	
	options.active = clickedActive ? $([]) : clicked;
	toggle.call(this, toShow, toHide, data, clickedActive, down );

	return false;
};

function findActive(headers, selector) {
	return selector != undefined
		? typeof selector == "number"
			? headers.filter(":eq(" + selector + ")")
			: headers.not(headers.not(selector))
		: selector === false
			? $([])
			: headers.filter(":eq(0)");
}

$.extend($.ui.accordion, {
	defaults: {
		selectedClass: "selected",
		alwaysOpen: true,
		animated: 'slide',
		event: "click",
		header: "a",
		autoheight: true,
		running: 0,
		navigationFilter: function() {
			return this.href.toLowerCase() == location.href.toLowerCase();
		}
	},
	animations: {
		slide: function(options, additions) {
			options = $.extend({
				easing: "swing",
				duration: 300
			}, options, additions);
			if ( !options.toHide.size() ) {
				options.toShow.animate({height: "show"}, options);
				return;
			}
			var hideHeight = options.toHide.height(),
				showHeight = options.toShow.height(),
				difference = showHeight / hideHeight;
			options.toShow.css({ height: 0, overflow: 'hidden' }).show();
			options.toHide.filter(":hidden").each(options.complete).end().filter(":visible").animate({height:"hide"},{
				step: function(now) {
					var current = (hideHeight - now) * difference;
					if ($.browser.msie || $.browser.opera) {
						current = Math.ceil(current);
					}
					options.toShow.height( current );
				},
				duration: options.duration,
				easing: options.easing,
				complete: function() {
					if ( !options.autoheight ) {
						options.toShow.css("height", "auto");
					}
					options.complete();
				}
			});
		},
		bounceslide: function(options) {
			this.slide(options, {
				easing: options.down ? "bounceout" : "swing",
				duration: options.down ? 1000 : 200
			});
		},
		easeslide: function(options) {
			this.slide(options, {
				easing: "easeinout",
				duration: 700
			})
		}
	}
});

})(jQuery);
