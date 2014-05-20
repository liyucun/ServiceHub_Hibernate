package action;

import dao.WSDLDAO;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * The Interface page for the user.
 *
 * @author Yucun
 */
public class UserIndexView extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String address = "";
        HttpSession session = request.getSession();
        int user_id = session.getAttribute("user_id") != null ? (Integer) session.getAttribute("user_id") : 0;
        if (user_id != 0) {
            int role_id = (Integer) session.getAttribute("fk_role_id");
            String cur = (String) request.getParameter("cur");
            if (cur == null) {
                cur = "1";
            }
            WSDLDAO query = new WSDLDAO();
            query.wsdl_read(Integer.parseInt(cur), user_id, role_id);
            request.setAttribute("query_result", query);
            address = "WEB-INF/users/user_index_page.jsp";
        } else {
            request.setAttribute("info", "You have not been signed in, please  sign in!");
            address = "WEB-INF/users/user_signed_up_page.jsp";
        }
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
