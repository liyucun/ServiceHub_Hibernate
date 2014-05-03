package dao;

import java.util.ArrayList;
import java.util.List;
import model.IndexView;
import model.Techniques;
import org.hibernate.Hibernate;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

/**
 *
 * @author Yucun
 */
public class SearchDAO {

    private List<IndexView> PageData;
    private int data_per_page;
    private int total_page_number;

    public SearchDAO() {
        data_per_page = 10;
    }

    public List<IndexView> getPageData() {
        return PageData;
    }

    public int getTotal_page_number() {
        return total_page_number;
    }

    public void search(String search_string, int cur) {
        PageData = new ArrayList<IndexView>();
        String sql = "SELECT wsdl.id as id, users.Name, wsdl.PRICE, wsdl.URL, wsdl.SUBJECT, wsdl.DESCRIPTION, techniques.NAME, category.NAME "
                + " FROM wsdl, users, techniques, category"
                + " WHERE (users.id = wsdl.fk_owner_id AND wsdl.FK_TECHNIQUES_ID = techniques.id AND wsdl.FK_CATEGORY_ID = category.id AND (users.Name LIKE '%' ? '%' OR wsdl.DESCRIPTION LIKE '%' ? '%'))  LIMIT ?, ?";
        List<Object[]> result = null;
        Transaction trns = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = session.beginTransaction();
            SQLQuery query = session.createSQLQuery(sql);
            query.addScalar("id", Hibernate.INTEGER);
            query.addScalar("Name", Hibernate.STRING);
            query.addScalar("PRICE", Hibernate.STRING);
            query.addScalar("URL", Hibernate.STRING);
            query.addScalar("SUBJECT", Hibernate.STRING);
            query.addScalar("DESCRIPTION", Hibernate.STRING);
            query.addScalar("techniques.NAME", Hibernate.STRING);
            query.addScalar("category.NAME", Hibernate.STRING);
            query.setParameter(0, search_string);
            query.setParameter(1, search_string);
            query.setParameter(2, (cur - 1) * data_per_page);
            query.setParameter(3, data_per_page);
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
                String price = (String) record[2];
                String url = (String) record[3];
                String subject = (String) record[4];
                String description = (String) record[5];
                String technique = (String) record[6];
                String category = (String) record[7];

                Techniques tech_transfer = new Techniques();
                IndexView iv = new IndexView();
                iv.setWsdl_id(id);
                iv.setOwner(name);
                iv.setPrice(price);
                iv.setWsdl(url);
                iv.setSubject(subject);
                iv.setDescription(description);
                iv.setTechnique(technique);
                iv.setCategory(category);
                PageData.add(iv);
            }
        }
    }

    public void calculate_total_page_number(String search_string) {
        total_page_number = 0;
        List<Object[]> result = null;
        String sql = "SELECT wsdl.id as id"
                + " FROM wsdl, users"
                + "  WHERE (users.id = wsdl.fk_owner_id AND (users.Name LIKE '%' ? '%' OR wsdl.DESCRIPTION LIKE '%' ? '%' ))";
        Transaction trns = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = session.beginTransaction();
            SQLQuery query = session.createSQLQuery(sql);
            query.setParameter(0, search_string);
            query.setParameter(1, search_string);
            result = query.list();
        } catch (RuntimeException e) {
            e.printStackTrace();
        } finally {
            session.flush();
            session.close();
        }
        total_page_number = (int) Math.ceil((result.size() + 1.0 - 1.0) / data_per_page);
    }
}
