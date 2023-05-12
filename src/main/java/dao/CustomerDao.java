package dao;

import domain.Customer;
import exception.CustomerAlreadyExistsException;
import exception.CustomerNotFoundException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Optional;

public class CustomerDao {

    private Connection connection;

    public CustomerDao(Connection connection) {
        this.connection = connection;
    }


    public void add(Customer customer) throws SQLException, CustomerAlreadyExistsException {
        String sql = "INSERT INTO CUSTOMERS (name, dni, phone_number) VALUES (?, ?, ?)";
        if (existCustomer(customer.getId()))
            throw new CustomerAlreadyExistsException("This customer already exists");

        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, customer.getName());
        statement.setString(2, customer.getDni());
        statement.setString(3, customer.getPhone_number());

        statement.executeUpdate();
    }

    public boolean delete(int id) throws SQLException {
        try {
            String sql = "DELETE FROM customers WHERE id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            int rows = statement.executeUpdate();

            return rows == 1;
        }catch (SQLException sqle){
            System.out.println("Problems probably related with this customer appearing in other tables");
            sqle.printStackTrace();
            return false;
        }
    }

    public boolean modify(int id, Customer customer) throws SQLException {
        String sql = "UPDATE customers SET name = ?, dni = ?, phone_number = ? WHERE id = ?";

        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, customer.getName());
        statement.setString(2, customer.getDni());
        statement.setString(3, customer.getPhone_number());

        int rows = statement.executeUpdate();
        return rows == 1;
    }

    public ArrayList<Customer> showAll() throws SQLException {
        String sql = "SELECT * FROM CUSTOMERS ORDER BY id";
        ArrayList<Customer> customers = new ArrayList<>();

        PreparedStatement statement = connection.prepareStatement(sql);
        ResultSet resultSet = statement.executeQuery();
        while (resultSet.next()) {
            Customer customer = new Customer();
            customer.setId(resultSet.getInt("id"));
            customer.setName(resultSet.getString("name"));
            customer.setDni(resultSet.getString("dni"));
            customer.setPhone_number(resultSet.getString("phone_number"));

            customers.add(customer);
        }

        return customers;
    }

    public Optional<Customer> findById(int id) throws SQLException {
        String sql = "SELECT * FROM customers WHERE id = ?";
        Customer customer = null;

        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, id);
        ResultSet resultSet = statement.executeQuery();
        if (resultSet.next()) {

            customer.setId(resultSet.getInt("id"));
            customer.setName(resultSet.getString("name"));
            customer.setDni(resultSet.getString("dni"));
            customer.setPhone_number(resultSet.getString("phone_number"));

        }

        return Optional.ofNullable(customer);
    }

    private boolean existCustomer(int id) throws SQLException {
        Optional<Customer> customer = findById(id);
        return customer.isPresent();
    }
}






