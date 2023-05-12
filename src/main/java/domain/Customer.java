package domain;

public class Customer {
    private int id;
    private String name;
    private String dni;
    private String phone_number;

    public Customer(int id, String name, String dni, String phone_number) {
        this.id = id;
        this.name = name;
        this.dni = dni;
        this.phone_number = phone_number;
    }
    public Customer() {

    }
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public String getPhone_number() {
        return phone_number;
    }

    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }

    @Override
    public String toString() {
        return "Customer{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", dni='" + dni + '\'' +
                ", phone_number='" + phone_number + '\'' +
                '}';
    }
}
