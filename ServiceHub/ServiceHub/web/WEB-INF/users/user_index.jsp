<%-- 
    Document   : user_index
    Created on : May 1, 2014, 4:11:39 AM
    Author     : Yucun
--%>

<%@page import="java.util.List"%>
<%@page import="model.IndexView"%>
<%@page import="dao.IndexViewDAO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ServiceHub</title>
        <!-- Bootstrap -->
        <link href="./css/bootstrap.min.css" rel="stylesheet"/>
        <script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
        <script src="./js/bootstrap.min.js"></script>
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
                            <li><a href="UserIndexView" style="color:white"><b>Portal</b></a></li>  
                        </ul>
                    </div>
                </div>
            </nav>
        </div>


        <div class="container">
            <div class="jumbotron">

                <div class="container" style="padding-top: 40px;">

                    <div class="row">
                        <div class="col-md-8">
                            <h5><b>Currently listing:  All Services</b></h5>
                        </div>
                        <div class="col-md-4">
                            <div class="pull-right">
                                <form action="Search" method="GET">
                                    <input type="text" name="search_string">
                                    <button class="btn" type="submit" style="background-color:#222; color:white; padding-left: 15px;padding-right: 15px; padding-bottom: 3px; padding-top: 3px">Search</button>
                                </form>
                            </div>
                        </div>
                    </div>


                    <table class="table table-bordered table-hover">
                        <thead style="background-color:#222; color:white;">
                            <tr align="right">
                                <th>Owner</th>
                                <th>Price</th>
                                <th>WSDL</th>
                                <th>Subject</th>
                                <th>Description</th>
                                <th>Technique</th>
                                <th>Category</th>
                            </tr>
                        </thead>
                        <tbody>
                            <jsp:useBean id="query_result" class="dao.IndexViewDAO" scope="request" />
                            <c:forEach var="indexview_item" items="${query_result.getPageData()}" varStatus="index" >
                                <tr>
                                    <td><c:out value="${indexview_item.getOwner()}" /></td>
                                    <td><c:out value="${indexview_item.getPrice()}" /></td>
                                    <td style="word-break : break-all; "><a href="${indexview_item.getWsdl()}"><c:out value="${indexview_item.getWsdl()}"/></a></td>
                                    <td style="word-break : break-all; "><c:out value="${indexview_item.getSubject()}" /></td>
                                    <td style="word-break : break-all; "><c:out value="${indexview_item.getDescription()}" /></td>
                                    <td><c:out value="${indexview_item.getTechnique()}" /></td>
                                    <td><c:out value="${indexview_item.getCategory()}" /></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <div class="row">
                        <div class="col-md-4">
                            <%-- First time to open homepage and thus cur = null --%>
                            <c:if test="${param.cur == null}">
                                <h6>
                                    <b>
                                        Current on 1 Page       Total ${requestScope.query_result.getTotalPageNumber()} page  
                                    </b>
                                </h6> 
                            </c:if>

                            <c:if test="${param.cur != null}">
                                <h6>
                                    <b>
                                        Current on ${param.cur} Page       Total ${requestScope.query_result.getTotalPageNumber()} page 
                                    </b>
                                </h6>  
                            </c:if>
                        </div>

                        <div class="col-md-8">
                            <ul class="pagination pull-right" style="margin: 0; padding-right: 0">  

                                <c:if test="${param.cur == 1 or param.cur == null}">  
                                    <li><a>First Page</a> </li>
                                    <li><a>Prev Page</a></li>
                                    </c:if>  

                                <c:if test="${param.cur > 1}">  
                                    <li><a href="index.html?cur=1">First Page</a></li>
                                    <li><a href="index.html?cur=${param.cur - 1}">Prev Page</a></li>
                                    </c:if>  

                                <c:if test="${param.cur == requestScope.query_result.getTotalPageNumber()}">  
                                    <li><a>Next Page</a></li>
                                    <li><a>Last Page</a></li>
                                    </c:if>  
                                    <%-- First time to open homepage and thus cur = null --%>
                                    <c:if test="${param.cur == null}">  
                                    <li><a href="index.html?cur=${param.cur + 2}">Next Page</a></li>
                                    <li><a href="index.html?cur=${requestScope.query_result.getTotalPageNumber()}">Last Page</a></li> 
                                    </c:if>

                                <c:if test="${param.cur < requestScope.query_result.getTotalPageNumber()}">  
                                    <li><a href="index.html?cur=${param.cur + 1}">Next Page</a></li>
                                    <li><a href="index.html?cur=${requestScope.query_result.getTotalPageNumber()}">Last Page</a></li>
                                    </c:if>  
                            </ul>
                        </div>
                    </div>

                </div>
            </div>
        </div>

    </body>
</html>
