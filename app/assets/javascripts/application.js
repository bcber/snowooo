// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.

//= require jquery_ujs
//= require turbolinks
//= require social-share-button
//= require_tree .

var App = function () {

    function handleIEFixes() {
        //fix html5 placeholder attribute for ie7 & ie8
        if (jQuery.browser.msie && jQuery.browser.version.substr(0, 1) < 9) { // ie7&ie8
            jQuery('input[placeholder], textarea[placeholder]').each(function () {
                var input = jQuery(this);

                jQuery(input).val(input.attr('placeholder'));

                jQuery(input).focus(function () {
                    if (input.val() == input.attr('placeholder')) {
                        input.val('');
                    }
                });

                jQuery(input).blur(function () {
                    if (input.val() == '' || input.val() == input.attr('placeholder')) {
                        input.val(input.attr('placeholder'));
                    }
                });
            });
        }
    }

    function handleBootstrap() {
        /*Bootstrap Carousel*/
        jQuery('.carousel').carousel({
            interval: 15000,
            pause: 'hover'
        });

        /*Tooltips*/
        jQuery('.tooltips').tooltip();
        jQuery('.tooltips-show').tooltip('show');
        jQuery('.tooltips-hide').tooltip('hide');
        jQuery('.tooltips-toggle').tooltip('toggle');
        jQuery('.tooltips-destroy').tooltip('destroy');

        /*Popovers*/
        jQuery('.popovers').popover();
        jQuery('.popovers-show').popover('show');
        jQuery('.popovers-hide').popover('hide');
        jQuery('.popovers-toggle').popover('toggle');
        jQuery('.popovers-destroy').popover('destroy');
    }

    function handleSearch() {
        jQuery('.search').click(function () {
            if(jQuery('.search-btn').hasClass('fa-search')){
                jQuery('.search-open').fadeIn(500);
                jQuery('.search-btn').removeClass('fa-search');
                jQuery('.search-btn').addClass('fa-times');
            } else {
                jQuery('.search-open').fadeOut(500);
                jQuery('.search-btn').addClass('fa-search');
                jQuery('.search-btn').removeClass('fa-times');
            }
        });
    }

    function handleToggle() {
        jQuery('.list-toggle').on('click', function() {
            jQuery(this).toggleClass('active');
        });

        /*
         jQuery('#serviceList').on('shown.bs.collapse'), function() {
         jQuery(".servicedrop").addClass('glyphicon-chevron-up').removeClass('glyphicon-chevron-down');
         }

         jQuery('#serviceList').on('hidden.bs.collapse'), function() {
         jQuery(".servicedrop").addClass('glyphicon-chevron-down').removeClass('glyphicon-chevron-up');
         }
         */
    }

    function handleSwitcher() {
        var panel = jQuery('.style-switcher');

        jQuery('.style-switcher-btn').click(function () {
            jQuery('.style-switcher').show();
        });

        jQuery('.theme-close').click(function () {
            jQuery('.style-switcher').hide();
        });

        jQuery('li', panel).click(function () {
            var color = jQuery(this).attr("data-style");
            var data_header = jQuery(this).attr("data-header");
            setColor(color, data_header);
            jQuery('.list-unstyled li', panel).removeClass("theme-active");
            jQuery(this).addClass("theme-active");
        });

        var setColor = function (color, data_header) {
            jQuery('#style_color').attr("href", "assets/css/themes/" + color + ".css");
            if(data_header == 'light'){
                jQuery('#style_color-header-1').attr("href", "assets/css/themes/headers/header1-" + color + ".css");
                jQuery('#logo-header').attr("src", "assets/img/logo1-" + color + ".png");
                jQuery('#logo-footer').attr("src", "assets/img/logo2-" + color + ".png");
            } else if(data_header == 'dark'){
                jQuery('#style_color-header-2').attr("href", "assets/css/themes/headers/header2-" + color + ".css");
                jQuery('#logo-header').attr("src", "assets/img/logo1-" + color + ".png");
                jQuery('#logo-footer').attr("src", "assets/img/logo2-" + color + ".png");
            }
        }
    }

    function handleBoxed() {
        jQuery('.boxed-layout-btn').click(function(){
            jQuery(this).addClass("active-switcher-btn");
            jQuery(".wide-layout-btn").removeClass("active-switcher-btn");
            jQuery("body").addClass("boxed-layout container");
        });
        jQuery('.wide-layout-btn').click(function(){
            jQuery(this).addClass("active-switcher-btn");
            jQuery(".boxed-layout-btn").removeClass("active-switcher-btn");
            jQuery("body").removeClass("boxed-layout container");
        });
    }

    function handleHeader() {
        jQuery(window).scroll(function() {
            if (jQuery(window).scrollTop()> 10   ){
                jQuery(".header-fixed .header").addClass("header-fixed-shrink");
                jQuery(".header-fixed .header .topbar .loginbar").hide();
                jQuery(".navbar-brand").css('visibility','visible');
            }
            else {
                jQuery(".header-fixed .header").removeClass("header-fixed-shrink");
                jQuery(".header-fixed .header .topbar .loginbar").show();
                jQuery(".navbar-brand").css('visibility','hidden');
            }
        });
    }

    return {
        init: function () {
            handleBootstrap();
            handleIEFixes();
            handleSearch();
            handleToggle();
            handleSwitcher();
            handleBoxed();
            handleHeader();
        },

        initSliders: function () {
            jQuery('#clients-flexslider').flexslider({
                animation: "slide",
                easing: "swing",
                animationLoop: true,
                itemWidth: 1,
                itemMargin: 1,
                minItems: 2,
                maxItems: 9,
                controlNav: false,
                directionNav: false,
                move: 2
            });

            jQuery('#clients-flexslider1').flexslider({
                animation: "slide",
                easing: "swing",
                animationLoop: true,
                itemWidth: 1,
                itemMargin: 1,
                minItems: 2,
                maxItems: 5,
                controlNav: false,
                directionNav: false,
                move: 2
            });

            jQuery('#photo-flexslider').flexslider({
                animation: "slide",
                controlNav: false,
                animationLoop: false,
                itemWidth: 80,
                itemMargin: 0
            });

            jQuery('#testimonal_carousel').collapse({
                toggle: false
            });
        },

        initFancybox: function () {
            jQuery(".fancybox-button").fancybox({
                groupAttr: 'data-rel',
                prevEffect: 'none',
                nextEffect: 'none',
                closeBtn: true,
                helpers: {
                    title: {
                        type: 'inside'
                    }
                }
            });

            jQuery(".iframe").fancybox({
                maxWidth    : 800,
                maxHeight   : 600,
                fitToView   : false,
                width       : '70%',
                height      : '70%',
                autoSize    : false,
                closeClick  : false,
                openEffect  : 'none',
                closeEffect : 'none'
            });
        },

        initBxSlider: function () {
            jQuery('.bxslider').bxSlider({
                maxSlides: 4,
                minSlides: 4,
                slideWidth: 360,
                slideMargin: 10,
            });

            jQuery('.bxslider1').bxSlider({
                minSlides: 3,
                maxSlides: 3,
                slideWidth: 360,
                slideMargin: 10
            });

            jQuery('.bxslider2').bxSlider({
                minSlides: 2,
                maxSlides: 2,
                slideWidth: 360,
                slideMargin: 10
            });
        },

        initCounter: function () {
            jQuery('.counter').counterUp({
                delay: 10,
                time: 1000
            });
        },

        initParallaxBg: function () {
            jQuery('.parallaxBg').parallax("50%", 0.2);
            jQuery('.parallaxBg1').parallax("50%", 0.4);
        }

    };

}();

