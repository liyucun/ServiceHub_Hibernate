package action;

import dao.CategoryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Category;

/**
 *
 * @author Yucun
 */
public class category extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String categoryID = (String) request.getParameter("categoryID");    
        if (categoryID != null){
            int categoryIDint = Integer.parseInt(categoryID);
            CategoryDAO categorydao = new CategoryDAO();
            categorydao.category_search(categoryIDint);
            ArrayList<Category> category_query_result = categorydao.getCategory_list();
             if (category_query_result != null){
                  StringBuffer ReturnString = new StringBuffer();
                for(int i = 0; i < category_query_result.size(); i++){
                Category temp = category_query_result.get(i);
                    ReturnString.append(temp.getId());
                    ReturnString.append("@");
                    ReturnString.append(temp.getName());
                    ReturnString.append("#");
                }
                response.setContentType("text/html;charset=UTF-8");
                PrintWriter out = response.getWriter();
                out.print(ReturnString.toString());
                return;
             }
        }
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
