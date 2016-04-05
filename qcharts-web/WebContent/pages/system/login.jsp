<%@page import="com.netsteadfast.greenstep.util.LocaleLanguageUtils"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />


    <base href="<%=basePath%>">
    
    <title>bambooCORE</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="bambooCORE">
	<meta http-equiv="description" content="bambooCORE">

<style type="text/css">
<!--

.style1 {
	color: #585858;
	font-weight: bold;
}
.style2 {
	color: #F7982A;
	font-weight: bold;
	font-family:sans-serif;-webkit-text-size-adjust:100%;text-size-adjust:100%
}
.style3 {color: #084F01}
.style4 {color: #000000}


input {
    margin: 0px;
    border: 1px solid #111;
    background: #F2F2F2;
    -webkit-border-radius: 5px;
    border-radius: 5px;     
}

select {
    margin: 0px;
    border: 1px solid #111;
    background: url(./images/br_down.png) 96% no-repeat #F2F2F2;
    width: 250px;
    /* padding: 5px; */
    font-size: 16px;
    border: 1px solid #ccc;
    /* height: 34px; */
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    -webkit-border-radius: 5px;
    border-radius: 5px;
    font-family: Consolas,monaco,monospace;
}

.lighter {
    background: #498bf5;
    color: #ffffff;
    border: 1px solid #498bf5;
    font-weight: bold;
}

-->
</style>	
	
<script type="text/javascript">

function submit_login() {
	document.getElementById("loginTable").style.visibility="hidden";
	document.getElementById("pwaitTable").style.visibility="visible";
	document.loginForm.submit();
}

function redirectLogin(sel) {
	window.location = '<%=basePath%>login.action?lang=' + sel.value;
}

function pageMessage() {
	var pageMessage='<s:property value="pageMessage" escapeJavaScript="true"/>';
	if (null!=pageMessage && ''!=pageMessage && ' '!=pageMessage) {
		alert(pageMessage);
	}	
}
</script>
</head>  

<body leftmargin="0" topmargin="0">
<s:form name="loginForm" id="loginForm" action="login" method="post">
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td bgcolor="#ffffff"><img src="./images/original.jpg" width="220" height="30" /></td>
    </tr>
    <tr>
      <td height="480" bgcolor="#ffffff">
	  <center>
	  <table id="loginTable" width="550" border="0" cellpadding="2" cellspacing="2">	 
        <tr> 
          <td width="160" align="right"><span class="style1"><s:property value="getText('LOGIN_language')"/>:</span></td>
          <td width="160" align="left">
          	<select name="lang" id="lang" onchange="redirectLogin(this);">
          	<%
          	String defaultLang = (String)request.getAttribute("lang");
          	Map<String, Object> langs = LocaleLanguageUtils.getMap();
          	for (Map.Entry<String, Object> entry : langs.entrySet()) {
          	%>
          	<option value="<%=entry.getKey()%>" <% if ( entry.getKey().equals(defaultLang) ) { %> selected <% } %> ><%=String.valueOf( entry.getValue() )%></option>
          	<% 	
          	}
          	%>
          	</select>
          </td>
        </tr>  	   
        
        <!-- 2015-12-18 add https://github.com/billchen198318/bamboobsc/issues/5 -->
        <s:if test=" \"Y\" == loginCaptchaCodeEnable ">        
        <tr>
          <td width="160" align="right"><img src="./kaptcha.jpg?n=<%=System.currentTimeMillis()%>"/></td>
          <td width="160" align="left"><s:textfield name="captcha" id="captcha" maxLength="12" maxSize="12" theme="simple"/></td>      
        </tr>         
		</s:if>
		<!-- ##### -->
		
        <tr>  
          <td width="160" align="right"><span class="style1"><s:property value="getText('LOGIN_username')"/>:</span></td>
          <td width="160" align="left"><s:textfield name="username" id="username" maxLength="12" maxSize="12" theme="simple"/></td>
        </tr>
        <tr> 
          <td width="160" align="right"><span class="style1"><s:property value="getText('LOGIN_password')"/>:</span></td>
          <td width="160" align="left"><s:password name="password" id="password" maxLength="25" maxSize="12" theme="simple"/></td>
        </tr>        
        <tr>         
          <td width="320" align="center" colspan="2"><s:submit key="LOGIN_btnLogin" theme="simple" id="btnLogin" name="btnLogin" onclick="submit_login();" cssClass="lighter"/></td>          
        </tr>
        <tr> 
          <td width="320" align="center" colspan="3" bgcolor="#FAFAFA">
          <a href="../gsbsc-mobile-web/index.action"><font color="#7E7E7E" size="3"><b>click to mobile version web.</b></font></a>
          </td>
         </tr>        
        <tr> 
          <td width="320" align="center" colspan="2" bgcolor="#FAFAFA">
          <font color="#7E7E7E" size="2">Please use <b>Chrome</b> (recommend) or <b>Firefox</b> browser, can not support other browser.</font>
          </td>
         </tr>         
      </table>
	  <table id="pwaitTable" width="600" border="0" cellpadding="0" cellspacing="0" style="visibility:hidden" >
	  	<tr>
	  		<td align="center"><img alt="please wait" src="./images/please-wait.gif"></img></td>
	  	</tr>
		<tr>
			<td align="center" bgcolor="#FAFAFA"><h2><font color="#7E7E7E">Please wait!</font></h2></td>
		</tr>	  	
	  </table>      
	  </center>
	  </td>
    </tr>
    <tr>
      <td><span class="style2"><span class="style3">bamboo</span>BSC <span class="style4">0.6.3</span> </span></td>
    </tr>
  </table>
</s:form>
<script type="text/javascript">pageMessage();</script>
</body>
</html>