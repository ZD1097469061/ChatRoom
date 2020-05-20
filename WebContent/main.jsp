<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="safe.jsp"%>
<html>
<head>
<title>聊天室</title>
<link href="CSS/style.css" rel="stylesheet">
<link href="CSS/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="CSS/semantic.css" media="screen" title="no title" charset="utf-8">
<link rel="stylesheet" href="CSS/list_custom.css"  media="screen" title="no title" charset="utf-8">
<script type="text/javascript" src="${ pageContext.request.contextPath }/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="${ pageContext.request.contextPath }/js/semantic.js"></script>
<script type="text/javascript" src="${ pageContext.request.contextPath }/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${ pageContext.request.contextPath }/js/jquery.qqFace.js"></script>
<script type="text/javascript">
	var sysBBS = "<span style='font-size:14px; line-height:30px;'>欢迎进入聊天室，请遵守聊天室规则，不要使用不文明用语。</span><br><span style='line-height:22px;'>";
	var updateLog="";
	window.setInterval("showContent();",1000);
	window.setInterval("showOnLine();",10000);
	window.setInterval("check();",1000);
	
	$(function(){
		showOnLine();
		showContent();
		check();
		
		$('.emotion').qqFace({
            assign: 'message',
        });
	});
	
	function check(){
		$.post("${pageContext.request.contextPath}/user?method=check",function(data){
			if(data == 1){
				// 提示用户下线了
				alert("您已经被踢下线了!");
				// 回到登录页面!
				window.location = "login.jsp";
			}
		});
	}
	
	// 显示在线人员列表
	function showOnLine(){
		// 异步发送请求 获取在线人员列表
		// Jquery发送异步请求
		$.post("${pageContext.request.contextPath}/online.jsp?"+new Date().getTime(),function(data){
			// $("#online") == document.getElementById("online");
			$("#online").html(data);
		});
	}
	
	// 显示聊天的内容
	function showContent(){
		$.post("${pageContext.request.contextPath}/user?"+new Date().getTime(),{'method':'getMessage'},function(data){
			$("#content").html(sysBBS+updateLog+data);
		});
	}
	
	function set(selectPerson){	//自动添加聊天对象
		if(selectPerson != "${existUser.username}"){
			form1.to.value=selectPerson;
		}else{
			alert("请重新选择聊天对象！");
		}
	}
	
	function send(){
		if(form1.to.value==""){
			set('所有人');
		}
		if(form1.message.value==""){
			alert("发送信息不可以为空！");
			form1.message.focus();
			return false;
		}
		var str = form1.message.value;

        var text = replace_em(str);
        
        form1.message.value=text;

		$.post("${pageContext.request.contextPath}/user?"+new Date().getTime(),$("#form1").serialize(),function(data){
			$("#content").html(sysBBS+updateLog+data+"</span>");
		});
		$("input[name='message']").val("").focus();
		setTimeout('$("#content").scrollTop($("#content").height()*10000)',500);
		
	}
	
	function exit(){
		alert("欢迎您下次光临！");
		window.location.href="${pageContext.request.contextPath}/user?method=exit";
	}
	
	function checkScrollScreen(){
		if(!$("#scrollScreen").attr("checked")){
	    	$("#content").css("overflow-y","scroll");
	    }else{
	    	$("#content").css("overflow-y","hidden");
	        $("#content").scrollTop($("#content").height()*10000);
	    }
	    setTimeout('checkScrollScreen()',500);
	}
	function replace_em(str) {
        str = str.replace(/\</g, '&lt;');
        str = str.replace(/\>/g, '&gt;');
        str = str.replace(/\n/g, '<br/>');
        str = str.replace(/\[em_([0-9]*)\]/g, '<img src="face/$1.gif" border="0" />');
        return str;
    }
</script>
<style type="text/css">
	.ui.segment{
		    text-align: center;
		    background-color: #fff;
		    border-radius: 20px;
		    margin: auto;
		    position: absolute;
		    top: 0;
		    left: 0;
		    right: 0;
		    bottom: 0;
	}
