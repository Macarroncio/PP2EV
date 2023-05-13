package dao;

import domain.Book;
import exception.BookAlreadyExistsException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Optional;

public class BookDao {

    private Connection connection;

    public BookDao(Connection connection) {
        this.connection = connection;
    }


    public void add(Book book) throws SQLException, BookAlreadyExistsException {
        if (existBook(book.getIsbn()))
            throw new BookAlreadyExistsException("This book already exists");
        String sql = "INSERT INTO books (isbn, title, author, genre) VALUES (?, ?, ?, ?)";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, book.getIsbn());
        statement.setString(2, book.getTitle());
        statement.setString(3, book.getAuthor());
        statement.setString(4, book.getGenre());
        statement.executeUpdate();
    }

    public boolean delete(String isbn) {
        try {
            String sql = "DELETE FROM books WHERE isbn = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, isbn);
            int rows = statement.executeUpdate();

            return rows == 1;
        }catch (SQLException sqle){
            System.out.println("Problems probably related with this book appearing in other tables");
            sqle.printStackTrace();
            return false;
        }

    }

    public boolean modify(String isbn, Book book) throws SQLException, BookAlreadyExistsException {
        if (existBook(book.getIsbn()))
            throw new BookAlreadyExistsException("This book already exists");

        String sql = "UPDATE books SET title = ?, author = ?, genre = ? WHERE isbn = ?";

        PreparedStatement statement = connection.prepareStatement(sql);

        statement.setString(1, book.getTitle());
        statement.setString(2, book.getAuthor());
        statement.setString(3, book.getGenre());
        statement.setString(4, book.getIsbn());

        int rows = statement.executeUpdate();
        return rows == 1;
    }

    public ArrayList<Book> showAll() throws SQLException {
        String sql = "SELECT * FROM books ORDER BY title";
        ArrayList<Book> books = new ArrayList<>();

        PreparedStatement statement = connection.prepareStatement(sql);
        ResultSet resultSet = statement.executeQuery();
        while (resultSet.next()) {
            Book book = new Book();
            book.setIsbn(resultSet.getString("isbn"));
            book.setTitle(resultSet.getString("title"));
            book.setAuthor(resultSet.getString("author"));
            book.setGenre(resultSet.getString("genre"));
            books.add(book);
        }

        return books;
    }

    public Optional<Book> findByIsbn(String isbn) throws SQLException {
        String sql = "SELECT * FROM books WHERE isbn = ?";
        Book book = null;

        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, isbn);
        ResultSet resultSet = statement.executeQuery();
        if (resultSet.next()) {
            book = new Book();
            book.setIsbn(resultSet.getString("isbn"));
            book.setTitle(resultSet.getString("title"));
            book.setAuthor(resultSet.getString("author"));
            book.setGenre(resultSet.getString("genre"));
        }

        return Optional.ofNullable(book);
    }

    public Optional<Book> findByTitle(String title) throws SQLException {
        String sql = "SELECT * FROM books WHERE title = ?";
        Book book = null;

        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, title);
        ResultSet resultSet = statement.executeQuery();
        if (resultSet.next()) {
            book = new Book();
            book.setIsbn(resultSet.getString("isbn"));
            book.setTitle(resultSet.getString("title"));
            book.setAuthor(resultSet.getString("author"));
            book.setGenre(resultSet.getString("genre"));
        }

        return Optional.ofNullable(book);
    }

    private boolean existBook(String title) throws SQLException {
        Optional<Book> book = findByTitle(title);
        return book.isPresent();
    }
}






