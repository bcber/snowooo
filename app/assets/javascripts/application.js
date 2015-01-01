//= require jquery_ujs
//= require social-share-button
//= require ckeditor/init
//= require_tree .

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

    expandEmail: function(ele){
        ele = $(ele);
        $('.list-group-item').removeClass('active');
        $(ele).addClass("active");
        messageid = ele.data("message");
        senderid = ele.data("senderid");
        sendername = ele.data("sendername");
        content = ele.data("content");
        time = ele.data("time");
        readed = ele.data("readed");

        sender_url = '/u/'+senderid;
        $("#mail-title").html("<a href='"+sender_url+"'>"+sendername+"</a>");
        $("#mail-time").html(time);
        $("#mail-content").html(content);
        $("#mail-reply").attr('href','/messages/new?receiver='+senderid);

        if(!readed){
            Application.markMailAsRead(ele,messageid);
        }
    },
    markMailAsRead:function(ele,messageid){
        $.post('/messages/readed',{message:messageid}).success(function(){
            $(ele).addClass("mail-readed");
            var count = $("#mail-unreaded-count").data("count");
            console.log(count);
            $("#mail-unreaded-count").data("count",count - 1).html(count-1);
            $(ele).data("readed",true);
        });
    }
}

$(function() {

    var opts = {
        lines: 12, // The number of lines to draw
        length: 20, // The length of each line
        width: 10, // The line thickness
        radius: 30, // The radius of the inner circle
        corners: 1, // Corner roundness (0..1)
        rotate: 0, // The rotation offset
        direction: 1, // 1: clockwise, -1: counterclockwise
        color: '#000', // #rgb or #rrggbb or array of colors
        speed: 1, // Rounds per second
        trail: 60, // Afterglow percentage
        shadow: false, // Whether to render a shadow
        hwaccel: false, // Whether to use hardware acceleration
        className: 'spinner', // The CSS class to assign to the spinner
        zIndex: 2e9, // The z-index (defaults to 2000000000)
        top: '50%', // Top position relative to parent
        left: '50%' // Left position relative to parent
    };


    $("img.lazy").lazyload({
        effect : "fadeIn"
    });

    $(".show-description-detail").click(function(){
        console.log("click show");
        $(".description-short").hide();
        $(".description-detail").removeClass('hide');
        $(this).hide();
    });

    $(".recent_post_link").on("ajax:beforeSend",function(){
        var target = document.getElementById('recent_posts');
        var spinner = new Spinner(opts).spin(target);

        $("#recent_posts").removeClass("animated fadeInDown");

    }).on("ajax:complete",function(){
        $(".recent_post_link").removeClass("active");
        $(this).addClass("active");
        $("#recent_posts").addClass("animated fadeInDown");
    });

    $('[data-toggle="popover"]').popover();

    $('.owl-carousel').owlCarousel({
        slideSpeed : 300,
        paginationSpeed : 400,
        singleItem:true
    });

    var ratemessages = ["很差","较差","还行","推荐","力荐"];

    $('.rate').each(function(){

        $ele = $(this);
        $ele.raty({
            score: function(){
                var rate = $ele.data('rate');
                if($ele.data('nomsg')){
                    return rate;
                }
                if(rate > 0){
                    $ele.append("<span class='message'>("+ratemessages[rate-1]+")</span>");
                }
                return rate;
            },
            path: 'http://cdn.snowooo.com/plugins/raty/images',
            readOnly: $(this).data('readonly')
        });

    });

    $('.rateable').raty({
        path: 'http://cdn.snowooo.com/plugins/raty/images',
        score:function(){
            var score = $(this).data('rate');
            if(score>0){
                $('.rateable-message').html('您给了'+score+'分的评价');
            }
            return score;
        },
        click:function(score,evt){
            $('.rateable-message').html("您给了"+score+"分的评价");
            $("#review_stars").val(score);
        }
    });
});

