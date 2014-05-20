package action;

import dao.CategoryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Category;

/**
 *
 * @author Yucun
 */
public class UserEditView extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       String wsdl_data = request.getParameter("wsdl_data");
       String[] wsdl_data_array = wsdl_data.split("###");
       request.setAttribute("wsdl_id", wsdl_data_array[0]);
       request.setAttribute("price", wsdl_data_array[1]);
       request.setAttribute("url", wsdl_data_array[2]);
       request.setAttribute("subject", wsdl_data_array[3]);
       request.setAttribute("description", wsdl_data_array[4]);
       request.setAttribute("technique", wsdl_data_array[5]); 
       request.setAttribute("categoryID", wsdl_data_array[6]);
       

       
       String address = "WEB-INF/users/User_edit_view.jsp"; 
        RequestDispatcher dispatcher = request.getRequestDispatcher(address);
        dispatcher.forward(request, response);   
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
