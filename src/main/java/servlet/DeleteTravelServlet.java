package servlet;

import dao.BookDao;
import dao.Database;



import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import java.sql.Connection;


@WebServlet("/delete-travel")
public class DeleteTravelServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String travelDestination = request.getParameter("travelDestination");

        Database db = new Database();
        Connection connection = db.getConnection();
        BookDao bookDao = new BookDao(connection);
        bookDao.delete(travelDestination);

        response.sendRedirect("index.jsp");
    }
}