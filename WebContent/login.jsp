<%@page  contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta charset="utf-8">
        <title>聊天室</title>
        <link rel="stylesheet" href="CSS/semantic.css" media="screen" title="no title" charset="utf-8">
        <link rel="stylesheet" href="CSS/list_custom.css"  media="screen" title="no title" charset="utf-8">
        <style type="text/css">
            body {
                background: url(images/background.jpg);
                background-size: cover;
            }

            .ui.grid.divided.segment.container{
                min-height: 400px;
                width:600px !important;
                border:rgba(255, 0, 0, 0);
                position: absolute;
                left: 50%;
                top:40%;
                transform: translate(-50%,-50%);
            }

            .five.wide.column {
                background: url(images/login_scene.jpg);
                background-size: cover;
                background-position: 60% 0%;
                height:400px;
            }

            form {
                margin-top: 60px;
            }
            h1,h3,h4{
                font-family: 'Play', sans-serif !important;

            }
        </style>
    </head>
    <body>
    	
        <div class="ui grid divided segment container">
            <div class="five wide column">

                <h4 class="ui inverted header">

                   <a href="${pageContext.request.contextPath }/main.jsp" style="color:#ffffff">首 页</a>
                </h4>

                <h1 class="ui inverted center aligned header" style="font-size: 28px;margin-top:55px">
                    <p class="sub header">
                        Welcome to
                    </p>
                    	聊天室
                </h1>

            </div>
            
            <div class="eleven wide column">
            	<p> &nbsp;</p>                                    
				<h3 align="center" style="color:red;">${error}</h3>
			
                <form class="ui form error segment" method="post"
                		action="${pageContext.request.contextPath }/user">
	    		<input type="hidden" name="method" value="login">
	    		
                	<div class="field">
							用户名
                    	<div class="ui left icon input">
          					<input type="text" required autofocus="" id="id_username" maxlength="254" name="username">
          					<i class="user icon"></i>
        				</div>
                    </div>
                        
                    <div class="field">
                    	密码
                    	<div class="ui left icon input">
							<input type="password" required id="id_password" name="password">
          					<i class="lock icon"></i>
        				</div>
        			</div>
                        
                    <button class="ui animated right floated button" type="submit" tabindex="0" >
                    	<div class="visible content">登录</div>
    						<div class="hidden content">
        							<i class="right arrow icon"></i>
    					</div>
    				</button>
    				<p> &nbsp;</p>
    				<h4 class="ui horizontal header divider">没有账户？</h4>
    				<a href="${pageContext.request.contextPath }/register.jsp" style="color:#000000;">
    						<div class="ui circular green right floated button">
      						前往注册
    						</div>
  					</a>
  					<p> &nbsp;</p>
  				
                </form>
            
            </div>
        </div>
    </body>
</html>