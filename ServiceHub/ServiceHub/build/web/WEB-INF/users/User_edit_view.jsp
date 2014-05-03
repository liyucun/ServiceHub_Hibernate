<%-- 
    Document   : User_edit_view
    Created on : May 1, 2014, 2:34:07 AM
    Author     : Yucun
--%>

<%@page import="model.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
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
            <div class="jumbotron" style="height:800px">
                <div class="container" style="padding-top: 40px;" align="center">
                    
                    <p><h4>Change Your WSDL</h4></p>
                <form action="UserEdit" method="POST" class="form-horizontal">
                    <div class="form-group">
                        <label for="price" class="col-sm-4 control-label">Email</label>
                        <div class="col-sm-4">
                            <input  type="number" name="price" class="form-control" id="price" value="<%=request.getAttribute("price")%>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="url" class="col-sm-4 control-label">URL</label>
                        <div class="col-sm-4">
                            <input   type="text" name="url" class="form-control" id="url" value="<%=request.getAttribute("url")%>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="subject" class="col-sm-4 control-label">Subject</label>
                        <div class="col-sm-4">
                            <input   type="text" name="subject" class="form-control" id="subject" value="<%=request.getAttribute("subject")%>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="description" class="col-sm-4 control-label">Description</label>
                        <div class="col-sm-4">
                            <textarea   type="text" name="description" class="form-control" id="description" rows="3"><%=request.getAttribute("description")%></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="technique" class="col-sm-4 control-label"></label>
                        <div class="col-sm-4">
                            <select name="technique" class="form-control" id="technique" >
                                <%
                                    String[] tech = {".net", "AXIS2", "JAX-WS", "technique"};
                                    for(int i = 0; i < tech.length; i++){
                                        if (request.getAttribute("technique").toString().equals(tech[i])){ %>
                                        <option value="<%=i+1%>" selected><%=tech[i]%></option>
                                 <%      
                                        }else{ %>
                                         <option value="<%=i+1%>"><%=tech[i]%></option>
                                  <%
                                        }
                                    }
                                %>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="category" class="col-sm-4 control-label"></label>
                        <div class="col-sm-4">
                            <select name="category" class="form-control" id="category" >
                                <%
                                        ArrayList<Category> category_list = (ArrayList<Category>) request.getAttribute("category_list");
                                        for (int i = 0; i < category_list.size(); i++) {
                                            if(request.getAttribute("category").toString().equals(category_list.get(i).getName())){%>
                                            <option value="<%=category_list.get(i).getId()%>" selected><%=category_list.get(i).getName()%></option>
                                 <%           
                                            }else{%>
                                             <option value="<%=category_list.get(i).getId()%>"><%=category_list.get(i).getName()%></option>
                                 <%           
                                            }
                                    }
                                %>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-4 col-sm-4">
                            <button type="submit" class="btn btn-primary">Updata</button>
                            <input type="hidden" name="wsdl_id" value="<%=request.getAttribute("wsdl_id")%>"/>
                        </div>
                    </div>
                </form>

                    
                    </div>
                </div>
             </div>
        

    </body>
</html>