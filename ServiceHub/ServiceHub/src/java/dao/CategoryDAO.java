package dao;

import java.util.ArrayList;
import java.util.List;
import model.Category;
import org.hibernate.Hibernate;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

/**
 *
 * @author Yucun
 */
public class CategoryDAO {
     ArrayList<Category>  Category_list = null;

    public ArrayList<Category> getCategory_list() {
        return Category_list;
    }
    
    public void category_read(){
        Category_list = new ArrayList<Category>();
        List<Object[]> result = null;
        String sql = "SELECT id, name from category";
        Transaction trns = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = session.beginTransaction();
            SQLQuery query = session.createSQLQuery(sql);
            query.addScalar("id", Hibernate.INTEGER);
            query.addScalar("name", Hibernate.STRING);
            result = query.list();
        }catch (RuntimeException e) {
            e.printStackTrace();
        } finally {
            session.flush();
            session.close();
        }
        
         if (result != null) {

            for (int i = 0; i < result.size(); i++) {
                Object[] record = result.get(i);
                int id = (Integer) record[0];
                String name = (String) record[1];
                
                Category category = new Category();
                category.setId(id);
                category.setName(name);
                Category_list.add(category);
            }
         }
    }
}
