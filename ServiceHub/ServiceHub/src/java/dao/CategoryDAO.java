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

    ArrayList<Category> Category_list = null;

    public ArrayList<Category> getCategory_list() {
        return Category_list;
    }

    public void category_search(int categoryID) {
        Category_list = new ArrayList<Category>();
        List<Object[]> result = null;
        String SQL;
        Transaction trns = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            if (Integer.toString(categoryID).length() == 4) {
                SQL = "SELECT id, name from category WHERE (id LIKE ? AND id != ?) ";
                trns = session.beginTransaction();
                SQLQuery query = session.createSQLQuery(SQL);
                query.setParameter(0, Integer.toString(categoryID) + "%");
                query.setParameter(1, Integer.toString(categoryID));
                result = query.list();
            } else {
                SQL = "SELECT id, name from category WHERE (id LIKE ?) ";
                trns = session.beginTransaction();
                SQLQuery query = session.createSQLQuery(SQL);
                query.setParameter(0, Integer.toString(categoryID) + "_");
                result = query.list();
            }

        } catch (RuntimeException e) {
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

    public void category_read() {  // Read the whole list of category
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
        } catch (RuntimeException e) {
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
