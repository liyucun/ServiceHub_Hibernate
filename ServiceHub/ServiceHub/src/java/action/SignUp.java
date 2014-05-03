package action;

import dao.UserDAO;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Users;

/**
 *
 * @author Yucun
 */
public class SignUp extends HttpServlet {

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
        String address = "";
        Users user = new Users();

        String name = request.getParameter("name"); //(String) request.getAttribute("name"); 
        String family = request.getParameter("family"); //(String) request.getAttribute("family");
        String company_name = request.getParameter("company_name"); //(String) request.getAttribute("company_name");
        String email = request.getParameter("email"); //(String) request.getAttribute("email");
        String website = request.getParameter("website"); //(String) request.getAttribute("website");
        String password = request.getParameter("password"); //(String) request.getAttribute("password");

        user.setName(name);
        user.setFamily(family);
        user.setCompanyName(company_name);
        user.setEmail(email);
        user.setWebsite(website);
        user.setPassword(password);

        UserDAO userDAO = new UserDAO();
        userDAO.check_email(email);
        if (userDAO.isCheck_email_result()) {
            // if true, that means email is valid
            request.setAttribute("info", "You have successfully signed up");
            userDAO.create_user(user);
        } else {
            // the email has been signed up
            // set an attribute to see whether it is from Servlet
            request.setAttribute("info", "The email has been used, please use another email ");
        }

        address = "WEB-INF/users/user_signed_up_page.jsp";
        RequestDispatcher dispatcher
                = request.getRequestDispatcher(address);
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
