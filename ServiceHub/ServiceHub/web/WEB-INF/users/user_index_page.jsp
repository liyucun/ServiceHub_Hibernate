<%-- 
    Document   : user_index_page
    Created on : Apr 30, 2014, 3:01:02 AM
    Author     : Yucun
--%>

<%@page import="java.util.List"%>
<%@page import="model.Wsdl"%>
<%@page import="dao.WSDLDAO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome to ServiceHub</title>
        <!-- Bootstrap -->
        <link href="./css/bootstrap.min.css" rel="stylesheet"/>
        <script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
        <script src="./js/bootstrap.min.js"></script>
        <script type="text/javascript">
            function submitform(change)
            {
                var r=confirm("You are going to change this wsdl!");
                if (r == true){
                    document.getElementById(change).submit();
                }
            }
        </script>
    </head>
    <body>
        <div>
            <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
                <div class="container">
                    <div class="navbar-header">
                        <a class="navbar-brand" href="index.html"><b>Service Hub</b></a>
                    </div>
                    <div class="navbar-collapse collapse">
                        <ul class="nav navbar-nav navbar-right">
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="color:white"><b>Information </b><b class="caret"></b></a>
                                <ul class="dropdown-menu" style="background-color:#eee;min-width:0px; text-align: center">
                                    <li><a href="AboutUs.jsp"><b>About</b></a></li>
                                    <li><a href="FAQ.jsp"><b>F&Q</b></a></li>
                                    <li><a href="ContactUs.jsp"><b>Contact Us</b></a></li>  
                                </ul>
                            </li>
                            <li><a href="LogOut" style="color:white"><b>Log Out</b></a></li>
                            <li><a href="index.html" style="color:white"><b>Home</b></a></li>    
                        </ul>
                    </div>
                </div>
            </nav>
        </div>

        

        <div class="container">
            <div class="jumbotron">

                <div class="container" style="padding-top: 40px;">
                    
                   <p> <a class="btn btn-primary" href="UserAddView">Create New WSDL</a></p>
                   

                    <table class="table table-bordered table-hover">
                        <thead style="background-color:#222; color:white;">
                            <tr>
                                <th>Owner</th>
                                <th>Price</th>
                                <th>WSDL</th>
                                <th>Subject</th>
                                <th>Description</th>
                                <th>Technique</th>
                                <th>Category</th>
                                <th></th>
                                <th></th>
                            </tr>

                        </thead>
                        <tbody>
                            <jsp:useBean id="query_result" class="dao.WSDLDAO" scope="request" />
                            <c:forEach var="indexview_item" items="${query_result.getPageData()}" varStatus="index" >
                                <% Wsdl wsdl = (Wsdl) pageContext.getAttribute("indexview_item");
                                    String wsdl_id = Integer.toString(wsdl.getId());
                                    String wsdl_data = wsdl_id+"###"+wsdl.getPrice()+"###"+wsdl.getUrl()+"###"+wsdl.getSubject()+"###"+wsdl.getDescription()+"###"+wsdl.getTechniqueName()+"###"+wsdl.getCategoryName();
                                %>
                                <tr>
                                    <td><c:out value="${indexview_item.getUserName()}" /></td>
                                    <td><c:out value="${indexview_item.getPrice()}" /></td>
                                    <td style="word-break : break-all; "><a href="${indexview_item.getUrl()}"><c:out value="${indexview_item.getUrl()}" /></a></td>
                                    <td style="word-break : break-all; "><c:out value="${indexview_item.getSubject()}" /></td>
                                    <td style="word-break : break-all; "><c:out value="${indexview_item.getDescription()}" /></td>
                                    <td><c:out value="${indexview_item.getTechniqueName()}" /></td>
                                    <td><c:out value="${indexview_item.getCategoryName()} " /></td>
                                    <td>
                                        <form id="<%=wsdl_id%>Edit" action="UserEditView">
                                            <a href="#" onclick="submitform(<%=wsdl_id%> + 'Edit')">Edit</a>
                                            <input type="hidden" name="wsdl_data" value="<%=wsdl_data%>"/>
                                        </form>
                                    </td>
                                    <td>
                                        <form id="<%=wsdl_id%>Delete" action="UserDelete">
                                            <a href="#" onclick="submitform(<%=wsdl_id%> + 'Delete')">Delete</a>
                                            <input type="hidden" name="wsdl_id" value="<%=wsdl_id%>"/>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <div class="row">
                        <ul class="pagination pull-right" style="margin: 0; padding-right: 0">

                            <c:if test="${param.cur == 1 or param.cur == null}">  
                                <li><a>Prev Page</a></li>
                                </c:if>  

                            <c:if test="${param.cur > 1}">  
                                <li><a href="UserIndexView?cur=${param.cur - 1}">Prev Page</a></li>
                                </c:if>  

                            <%-- First time to open homepage and thus cur = null --%>
                            <c:if test="${param.cur == null}">  
                                <li><a href="UserIndexView?cur=${param.cur + 2}">Next Page</a></li>
                                </c:if>

                                <c:if test="${param.cur >= 1}">  
                                <li><a href="UserIndexView?cur=${param.cur + 1}">Next Page</a></li>
                                </c:if>  
                        </ul>
                    </div>

                </div>
            </div>
        </div>


    </body>
</html>