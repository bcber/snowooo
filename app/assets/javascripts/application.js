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

    search_url:"http://zhannei.baidu.com/cse/search?entry=1&s=4194692985026132807",

    search:function(ele){
        var text = $(".search-open input").val().trim();
        if(text == ""){
            alert("请输入要搜索的内容");
            return;
        }
        var url  = Application.search_url+"&q="+text;
        location.href = url;
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
});

