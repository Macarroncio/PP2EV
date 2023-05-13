<%@ page import="dao.Database" %>
<%@ page import="dao.BookDao" %>
<%@ page import="domain.Book" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.List" %>
<%@include file="includes/header.jsp"%>

    <main class="container">
        <section class="mb-5">
            <div class="row border-bottom border-2">
                <div class="col-3 col-md-2">ISBN</div>
                <div class="col-3 col-md-2">Title</div>
                <div class="col-3 col-md-2">Author</div>
                <div class="col-3 col-md-2">Genre</div>
            </div>
            <%
                Database database = new Database();
                BookDao bookDao = new BookDao(database.getConnection());
                try{
                    List<Book> booksList = bookDao.showAll();
                    for (Book book : bookDao.showAll()) {
            %>
            <div class="row mb-1">
                <div class="col-3 col-md-2 text-truncate"><%= book.getIsbn() %></div>
                <div class="col-3 col-md-2 text-truncate"><%= book.getTitle() %></div>
                <div class="col-3 col-md-2 text-truncate"><%= book.getAuthor() %></div>
                <div class="col-3 col-md-2 text-truncate"><%= book.getGenre() %></div>
                <div class="col-12 col-md-2 ms-md-2 text-truncate mt-2 d-flex justify-content-center">
                    <button type="button" class="btn btn-primary me-3">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                            class="bi bi-pen" viewBox="0 0 16 16">
                            <path
                                d="m13.498.795.149-.149a1.207 1.207 0 1 1 1.707 1.708l-.149.148a1.5 1.5 0 0 1-.059 2.059L4.854 14.854a.5.5 0 0 1-.233.131l-4 1a.5.5 0 0 1-.606-.606l1-4a.5.5 0 0 1 .131-.232l9.642-9.642a.5.5 0 0 0-.642.056L6.854 4.854a.5.5 0 1 1-.708-.708L9.44.854A1.5 1.5 0 0 1 11.5.796a1.5 1.5 0 0 1 1.998-.001zm-.644.766a.5.5 0 0 0-.707 0L1.95 11.756l-.764 3.057 3.057-.764L14.44 3.854a.5.5 0 0 0 0-.708l-1.585-1.585z">
                            </path>
                        </svg>
                    </button>
                    <button type="button" class="btn btn-outline-danger">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                            class="bi bi-x-octagon-fill" viewBox="0 0 16 16">
                            <path
                                d="M11.46.146A.5.5 0 0 0 11.107 0H4.893a.5.5 0 0 0-.353.146L.146 4.54A.5.5 0 0 0 0 4.893v6.214a.5.5 0 0 0 .146.353l4.394 4.394a.5.5 0 0 0 .353.146h6.214a.5.5 0 0 0 .353-.146l4.394-4.394a.5.5 0 0 0 .146-.353V4.893a.5.5 0 0 0-.146-.353L11.46.146zm-6.106 4.5L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 1 1 .708-.708z">
                            </path>
                        </svg>
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
                    $.post("AddBook", formValue, function(data) {
                        $("#result").html(data);
                    });
                });
            });
        </script>
        <section class="border border-1 p-5 rounded">
            <form>
                <div class="row mb-3">
                    <label for="isbn" class="col-sm-2 col-form-label">ISBN</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="isbn" name="isbn" />
                    </div>
                </div>
                <div class="row mb-3">
                    <label for="title" class="col-sm-2 col-form-label">Title</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="title" name="title" />
                    </div>
                </div>
                <div class="row mb-3">
                    <label for="author" class="col-sm-2 col-form-label">Author</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="author" name="author" />
                    </div>
                </div>
                <div class="row mb-3">
                    <span class="col-sm-2 col-form-label">Genre</span>
                    <div class="col-sm-10">
                        <select class="form-select" aria-label="Default select example" name="genre">
                            <option selected disabled>Select genre</option>
                            <option value="1">Terror</option>
                            <option value="2">Romantica</option>
                            <option value="3">Thriller</option>
                            <option value="4">Aventura</option>
                            <option value="5">Ciencia Ficcion</option>
                            <option value="6">Policiaca</option>
                        </select>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary">Register book</button>
            </form>
        </section>
    </main>

</body>

</html>