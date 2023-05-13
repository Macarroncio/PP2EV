<%@ page import="dao.Database" %>
<%@ page import="dao.CustomerDao" %>
<%@ page import="domain.Customer" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.List" %>
<%@include file="includes/header.jsp"%>


    <main class="container">
        <section class="mb-5">
            <div class="row border-bottom border-2">
                <div class="col-3 col-md-2">DNI</div>
                <div class="col-6 col-md-2">Name</div>
                <div class="col-3 col-md-2">Phone</div>
            </div>
             <%
                 Database database = new Database();
                 CustomerDao customerDao = new CustomerDao(database.getConnection());
                 try{
                     List<Customer> customersList = customerDao.showAll();
                     for (Customer customer : customerDao.showAll()) {
             %>
            <div class="row mb-1">

                <div class="col-3 col-md-2 text-truncate"><%= customer.getDni() %></div>
                <div class="col-6 col-md-2 text-truncate"><%= customer.getName() %></div>
                <div class="col-3 col-md-2 text-truncate"><%= customer.getPhone_number() %></div>
                <div class="col-12 col-md-2 ms-md-2 text-truncate mt-2 d-flex justify-content-center">
                                    <button type="button" class="btn btn-primary me-3">
                                         <a href="view-customer.jsp?customerId=<%=customer.getId()%>">
                                         <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                             class="bi bi-pen" viewBox="0 0 16 16">
                                             <path
                                                 d="m13.498.795.149-.149a1.207 1.207 0 1 1 1.707 1.708l-.149.148a1.5 1.5 0 0 1-.059 2.059L4.854 14.854a.5.5 0 0 1-.233.131l-4 1a.5.5 0 0 1-.606-.606l1-4a.5.5 0 0 1 .131-.232l9.642-9.642a.5.5 0 0 0-.642.056L6.854 4.854a.5.5 0 1 1-.708-.708L9.44.854A1.5 1.5 0 0 1 11.5.796a1.5 1.5 0 0 1 1.998-.001zm-.644.766a.5.5 0 0 0-.707 0L1.95 11.756l-.764 3.057 3.057-.764L14.44 3.854a.5.5 0 0 0 0-.708l-1.585-1.585z">
                                             </path>
                                         </svg>
                                         </a>
                                     </button>

                                     <button type="button" class="btn btn-primary me-3">
                                         <a href="edit-customer.jsp?customerId=<%=customer.getId()%>">
                                         <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                             class="bi bi-pen" viewBox="0 0 16 16">
                                             <path
                                                 d="m13.498.795.149-.149a1.207 1.207 0 1 1 1.707 1.708l-.149.148a1.5 1.5 0 0 1-.059 2.059L4.854 14.854a.5.5 0 0 1-.233.131l-4 1a.5.5 0 0 1-.606-.606l1-4a.5.5 0 0 1 .131-.232l9.642-9.642a.5.5 0 0 0-.642.056L6.854 4.854a.5.5 0 1 1-.708-.708L9.44.854A1.5 1.5 0 0 1 11.5.796a1.5 1.5 0 0 1 1.998-.001zm-.644.766a.5.5 0 0 0-.707 0L1.95 11.756l-.764 3.057 3.057-.764L14.44 3.854a.5.5 0 0 0 0-.708l-1.585-1.585z">
                                             </path>
                                         </svg>
                                         </a>
                                     </button>

                                     <button type="submit" class="btn btn-outline-danger">
                                         <a href="delete-customer?customerId=<%= customer.getId() %>">
                                         <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                             class="bi bi-x-octagon-fill" viewBox="0 0 16 16">
                                             <path
                                                 d="M11.46.146A.5.5 0 0 0 11.107 0H4.893a.5.5 0 0 0-.353.146L.146 4.54A.5.5 0 0 0 0 4.893v6.214a.5.5 0 0 0 .146.353l4.394 4.394a.5.5 0 0 0 .353.146h6.214a.5.5 0 0 0 .353-.146l4.394-4.394a.5.5 0 0 0 .146-.353V4.893a.5.5 0 0 0-.146-.353L11.46.146zm-6.106 4.5L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 1 1 .708-.708z">
                                             </path>
                                         </svg>
                                         </a>
                                     </button>
                </div>
            </div>
            <%
                 }
            }catch(SQLException sqle){}

            %>
        </section>

    <script type="text/javascript">
        $(document).ready(function() {
            $("form").on("submit", function(event) {
                event.preventDefault();
                var formValue = $(this).serialize();
                $.post("add-customer", formValue, function(data) {
                    $("#result").html(data);
                });
            });
        });
    </script>
        <section>
            <form>
                <div class="row mb-3">
                    <label for="inputDni" class="col-sm-2 col-form-label">DNI</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="inputDni" name="dni" />
                    </div>
                </div>
                <div class="row mb-3">
                    <label for="inputName" class="col-sm-2 col-form-label">Title</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="inputName" name="name" />
                    </div>
                </div>
                <div class="row mb-3">
                    <label for="phone_number" class="col-sm-2 col-form-label">Phone</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="inputPhone" name="phone_number"/>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary">Register customer</button>
            </form>
        </section>
    </main>
</body>

</html>