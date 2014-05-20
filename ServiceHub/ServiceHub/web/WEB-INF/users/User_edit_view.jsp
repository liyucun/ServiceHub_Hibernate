<%-- 
    Document   : User_edit_view
    Created on : May 1, 2014, 2:34:07 AM
    Author     : Yucun
--%>

<%@page import="dao.CategoryDAO"%>
<%@page import="model.Category"%>
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
                                        for (int i = 0; i < tech.length; i++) {
                                            if (request.getAttribute("technique").toString().equals(tech[i])) {%>
                                    <option value="<%=i + 1%>" selected><%=tech[i]%></option>
                                    <%
                                 } else {%>
                                    <option value="<%=i + 1%>"><%=tech[i]%></option>
                                    <%
                                            }
                                        }
                                    %>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <%
                                int[] root_category_id_array = {11, 21, 22, 23, 313233, 42, 4445, 4849, 51, 52, 53, 54, 55, 56, 61, 62, 71, 72, 81, 91};
                                String[] root_category_name_array = {"Agriculture, Forestry, Fishing and Hunting", "Mining", "Utilities", "Construction", "Manufacturing", "Wholesale Trade", "Retail Trade", "Transportation and Warehousing", "Information", "Finance and Insurance", "Real Estate Rental and Leasing", "Professional, Scientific, and Technical Services", "Management of Companies and Enterprises", "Administrative and Support and Waste Management and Remediation Services", "Educational Services", "Health Care and Social Assistance", "Arts, Entertainment, and Recreation", "Accommodation and Food Services", "Other Services (except Public Administration)", "Public Administration"};
                                ArrayList<Category> root_category_list = new ArrayList<Category>();
                                for (int i = 0; i < root_category_id_array.length; i++) {
                                    Category temp = new Category();
                                    temp.setId(root_category_id_array[i]);
                                    temp.setName(root_category_name_array[i]);
                                    root_category_list.add(temp);
                                }

                                ArrayList<Category> second_category_list = new ArrayList<Category>();
                                ArrayList<Category> third_category_list = new ArrayList<Category>();
                                ArrayList<Category> fourth_category_list = new ArrayList<Category>();

                                if (request.getAttribute("categoryID").toString().length() > 4) {
                                    CategoryDAO second_category_dao = new CategoryDAO();
                                    second_category_dao.category_search(Integer.parseInt(request.getAttribute("categoryID").toString().substring(0, 3)));
                                    second_category_list = second_category_dao.getCategory_list();

                                    CategoryDAO third_category_dao = new CategoryDAO();
                                    third_category_dao.category_search(Integer.parseInt(request.getAttribute("categoryID").toString().substring(0, 4)));
                                    third_category_list = third_category_dao.getCategory_list();

                                    CategoryDAO fourth_category_dao = new CategoryDAO();
                                    fourth_category_dao.category_search(Integer.parseInt(request.getAttribute("categoryID").toString().substring(0,5)));
                                    fourth_category_list = fourth_category_dao.getCategory_list();
                                }
                            %>
                            <label for="category" class="col-sm-4 control-label"></label>
                            <div class="col-sm-4">
                                <p>
                                    <select name="firstlevel" class="form-control" id="firstlevel" onchange="if (this.value != '')
                                                setSecond(this.options[this.selectedIndex].value);"> 
                                        <option value="">-Please Choose One-</option> 
                                        <%
                                            if (request.getAttribute("categoryID").toString().length() > 4) {
                                                for (int i = 0; i < root_category_list.size(); i++) {
                                                    if (request.getAttribute("categoryID").toString().substring(0, 2).equals(root_category_list.get(i).getId().toString())) {%>
                                        <option value="<%= root_category_list.get(i).getId()%>" selected><%= root_category_list.get(i).getName()%></option>
                                        <%
                                                } else {%>
                                        <option value="<%= root_category_list.get(i).getId()%>"><%= root_category_list.get(i).getName()%></option>
                                        <%
                                                        }
                                                    }
                                                } else {%>
                                        <option value="1" selected>General</option>
                                        <option value="11">Agriculture, Forestry, Fishing and Hunting</option> 
                                        <option value="21">Mining</option> 
                                        <option value="22">Utilities</option> 
                                        <option value="23">Construction</option>
                                        <option value="313233">Manufacturing</option> 
                                        <option value="42">Wholesale Trade</option> 
                                        <option value="4445">Retail Trade</option> 
                                        <option value="4849">Transportation and Warehousing</option> 
                                        <option value="51">Information</option> 
                                        <option value="52">Finance and Insurance</option> 
                                        <option value="53">Real Estate Rental and Leasing</option> 
                                        <option value="54">Professional, Scientific, and Technical Services</option> 
                                        <option value="55">Management of Companies and Enterprises</option> 
                                        <option value="56">Administrative and Support and Waste Management and Remediation Services</option> 
                                        <option value="61">Educational Services</option> 
                                        <option value="62">Health Care and Social Assistance</option> 
                                        <option value="71">Arts, Entertainment, and Recreation</option> 
                                        <option value="72">Accommodation and Food Services</option> 
                                        <option value="81">Other Services (except Public Administration)</option> 
                                        <option value="92">Public Administration</option> 
                                        <%

                                            }
                                        %>
                                    </select>
                                </p>
                                <p>
                                    <select name="secondlevel" class="form-control" id="secondlevel" onchange="if (this.value != '')
                                                setthird(this.options[this.selectedIndex].value);"> 
                                        <option value="">-Please Choose One-</option> 
                                        <%
                                            if (request.getAttribute("categoryID").toString().length() > 4) {
                                                for (int i = 0; i < second_category_list.size(); i++) {
                                                    if (request.getAttribute("categoryID").toString().substring(0, 3).equals(second_category_list.get(i).getId().toString().substring(0, 3))) {%>
                                        <option value="<%= second_category_list.get(i).getId()%>" selected><%= second_category_list.get(i).getName()%></option>
                                        <%
                                                } else {
                                        %>
                                        <option value="<%= second_category_list.get(i).getId()%>"><%= second_category_list.get(i).getName()%></option>
                                        <%
                                                    }
                                                }
                                            }
                                        %>
                                    </select>
                                </p>
                                <p>
                                    <select name="thirdlevel" class="form-control" id="thirdlevel" onchange="if (this.value != '')
                                                setfourth(this.options[this.selectedIndex].value);"> 
                                        <option value="">-Please Choose One-</option>
                                        <%
                                            if (request.getAttribute("categoryID").toString().length() > 4) {
                                                for (int i = 0; i < third_category_list.size(); i++) {
                                                     if (request.getAttribute("categoryID").toString().substring(0, 4).equals(third_category_list.get(i).getId().toString().substring(0, 4))) {%>
                                        <option value="<%= third_category_list.get(i).getId()%>" selected><%= third_category_list.get(i).getName()%></option>
                                        <%
                                                } else {%>
                                        <option value="<%= third_category_list.get(i).getId()%>"><%= third_category_list.get(i).getName()%></option>
                                        <%
                                                    }
                                                }
                                            }
                                        %>
                                    </select>
                                </p>
                                <select name="category" class="form-control" id="fourthlevel" > 
                                    <option value="">-Please Choose One-</option> 
                                    <%
                                        if (request.getAttribute("categoryID").toString().length() > 4) {
                                            for (int i = 0; i < fourth_category_list.size(); i++) {
                                                if (request.getAttribute("categoryID").toString().equals(fourth_category_list.get(i).getId().toString())) {%>
                                    <option value="<%= fourth_category_list.get(i).getId()%>" selected><%= fourth_category_list.get(i).getName()%></option>
                                    <%
                                                } else { 
                                    %>
                                    <option value="<%= fourth_category_list.get(i).getId()%>"><%= fourth_category_list.get(i).getName()%></option>
                                    <%
                                                }
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


        <script language="JavaScript" type="text/javascript">

            function removeOptions(selectObj)
            {
                if (typeof selectObj != 'object')
                {
                    selectObj = document.getElementById(selectObj);
                }

                var len = selectObj.options.length;

                for (var i = 0; i < len; i++)
                {
                    selectObj.options[0] = null;
                }
            }

            function setSelectOption(selectObj, optionList, firstOption, selected)
            {
                if (typeof selectObj != 'object')
                {
                    selectObj = document.getElementById(selectObj);
                }

                removeOptions(selectObj);

                var start = 0;

                if (firstOption)
                {
                    selectObj.options[0] = new Option(firstOption, '');

                    start++;
                }

                var len = optionList.length;

                for (var i = 0; i < len; i++)
                {
                    selectObj.options[start] = new Option(optionList[i].txt, optionList[i].val);

                    if (selected == optionList[i].val)
                    {
                        selectObj.options[start].selected = true;
                    }

                    start++;
                }

            }

        </script> 

        <script language="JavaScript" type="text/javascript">
            function explain(raw_string)
            {
                var explained_result = new Array();
                var num_options = 0;        //length need + 1 ***************be careful!
                var temp_position = 0;
                var temp_comma_position = 0;
                var id;
                var name;
                for (var i = 0; i < raw_string.length; i++) {
                    if (raw_string.charAt(i) == "@")
                    {
                        temp_comma_position = i;
                    }
                    if (raw_string.charAt(i) == "#")
                    {
                        id = raw_string.substring(temp_position, temp_comma_position);
                        name = raw_string.substring((temp_comma_position + 1), i);
                        temp_position = i + 1;
                        var option_object = new Object();
                        option_object.txt = name;
                        option_object.val = id;
                        explained_result[num_options] = option_object;
                        num_options = num_options + 1;
                    }
                }
                return explained_result;
            }
        </script>

        <script>
            function loadData(categoryID)
            {
                var raw_result;
                var xmlhttp;
                if (window.XMLHttpRequest)
                {// code for IE7+, Firefox, Chrome, Opera, Safari
                    xmlhttp = new XMLHttpRequest();
                }
                else
                {// code for IE6, IE5
                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }
                xmlhttp.onreadystatechange = function()
                {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                    {
                        raw_result = xmlhttp.responseText;
                    }
                }
                xmlhttp.open("GET", "category?categoryID=" + categoryID, false);
                xmlhttp.send();
                return  raw_result;
            }
        </script>

        <script language="JavaScript" type="text/javascript">
            function setSecond(category)
            {

                var SecondLevelOptions;
                if (category.length == 2)
                {
                    var single_category = category;
                    SecondLevelOptions = loadData(single_category);
                }
                else
                {
                    var multi_category = new Array((category.length) / 2);
                    var cursor = 0;
                    var index = 0;

                    while (cursor < category.length)
                    {
                        multi_category[index] = category.substring(cursor, (cursor + 2));
                        var tempSecondLevelOptions = loadData(multi_category[index]);

                        if (cursor == 0)
                        {
                            SecondLevelOptions = tempSecondLevelOptions;
                        }
                        else
                        {
                            SecondLevelOptions = SecondLevelOptions.concat(tempSecondLevelOptions);
                        }
                        cursor = cursor + 2;
                        index = index + 1;
                    }
                }
                setSelectOption('secondlevel', explain(SecondLevelOptions), '-Please Choose One-');
            }

            function setthird(category)
            {

                var SecondLevelOptions;
                if (category.length == 3)
                {
                    var single_category = category;
                    SecondLevelOptions = loadData(single_category);
                }

                setSelectOption('thirdlevel', explain(SecondLevelOptions), '-Please Choose One-');
            }

            function setfourth(category)
            {

                var SecondLevelOptions;
                if (category.length == 4)
                {
                    var single_category = category;
                    SecondLevelOptions = loadData(single_category);
                }

                setSelectOption('fourthlevel', explain(SecondLevelOptions), '-Please Choose One-');
            }
        </script> 

    </body>
</html>