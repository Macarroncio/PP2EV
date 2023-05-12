package exception;

public class BookNotFoundException extends Exception {
    public BookNotFoundException(String message) {
        super(message);
    }

    public BookNotFoundException() {
        super("domain.Travel Not Found");
    }
}
