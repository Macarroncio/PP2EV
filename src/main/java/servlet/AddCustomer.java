package servlet;

import dao.CustomerDao;
import dao.Database;
import domain.Customer;
import exception.CustomerAlreadyExistsException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet("/add-customer")
public class AddCustomer extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String name = request.getParameter("name");       // input name="title" del formulario
        String dni = request.getParameter("dni");
        String phone_number = request.getParameter("phone_number");

        Database database = new Database();
        CustomerDao customerDao = new CustomerDao(database.getConnection());
        Customer customer = new Customer();
        customer.setName(name);
        customer.setDni(dni);
        customer.setPhone_number(phone_number);
        try{

            if (customerDao.findById(customer.getId()).isPresent()){
                out.println("<div class='alert alert-danger' role='alert'>This customer's DNI is already registered</div>");
            }else{
                customerDao.add(customer);
                out.println("<div class='alert alert-success' role='alert'>The user has been successfully registered </div>");

            }
        }catch (SQLException | CustomerAlreadyExistsException sqle){
            sqle.printStackTrace();
        }
    }
}