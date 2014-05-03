package dao;

import java.util.ArrayList;
import java.util.List;
import model.IndexView;
import model.Techniques;
import model.Wsdl;
import org.hibernate.Hibernate;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

/**
 *
 * @author Yucun
 */
public class WSDLDAO {
    private List<Wsdl> PageData;
    
     public List<Wsdl> getPageData() {
        return PageData;
    }
     
      public void wsdl_create(Wsdl wsdl){
          String sql =  "INSERT INTO `servicediscovery`.`wsdl` (`fk_owner_id`, `fk_category_id`, `price`, `URL`, `fk_techniques_id`, `subject`, `description`) "
                    + " VALUES (? , ? , ? , ? , ? , ? , ? )"; 
        Transaction trns = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = session.beginTransaction();
            SQLQuery query = session.createSQLQuery(sql);
            query.setParameter(0, wsdl.getFkOwnerId());
            query.setParameter(1, wsdl.getFkCategoryId()); 
            query.setParameter(2, wsdl.getPrice());
            query.setParameter(3, wsdl.getUrl());
            query.setParameter(4, wsdl.getFkTechniquesId());
            query.setParameter(5, wsdl.getSubject());
            query.setParameter(6, wsdl.getDescription());
           // query.setParameter(7, wsdl.getStatus());
            query.executeUpdate();
            trns.commit();
        }catch (RuntimeException e) {
            e.printStackTrace();
        } finally {
            session.flush();
            session.close();
        }
      }
      
      public void wsdl_updata(Wsdl wsdl){
          String sql = "UPDATE servicediscovery.wsdl SET price = ?, url = ?, subject = ?, description = ?, fk_techniques_id = ?, fk_category_id = ? WHERE id = ?";
        Transaction trns = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = session.beginTransaction();
            SQLQuery query = session.createSQLQuery(sql);
            query.setParameter(0, wsdl.getPrice());
            query.setParameter(1, wsdl.getUrl());
             query.setParameter(2, wsdl.getSubject());
             query.setParameter(3, wsdl.getDescription());
             query.setParameter(4, wsdl.getFkTechniquesId());
            query.setParameter(5, wsdl.getFkCategoryId()); 
            query.setParameter(6, wsdl.getId());  
            query.executeUpdate();
            trns.commit();
        }catch (RuntimeException e) {
            e.printStackTrace();
        } finally {
            session.flush();
            session.close();
        }
      }
      
       public void wsdl_delete(int wsdl_id){
           String sql ="DELETE FROM `servicediscovery`.`wsdl`"
                                + " WHERE  wsdl.id = ?";
        Transaction trns = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = session.beginTransaction();
            SQLQuery query = session.createSQLQuery(sql);
            query.setParameter(0, wsdl_id);
            query.executeUpdate();
            trns.commit();
        }catch (RuntimeException e) {
            e.printStackTrace();
        } finally {
            session.flush();
            session.close();
        }
       
       }
     
      public void wsdl_read(int cur, int user_id, int role_id){
        PageData = new ArrayList<Wsdl>();
        int data_per_page = 10;
        List<Object[]> result = null;
        String sql = "";
        String admin_sql = "SELECT wsdl.ID, users.NAME, wsdl.PRICE, wsdl.URL, wsdl.SUBJECT, wsdl.DESCRIPTION, techniques.NAME, wsdl.STATUS, category.NAME "
                    + " FROM wsdl, techniques, category, users "
                    + " WHERE (wsdl.FK_OWNER_ID = users.ID AND wsdl.FK_TECHNIQUES_ID = techniques.id AND wsdl.FK_CATEGORY_ID = category.ID) ORDER BY wsdl.id DESC LIMIT ?, ?";
        
        String user_sql = "SELECT wsdl.ID, users.NAME, wsdl.PRICE, wsdl.URL, wsdl.SUBJECT, wsdl.DESCRIPTION, techniques.NAME, wsdl.STATUS, category.NAME "
                    + " FROM wsdl, techniques, category, users "
                    + " WHERE (wsdl.FK_OWNER_ID = users.ID AND ? = wsdl.FK_OWNER_ID AND wsdl.FK_TECHNIQUES_ID = techniques.id AND wsdl.FK_CATEGORY_ID = category.ID) ORDER BY wsdl.id DESC LIMIT ?, ?";
                                        // id setParameter need change
        sql = user_sql;
        if (role_id == 1){
            sql = admin_sql;
        }
        
        Transaction trns = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = session.beginTransaction();
            SQLQuery query = session.createSQLQuery(sql);
            query.addScalar("wsdl.ID", Hibernate.INTEGER);
            query.addScalar("users.NAME", Hibernate.STRING);
            query.addScalar("wsdl.PRICE", Hibernate.DOUBLE);
            query.addScalar("wsdl.URL", Hibernate.STRING);
            query.addScalar("wsdl.SUBJECT", Hibernate.STRING);
            query.addScalar("wsdl.DESCRIPTION", Hibernate.STRING);
            query.addScalar("techniques.NAME", Hibernate.STRING);
            query.addScalar("wsdl.STATUS", Hibernate.INTEGER);
            query.addScalar("category.NAME", Hibernate.STRING);
            if(role_id == 1){
                 query.setParameter(0, (cur - 1) * data_per_page);
                 query.setParameter(1, data_per_page);
            }else if (role_id == 0){
                 query.setParameter(0, user_id);
                 query.setParameter(1, (cur - 1) * data_per_page);
                 query.setParameter(2, data_per_page);
            }
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
                String userName = (String) record[1];
                Double price = (Double) record[2];
                String url = (String) record[3];
                String subject = (String) record[4];
                String description = (String) record[5];
                String technique_name = (String) record[6];
                int status = (Integer) record[7];
                String category_name = (String) record[8];

                Techniques tech_transfer = new Techniques();
                Wsdl wsdl = new Wsdl();
                wsdl.setId(id);
               wsdl.setUserName(userName);
               wsdl.setPrice(price);
               wsdl.setUrl(url);
               wsdl.setSubject(subject);
               wsdl.setDescription(description);
               wsdl.setTechniqueName(technique_name);
               wsdl.setStatus(status);
               wsdl.setCategoryName(category_name);
                PageData.add(wsdl);
            }
         }
      }
      
      
}
