package servlet;

import dao.Database;
import dao.BookDao;
import domain.Customer;
import domain.Book;
import exception.BookAlreadyExistsException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet("/modify-book")
public class ModifyBook extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String isbn = request.getParameter("isbn");

        String newTitle = request.getParameter("title");
        String newAuthor = request.getParameter("author");
        String newGenre = request.getParameter("genre");

        Book book = new Book(isbn, newTitle, newAuthor, newGenre);

        Database database = new Database();
        BookDao bookDao = new BookDao(database.getConnection());
        try {
             bookDao.modify(isbn, book);
             out.println("<div class='alert alert-success' role='alert'>Successfully modified</div>");


        } catch (BookAlreadyExistsException baee) {
            out.println("<div class='alert alert-danger' role='alert'>Travel already exists!!!</div>");
            baee.printStackTrace();
        } catch (SQLException sqle) {
            out.println("<div class='alert alert-danger' role='alert'> Problems encountered while adding this travel</div>");
            sqle.printStackTrace();
        }
    }
}