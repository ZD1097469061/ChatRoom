<%@page import="com.service.UserService"%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<div class="ui bulleted list" style="height:250px;overflow:auto">
	<div class="item" ><a  href="#" onclick="set('所有人')"><font size="2"><i class="tags icon"></i>所有人</font></a>
	<div class="list">
	<c:forEach var="entry" items="${ userMap }">
		<a class="item" >
		<a href="#" onclick="set('${ entry.key.username }')"><i class="tag icon"></i>${ entry.key.username }</a>
		<c:if test="${ existUser.type == 'admin' and entry.key.type != 'admin'}">
			<a href="${ pageContext.request.contextPath }/user?method=kick&id=${ entry.key.id }"><i class="remove user icon"></i></a>
		</c:if>
		</a>
	</c:forEach>
	</div>
	</div>
</div>
<div class="item"><i class="user icon"></i>当前在线[<font color="#FF6600">${ fn:length(userMap) }</font>]人</div>