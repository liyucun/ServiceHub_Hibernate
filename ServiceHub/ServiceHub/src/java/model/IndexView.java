package model;

import java.io.Serializable;

/**
 *
 * @author Yucun
 */
public class IndexView implements Serializable{
    private int wsdl_id;
    private String owner;
    private String price;
    private String wsdl;
    private String subject;
    private String description;
    private String technique;
    private String category;

    public int getWsdl_id() {
        return wsdl_id;
    }

    public void setWsdl_id(int wsdl_id) {
        this.wsdl_id = wsdl_id;
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getWsdl() {
        return wsdl;
    }

    public void setWsdl(String wsdl) {
        this.wsdl = wsdl;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTechnique() {
        return technique;
    }

    public void setTechnique(String technique) {
        this.technique = technique;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }
}
