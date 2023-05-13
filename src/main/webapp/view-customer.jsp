<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="dao.Database" %>
<%@ page import="dao.CustomerDao" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="domain.Customer" %>
<%@ page import="java.util.Optional" %>
<%
Connection connection;
Database db = new Database();
connection = db.getConnection();
CustomerDao customerDao = new CustomerDao(connection);
String customerId = request.getParameter("customerId");
int id = Integer.parseInt(customerId);
Optional<Customer> optionalCustomer = customerDao.findById(id);
Customer customer = optionalCustomer.orElse(null);
String name = customer.getName();
String dni = customer.getDni();
String phone_number = customer.getPhone_number();
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Detalles del cliente</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <style>
        .card-body {
          white-space: nowrap;
        }
      </style>
</head>
<body>
  <h1 class="text-center">Detalle del cliente</h1>
  <div class="container-fluid d-flex align-items-center justify-content-center vh-100">
    <div class="card">
      <div class="card-body">
        <div class="row">
          <div class="col-md-6">
            <h5>ID:</h5>
          </div>
          <div class="col-md-6">
            <h5><%= id %></h5>
          </div>
        </div>
        <div class="row">
          <div class="col-md-6">
            <h5>Name: </h5>
          </div>
          <div class="col-md-6">
            <h5><%= name %></h5>
          </div>
        </div>
        <div class="row">
          <div class="col-md-6">
            <h5>DNI:</h5>
          </div>
          <div class="col-md-6">
            <h5><%= dni %></h5>
          </div>
        </div>
        <div class="row">
          <div class="col-md-6">
            <h5>Phone:</h5>
          </div>
          <div class="col-md-6">
            <h5><%= phone_number %></h5>
          </div>
        </div>
       </div>
      </div>
    </div>
</div>
</body>
</html>