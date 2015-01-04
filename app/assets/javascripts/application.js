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

    $(".new_comment").on("ajax:beforeSend",function(){
        var content = $(this).find("#comment_content");
        if(content.val() == ''){
           alert("内容不能为空");
           return false;
        }
        content.val("正在提交评论");
        content.attr("disabled",true);
    }).on("ajax:success",function(e,data,xhr,settings){
        var comment_count = parseInt($("#comment-container").data('comment-count'));
        $("#comment-container").data('comment-count', comment_count+1);
        $(".comment-count").html(comment_count+1);
        $("#comment-container").append(data);
    }).on("ajax:fail",function(){
        alert("提交评论失败!");
    }).on("ajax:complete",function(){
        var content = $(this).find("#comment_content");
        content.val("");
        content.attr("disabled",false);
    });


});

