!function(t,e,n,a){"use strict";Foundation.libs.slider={name:"slider",version:"5.3.0",settings:{start:0,end:100,step:1,initial:null,display_selector:"",vertical:!1,on_change:function(){}},cache:{},init:function(t,e,n){Foundation.inherit(this,"throttle"),this.bindings(e,n),this.reflow()},events:function(){var n=this;t(this.scope).off(".slider").on("mousedown.fndtn.slider touchstart.fndtn.slider pointerdown.fndtn.slider","["+n.attr_name()+"]:not(.disabled, [disabled]) .range-slider-handle",function(e){n.cache.active||(e.preventDefault(),n.set_active_slider(t(e.target)))}).on("mousemove.fndtn.slider touchmove.fndtn.slider pointermove.fndtn.slider",function(e){n.cache.active&&(e.preventDefault(),t.data(n.cache.active[0],"settings").vertical?n.calculate_position(n.cache.active,e.pageY||e.originalEvent.clientY||e.originalEvent.touches[0].clientY||e.currentPoint.y):n.calculate_position(n.cache.active,e.pageX||e.originalEvent.clientX||e.originalEvent.touches[0].clientX||e.currentPoint.x))}).on("mouseup.fndtn.slider touchend.fndtn.slider pointerup.fndtn.slider",function(t){n.remove_active_slider()}).on("change.fndtn.slider",function(t){n.settings.on_change()}),n.S(e).on("resize.fndtn.slider",n.throttle(function(t){n.reflow()},300))},set_active_slider:function(t){this.cache.active=t},remove_active_slider:function(){this.cache.active=null},calculate_position:function(e,n){var a=this,i=t.data(e[0],"settings"),s=(t.data(e[0],"handle_l"),t.data(e[0],"handle_o"),t.data(e[0],"bar_l")),r=t.data(e[0],"bar_o");requestAnimationFrame(function(){var t;t=Foundation.rtl&&!i.vertical?a.limit_to((r+s-n)/s,0,1):a.limit_to((n-r)/s,0,1),t=i.vertical?1-t:t;var o=a.normalized_value(t,i.start,i.end,i.step);a.set_ui(e,o)})},set_ui:function(e,n){var a=t.data(e[0],"settings"),i=t.data(e[0],"handle_l"),s=t.data(e[0],"bar_l"),r=this.normalized_percentage(n,a.start,a.end),o=r*(s-i)-1,l=100*r;Foundation.rtl&&!a.vertical&&(o=-o),o=a.vertical?-o+s-i+1:o,this.set_translate(e,o,a.vertical),a.vertical?e.siblings(".range-slider-active-segment").css("height",l+"%"):e.siblings(".range-slider-active-segment").css("width",l+"%"),e.parent().attr(this.attr_name(),n).trigger("change").trigger("change.fndtn.slider"),e.parent().children("input[type=hidden]").val(n),""!=a.input_id&&t(a.display_selector).each(function(){this.hasOwnProperty("value")?t(this).val(n):t(this).text(n)})},normalized_percentage:function(t,e,n){return(t-e)/(n-e)},normalized_value:function(t,e,n,a){var i=n-e,s=t*i,r=(s-s%a)/a,o=s%a,l=o>=.5*a?a:0;return r*a+l+e},set_translate:function(e,n,a){a?t(e).css("-webkit-transform","translateY("+n+"px)").css("-moz-transform","translateY("+n+"px)").css("-ms-transform","translateY("+n+"px)").css("-o-transform","translateY("+n+"px)").css("transform","translateY("+n+"px)"):t(e).css("-webkit-transform","translateX("+n+"px)").css("-moz-transform","translateX("+n+"px)").css("-ms-transform","translateX("+n+"px)").css("-o-transform","translateX("+n+"px)").css("transform","translateX("+n+"px)")},limit_to:function(t,e,n){return Math.min(Math.max(t,e),n)},initialize_settings:function(e){var n=t.extend({},this.settings,this.data_options(t(e).parent()));n.vertical?(t.data(e,"bar_o",t(e).parent().offset().top),t.data(e,"bar_l",t(e).parent().outerHeight()),t.data(e,"handle_o",t(e).offset().top),t.data(e,"handle_l",t(e).outerHeight())):(t.data(e,"bar_o",t(e).parent().offset().left),t.data(e,"bar_l",t(e).parent().outerWidth()),t.data(e,"handle_o",t(e).offset().left),t.data(e,"handle_l",t(e).outerWidth())),t.data(e,"bar",t(e).parent()),t.data(e,"settings",n)},set_initial_position:function(e){var n=t.data(e.children(".range-slider-handle")[0],"settings"),a=n.initial?n.initial:Math.floor(.5*(n.end-n.start)/n.step)*n.step+n.start,i=e.children(".range-slider-handle");this.set_ui(i,a)},set_value:function(e){var n=this;t("["+n.attr_name()+"]",this.scope).each(function(){t(this).attr(n.attr_name(),e)}),t(this.scope).attr(n.attr_name())&&t(this.scope).attr(n.attr_name(),e),n.reflow()},reflow:function(){var e=this;e.S("["+this.attr_name()+"]").each(function(){var n=t(this).children(".range-slider-handle")[0],a=t(this).attr(e.attr_name());e.initialize_settings(n),a?e.set_ui(t(n),parseFloat(a)):e.set_initial_position(t(this))})}}}(jQuery,window,window.document);