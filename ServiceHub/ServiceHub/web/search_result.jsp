<%-- 
    Document   : search_result
    Created on : Apr 27, 2014, 4:50:42 PM
    Author     : Yucun
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search Result</title>
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
                                    <li><a href="aboutUs.jsp"><b>About</b></a></li>
                                    <li><a href="FAQ.jsp"><b>F&Q</b></a></li>
                                    <li><a href="contactUs.jsp"><b>Contact Us</b></a></li>  
                                </ul>
                            </li>
                            <%
                                session = request.getSession();
                                if(session.getAttribute("name") != null){%>
                                <li><a href="LogOut" style="color:white"><b>Log Out</b></a></li>
                                <li><a href="UserIndexView" style="color:white"><b>Portal</b></a></li> 
                            <%    
                                }else{%>
                                <li><a data-toggle="modal" href="#log_in" style="color:white"><b>Log In</b></a></li>
                                <li><a data-toggle="modal" href="#sign_up" style="color:white"><b>Sign Up</b></a></li>
                            <%
                                }
                            %>           
                        </ul>
                    </div>
                </div>
            </nav>
        </div>

        <div class = "container-fluid">
            <div id = "log_in" class="modal fade" >
                <div class = "modal-dialog">
                    <div class = "modal-content">
                        <div class="modal-header" style="background: #222; color:white">
                            <button type = "button" class = "close" data-dismiss = "modal" style="color:white">&times;</button>
                            <h4 class="modal-title"><b>Please Sign In</b></h4>
                        </div>
                        <div class="modal-body">
                            <form action="LogIn" method="POST">
                                <div class="form-group">
                                    <label for="email" class="control-label" style="text-align: left">Email</label>
                                    <input name="email" type="text" class="form-control" placeholder="Enter Your Email" required  autofocus>
                                </div>
                                <div class="form-group">
                                    <label for="password" class="control-label" style="text-align: left">Password</label>
                                    <input name="password" type="password" class="form-control" required>
                                </div>
                                <button class="btn btn-primary" type="submit">Sign In</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class = "container-fluid">
            <div id = "sign_up" class="modal fade" >
                <div class = "modal-dialog">
                    <div class = "modal-content">
                        <div class="modal-header" style="background: #222;color:white">
                            <button type="button" class="close" data-dismiss="modal" style="color:white">&times;</button>
                            <h4 class="modal-title"><b>Please Fill Below Information For Registration</b></h4>
                        </div>
                        <div class="modal-body">
                            <div>    
                                <form class="form-horizontal" action="SignUp" method="POST">
                                    <div class="form-group">
                                        <label for="firstName" class="control-label" style="text-align: left">First Name</label>
                                        <input name="name" type="text" class="form-control" id="firstName" placeholder="Enter Your First Name" required  autofocus>
                                    </div>
                                    <div class="form-group">
                                        <label for="Family" class="control-label" style="text-align: left">Family Name</label>
                                        <input name="family" type="text" class="form-control" id="Family" placeholder="Enter Your Family Name" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="org" class="control-label" style="text-align: left">Organization</label>
                                        <input name="company_name" type="text" class="form-control" id="org" placeholder="Enter Your Organization/Company" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="email" class="control-label" style="text-align: left">Email Address</label>
                                        <input name="email" type="email" class="form-control" id="email" placeholder="Enter Your Email Address" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="webSite" class="control-label" style="text-align: left">Website</label>
                                        <input name="website" type="url" class="form-control" id="webSite" placeholder="Enter Your Website" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="pass" class="control-label" style="text-align: left">Password</label>
                                        <input name="password" type="password" class="form-control" id="pass" placeholder="Enter Your Password" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="cpass" class="control-label" style="text-align: left">Confirm Password</label>
                                        <input name="repass" type="password" class="form-control" id="cpass" placeholder="Renter Your Password" required onblur="checkPass()">
                                    </div>
                                    <button class="btn btn-primary"  type="submit">Sign Up</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="container">
            <div class="jumbotron">

                <div class="container" style="padding-top: 40px;">

                    <div class="row">
                        <div class="col-md-8">
                            <h5><b>Search Results:  <%=request.getAttribute("search_string")%></b></h5>
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
                            <tr>
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
                                <jsp:useBean id="search_result" class="dao.SearchDAO" scope="request" />
                            <c:forEach var="indexview_item" items="${search_result.getPageData()}" varStatus="index" >
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
                                        Current on 1 Page       Total ${requestScope.search_result.getTotal_page_number()} page  
                                    </b>
                                </h6>
                            </c:if>

                            <c:if test="${param.cur != null}">
                                <h6>
                                    <b>  
                                        Current on ${param.cur} Page       Total ${requestScope.search_result.getTotal_page_number()} page  
                                    </b>
                                </h6>
                            </c:if>
                        </div>


                        <div class="col-md-8">
                            <ul class="pagination pull-right" style="margin: 0; padding-right: 0">  

                                <c:if test="${param.cur == 1 or param.cur == null}">  
                                    <li><a>First Page</a></li>
                                    <li><a>Prev Page</a></li>
                                    </c:if>  

                                <c:if test="${param.cur > 1}">  
                                    <li><a href="Search?search_string=${param.search_string}&cur=1">First Page</a></li>
                                    <li><a href="Search?search_string=${param.search_string}&cur=${param.cur - 1}">Previous Page</a></li>
                                    </c:if>  

                                <c:if test="${param.cur == requestScope.search_result.getTotal_page_number()}">  
                                    <li><a>Next Page</a></li>
                                    <li><a>Last Page</a></li> 
                                    </c:if>  
                                    <%-- First time to open homepage and thus cur = null --%>
                                    <c:if test="${param.cur == null}">  
                                    <li><a href="Search?search_string=${param.search_string}&cur=${param.cur + 2}">Next Page</a></li>  
                                    <li><a href="Search?search_string=${param.search_string}&cur=${requestScope.search_result.getTotal_page_number()}">Last Page</a></li>
                                    </c:if>

                                <c:if test="${param.cur < requestScope.search_result.getTotal_page_number()}">  
                                    <li><a href="Search?search_string=${param.search_string}&cur=${param.cur + 1}">Next Page</a></li>  
                                    <li><a href="Search?search_string=${param.search_string}&cur=${requestScope.search_result.getTotal_page_number()}">Last Page</a></li>
                                    </c:if>  
                            </ul>
                        </div>

                    </div>

                </div>
            </div>
        </div>

    </body>
</html>
