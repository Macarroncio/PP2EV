package servlet;

import dao.CustomerDao;
import dao.Database;
import domain.Customer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/delete-customer")
public class DeleteCustomer extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();


        int id = Integer.parseInt(request.getParameter("customerId"));

        try{

            Database db = new Database();
            Connection connection = db.getConnection();
            CustomerDao customerDao = new CustomerDao(connection);
            customerDao.delete(id);

            response.sendRedirect("customer.jsp");
        }catch (SQLException sqle){
            out.println("<div class='alert alert-danger' role='alert'>Problems encountered while adding this travel</div>");
            sqle.printStackTrace();
        }
    }
}