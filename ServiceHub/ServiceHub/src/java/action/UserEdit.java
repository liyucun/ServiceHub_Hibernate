package action;

import dao.WSDLDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Wsdl;

/**
 *
 * @author Yucun
 */
public class UserEdit extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String test = request.getParameter("url");
        int wsdl_id = Integer.parseInt(request.getParameter("wsdl_id"));
        Double price = Double.parseDouble(request.getParameter("price"));
        String url = request.getParameter("url");
        String subject = request.getParameter("subject");
        String description = request.getParameter("description");
        int technique = Integer.parseInt(request.getParameter("technique"));
        int category = Integer.parseInt(request.getParameter("category"));
        
        Wsdl wsdl = new Wsdl();
        wsdl.setId(wsdl_id);
        wsdl.setPrice(price);
        wsdl.setUrl(url);
        wsdl.setSubject(subject);
        wsdl.setDescription(description);
        wsdl.setFkTechniquesId(technique);
        wsdl.setFkCategoryId(category);
        
        WSDLDAO updata_wsdl = new WSDLDAO();
        updata_wsdl.wsdl_updata(wsdl);
        
         String address = "UserIndexView"; 
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
