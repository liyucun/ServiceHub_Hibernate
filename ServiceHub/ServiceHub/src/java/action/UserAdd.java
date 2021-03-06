package action;

import dao.WSDLDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Wsdl;

/**
 *
 * @author Yucun
 */
public class UserAdd extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       HttpSession session = request.getSession();
        int user_id = (Integer) session.getAttribute("user_id");
        
        Double price = Double.parseDouble(request.getParameter("price"));
        String url = request.getParameter("url");
        String subject = request.getParameter("subject");
        String description = request.getParameter("description");
        int fk_techniques_id = Integer.parseInt(request.getParameter("technique"));
        int fk_category_id = Integer.parseInt(request.getParameter("category"));
       
        Wsdl wsdl = new Wsdl();
        wsdl.setFkOwnerId(user_id);
        wsdl.setPrice(price);
        wsdl.setUrl(url);
        wsdl.setSubject(subject);
        wsdl.setDescription(description);
       wsdl.setFkTechniquesId(fk_techniques_id);
       wsdl.setFkCategoryId(fk_category_id);
              
        WSDLDAO add_wsdl = new WSDLDAO();
        add_wsdl.wsdl_create(wsdl);
        
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
