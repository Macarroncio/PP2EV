<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="dao.Database" %>
<%@ page import="dao.BookDao" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="domain.Book" %>
<%@ page import="java.util.Optional" %>
<%@include file="includes/header.jsp"%>
<%
Connection connection;
Database db = new Database();
connection = db.getConnection();
BookDao bookDao = new BookDao(connection);
String bookIsbn = request.getParameter("isbn");
Optional<Book> optionalBook = bookDao.findByIsbn(bookIsbn);
Book book = optionalBook.orElse(null);
String title = book.getTitle();
String author = book.getAuthor();
String genre = book.getGenre();
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Detalles del viaje</title>
      <style>
             .card-body {
               white-space: nowrap;
             }
           </style>
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
</head>
<body>
  <div class="container-fluid d-flex align-items-center justify-content-center vh-100">
    <div class="card">
      <div class="card-body">
        <div class="row">
          <div class="col-md-6">
            <h5>ISBN:</h5>
          </div>
          <div class="col-md-6">
            <h5><%= bookIsbn %></h5>
          </div>
        </div>
        <div class="row">
          <div class="col-md-6">
            <h5>Title: </h5>
          </div>
          <div class="col-md-6">
            <h5><%= title %></h5>
          </div>
        </div>
        <div class="row">
                  <div class="col-md-6">
                    <h5>Author: </h5>
                  </div>
                  <div class="col-md-6">
                    <h5><%= author %></h5>
                  </div>
                </div>
                <div class="row">
                          <div class="col-md-6">
                            <h5>Genre: </h5>
                          </div>
                          <div class="col-md-6">
                            <h5><%= genre %></h5>
                          </div>
                        </div>
      </div>
    </div>
  </div>
</body>
</html>