</style>
</head>
<body style="background:url(images/chat_bj.jpg);background-size: cover;">
<div class="ui segment" style="width:800;height:720" align="center" >
	<table class="ui table" width="778" height="120" border="0" align="center"
		cellpadding="0" cellspacing="0" style="background:url(images/main_top.jpg)" >
		<tr>
			<td>&nbsp;</td>
		</tr>	
	</table>
	<table class="ui table" width="778" border="0" align="center"
		cellpadding="0" cellspacing="0">
		<tr>
			<td class="ui header" width="140" valign="top" bgcolor="#f6fded" style="padding:5px;"><font size="3">在线人员列表</font></td>
			<td class="ui header" width="639" valign="top"
				background="images/main_bj.jpg" bgcolor="#FFFFFF"
				style="padding:5px; ">
				<div style="overflow:hidden"><font size="3">聊天内容</font></div></td>
		</tr>
		<tr>
			<td width="140" valign="top" bgcolor="#f6fded" id="online" style="padding:5px;overflow:auto"></td>
			<td width="639" height="200px" valign="top"
				background="images/main_bj.jpg" bgcolor="#FFFFFF"
				style="padding:5px; ">
				<div style="height:290px;overflow-x:hidden;overflow-y:hidden" id="content"></div></td>
		</tr>

	</table>
	<table class="ui table" width="778" height="150" border="0" align="center"
		cellpadding="0" cellspacing="0" style="background:#F7F0E9">

		<form action="" id="form1" name="form1" method="post">
			<input type="hidden" name="method" value="sendMessage"/>
			<tr>
				<td height="30" align="left">
					<div class="ui labeled input">
						<input name="from" type="hidden" value="${existUser.username}" />
							<div class="ui label">${existUser.username} 对</div> 
						<input name="to" type="text" value="所有人" size="20" readonly="readonly"> 
							<div class="ui label">说:</div>
					</div>
				</td>
				<td>
					<span class="emotion glyphicon glyphicon-plus" style="font-size: 15px" title="添加表情"></span>
				</td>
				<td align="left">
				<label>字体颜色：</label>
				 <select name="color" size="1" class="ui labeled dropdown" id="select">
						<option selected style="background-color:#000000;color:#000000">黑色</option>
						<option style="background-color:#FF0000;color:#FF0000" value="FF0000">红色</option>
						<option style="background-color:#009900;color:#009900" value="009900">绿色</option>
						<option style="background-color:#ff9900;color:#ff9900" value="ff9900">黄色</option>
						<option style="background-color:#0099ff;color:#0099ff" value="0099ff">蓝色</option>
						<option style="background-color:#9900ff;color:#9900ff" value="9900ff">紫色</option>
						<option style="background-color:#ff0099;color:#ff0099" value="ff0099">粉色</option>
				</select>
				</td>
				<td align="left">
					<div class="ui toggle checkbox">
						<input name="scrollScreen" type="checkbox" id="scrollScreen" onClick="checkScrollScreen()" value="1" checked>
						<label for="scrollScreen">禁止滚屏</label>
					</div>
				</td>
			</tr>
			
			<tr>

				<td width="549" align="left" colspan="6">
				<div class="ui labeled action input">
					<div class="ui label"><br><br>信<br>息</div>
					<input name="message" id="message" type="text" style="width:620px;height:90px;font-size:20px"
						onKeyDown="if(event.keyCode==13){send();}">
					<input name="Submit2" type="button" class="ui teal right button" value="发送"
					onClick="send()">
				</div>
				</td>
			</tr>

			<tr>
				<td colspan="2" align="center" class="word_dark">&nbsp;
					</td>				
				<td align="right" colspan="4"><input name="button_exit" type="button"
					class="tiny ui circular red right floated button" value="退出聊天室" onClick="exit()">
				</td>
			</tr>
		</form>
	</table>
</div>
</body>
</html>
