package dao;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import model.Users;
import org.hibernate.Hibernate;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

/**
 *
 * @author Yucun
 */
public class UserDAO {

    boolean check_email_result; // if true, then email valid; if false, then email invalid and someone has signed up.
    boolean check_user_result; // if true, then user is exist; if false, then user doest exist or invalid password/email
    Users login_user;

    public boolean isCheck_user_result() {
        return check_user_result;
    }

    public Users getLogin_user() {
        return login_user;
    }

    public boolean isCheck_email_result() {
        return check_email_result;
    }

    public void check_email(String user_email) {
        check_email_result = true;
        List<Object[]> result = null;
        String sql = "SELECT users.id "
                + "FROM users "
                + "WHERE users.email = ?";
        Transaction trns = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = session.beginTransaction();
            SQLQuery query = session.createSQLQuery(sql);
            query.setParameter(0, user_email);
            result = query.list();
        } catch (RuntimeException e) {
            e.printStackTrace();
        } finally {
            session.flush();
            session.close();
        }
        if (result.size() > 0) { 
            check_email_result = false;
        }
    }

    public void create_user(Users user) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Calendar cal = Calendar.getInstance();
       
        String sql = "INSERT INTO users (`NAME`, `FAMILY`, `COMPANY_NAME`, `EMAIL`, `WEBSITE`, `REGISTERED_DATE`, `PASSWORD`) "
                            + " VALUES (? , ? , ? , ? , ? , ?, ? )";
        Transaction trns = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = session.beginTransaction();
            SQLQuery query = session.createSQLQuery(sql);
            query.setParameter(0, user.getName());
            query.setParameter(1, user.getFamily());
            query.setParameter(2, user.getCompanyName());
            query.setParameter(3, user.getEmail());
            query.setParameter(4, user.getWebsite());
            query.setParameter(5, dateFormat.format(cal.getTime()));
            query.setParameter(6, user.getPassword());
            query.executeUpdate();
            trns.commit();
        } catch (RuntimeException e) {
            e.printStackTrace();
        } finally {
            session.flush();
            session.close();
        }
    }

    //User entity only contain email and password;
    public void find_user(Users user) {
        Users find_user_result = new Users();
        List<Object[]> result = null;
        String sql = "SELECT id, name, fk_role_id " 
                + " FROM users "
                + " WHERE (users.email = ? AND users.password = ?)";
        Transaction trns = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = session.beginTransaction();
            SQLQuery query = session.createSQLQuery(sql);
            query.addScalar("id", Hibernate.INTEGER);
            query.addScalar("name", Hibernate.STRING);
            query.addScalar("fk_role_id", Hibernate.INTEGER);
            query.setParameter(0, user.getEmail());
            query.setParameter(1, user.getPassword());
            result = query.list();
        } catch (RuntimeException e) {
            e.printStackTrace();
        } finally {
            session.flush();
            session.close();
        }
        if (result.size() > 0) {

            for (int i = 0; i < result.size(); i++) {
                Object[] record = result.get(i);
                find_user_result.setId((Integer) record[0]);
                find_user_result.setName((String) record[1]);
                find_user_result.setFkRoleId((Integer) record[2]);
            }
            this.login_user = find_user_result;
            check_user_result = true;
        }

    }

}
