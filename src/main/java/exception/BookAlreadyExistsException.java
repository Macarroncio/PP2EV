package exception;

public class BookAlreadyExistsException extends Exception {

    public BookAlreadyExistsException(String message) {
        super(message);
    }

    public BookAlreadyExistsException() {
        super("Travel already exists");
    }
}
