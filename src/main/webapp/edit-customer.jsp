<%@ page import="dao.Database" %>
<%@ page import="dao.customerDao" %>
<%@ page import="domain.Customer" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.List" %>
<%@include file="includes/header.jsp"%>
<%@ page import="java.util.Optional" %>
    <main>
        <script  type="text/javascript">
            $(document).ready(function() {
                $("form").on("submit", function(event) {
                    event.preventDefault();
                    var formValue = $(this).serialize();
                    $.post("modify-customer", formValue, function(data) {
                        $("#result").html(data);
                    });
                });
            });
        </script>
        <form>
        <%
                Database database = new Database();
                customerDao customerDao = new customerDao(database.getConnection());
                try{
                    String id = request.getParameter("customerId");
                    int id = Integer.parseInt(id);
                    Optional<customer> optCustomer = customerDao.findById(id);
                    Customer customer = optCustomer.orElse(null);

            %>
            <div class="row mb-3">
                <span class="col-sm-2 col-form-label">ID</span>
                <div class="col-sm-10">
                    <span><%= customer.getId() %></span>
                    <input type="hidden" name="id" value="<%= customer.getId() %>" />
                </div>
            </div>
            <div class="row mb-3">
                <label for="title" class="col-sm-2 col-form-label">Name</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="name" value="<%= customer.getName() %>"/>
                </div>
            </div>
            <div class="row mb-3">
                <label for="author" class="col-sm-2 col-form-label">Dni</label>
                <div class="col-sm-10">
                    <input type="text" name="dni" class="form-control" id="author" value="<%= customer.getDni() %>"/>
                </div>
            </div>
            <div class="row mb-3">
                            <label for="phone_number" class="col-sm-2 col-form-label">Phone</label>
                            <div class="col-sm-10">
                                <input type="text" name="phone_number" class="form-control" id="phone_number" value="<%= customer.getPhone_number


                                sa() %>"/>
                            </divAD>


                        </div>
            <button type="submit" class="btn btn-primary">Save changes</button>
            <% }catch(SQLException sqle){}
            %>
        </form>
        <div id="result"></div>
    </main>
</body>
</html>