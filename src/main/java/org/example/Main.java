package org.example;

import dao.CustomerDao;
import dao.Database;
import domain.Customer;
import exception.CustomerAlreadyExistsException;

import java.sql.Connection;
import java.sql.SQLException;

// Press Shift twice to open the Search Everywhere dialog and type `show whitespaces`,
// then press Enter. You can now see whitespace characters in your code.
public class Main {
    public static void main(String[] args) throws SQLException, CustomerAlreadyExistsException {
        // Press Alt+Intro with your caret at the highlighted text to see how
        // IntelliJ IDEA suggests fixing it.
        System.out.printf("Hello and welcome!");

        Database db = new Database();
        CustomerDao customerDao = new CustomerDao(db.getConnection());
        Customer customer = new Customer( "probatina", "probatina", "probatina");

        customerDao.add(customer);



        }
    }
