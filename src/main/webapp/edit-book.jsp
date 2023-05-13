<%@ page import="dao.Database" %>
<%@ page import="dao.BookDao" %>
<%@ page import="domain.Book" %>
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
                    $.post("modify-book", formValue, function(data) {
                        $("#result").html(data);
                    });
                });
            });
        </script>
        <form>
        <%
                Database database = new Database();
                BookDao bookDao = new BookDao(database.getConnection());
                try{
                    String isbn = request.getParameter("isbn");
                    Optional<Book> optBook = bookDao.findByIsbn(isbn);
                    Book book = optBook.orElse(null);

            %>
            <div class="row mb-3">
                <span class="col-sm-2 col-form-label">ISBN</span>
                <div class="col-sm-10">
                    <span><%= book.getIsbn() %></span>
                    <input type="hidden" name="isbn" value="<%= book.getIsbn() %>" />
                </div>
            </div>
            <div class="row mb-3">
                <label for="title" class="col-sm-2 col-form-label">Title</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="title" value="<%= book.getTitle() %>"/>
                </div>
            </div>
            <div class="row mb-3">
                <label for="author" class="col-sm-2 col-form-label">Author</label>
                <div class="col-sm-10">
                    <input type="text" name="author" class="form-control" id="author" value="<%= book.getAuthor() %>"/>
                </div>
            </div>
            <div class="row mb-3">
                <span class="col-sm-2 col-form-label"><%= book.getGenre() %></span>
                <div class="col-sm-10">
                    <select class="form-select" aria-label="Default select example" name="genre">
                        <option value="Terror">Terror</option>
                        <option value="Romance">Romantica</option>
                        <option value="Thriller">Thriller</option>
                        <option value="Adventure">Aventura</option>
                        <option value="Science fiction">Ciencia Ficcion</option>
                        <option value="Police">Policiaca</option>
                      </select>
                </div>
            </div>
            <button type="submit" class="btn btn-primary">Save changes</button>
            <% }catch(SQLException sqle){}
            %>
        </form>
        <div id="result"></div>
    </main>
</body>
</html>