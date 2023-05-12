package servlet;

import dao.CustomerDao;
import dao.Database;
import domain.Customer;
import exception.CustomerAlreadyExistsException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet("/modify-customer")
public class ModifyCustomer {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        //esto es para comprobar que el que se mete es admin
        Customer currentUser = (Customer) request.getSession().getAttribute("currentUser");
        if (currentUser == null || !currentUser.getDni().equals("111111111")) {
            response.sendRedirect("login.jsp");
        }

        int id = Integer.parseInt(request.getParameter("id"));

        String newName = request.getParameter("newName");
        String newDni = request.getParameter("newDni");
        String newPhone_number = request.getParameter("newPhone_number");

        Customer customer = new Customer();
        customer.setName(newName);
        customer.setDni(newDni);
        customer.setPhone_number(newPhone_number);

        Database database = new Database();
        CustomerDao customerDao = new CustomerDao(database.getConnection());

        try {
            customerDao.modify(id, customer);
            out.println("<div class='alert alert-success' role='alert'>Successfully modified</div>");

        } catch (SQLException sqle) {
            out.println("<div class='alert alert-danger' role='alert'>Problems encountered while adding this travel</div>");
            sqle.printStackTrace();
        }
    }
}