window.Application = {
    likeable: function(el){
        $el = $(el);
        likeable_type = $el.data("type");
        likeable_id = $el.data("id");
        likes_count = parseInt($el.data("count"));
        if($el.data("state") != "liked"){
            $.ajax({
                url: "/likes",
                type: "POST",
                data:{
                    type: likeable_type,
                    id: likeable_id
                }
            }).fail(function(){
                location.href = '/login';
            }).done(function(){
                likes_count += 1;
                $el.data('count',likes_count);
                Application.likeableAsLiked(el);
            });
        }else{
            $.ajax({
                url : "/likes/"+likeable_id,
                type : "DELETE",
                data:{
                    type: likeable_type
                }
            }).fail(function(){
               location.href= '/login';
            }).done(function(){
                if(likes_count > 0)
                    likes_count -= 1;

                $el.data("state","").data('count', likes_count).attr("title", "赞");

                if(likes_count == 0)
                    $('span',el).text("赞");
                else
                    $('span',el).text(likes_count+"人已赞");

                $("i.fa",el).attr("class","fa fa-thumbs-o-up");
            });
        }
        return false;
    },

    likeableAsLiked:function(ele){
        var likes_count = $(ele).data("count");
        $(ele).data("state","liked").attr("title","取消赞");
        $('span', ele).text(likes_count+ '人赞(已赞)');
        $('i.fa',ele).attr('class','fa fa-thumbs-up');
    },

    search_url:"http://zhannei.baidu.com/cse/search?entry=1&s=4194692985026132807",

    search:function(ele){
        var text = $(".search-open input").val().trim();
        if(text == ""){
            alert("请输入要搜索的内容");
            return;
        }
        var url  = Application.search_url+"&q="+text;
        location.href = url;
    }
}

$(document).on('page:change',function(){
    $('.show-description-detail').click(function(){
        $('.description-short').hide();
        $('.description-detail').removeClass('hide');
        $(this).hide();
    });
    $("img.lazy").lazyload({
        effect : "fadeIn"
    });
});

$(function() {
    $("img.lazy").lazyload({
        effect : "fadeIn"
    });
});