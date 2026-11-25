package printed.material.specific;

import printed.material.Book;
import printed.material.CoverType;

public class PrintedBook extends Book {
    protected CoverType coverType;

    public PrintedBook(Book book) {
        this(book.getAuthor(), book.getTitle(), book.getPageCount(), CoverType.HARDCOVER);
    }

    public PrintedBook(String author, String title, int pageCount, CoverType coverType) {
        super(author, title, pageCount + 6);
        this.coverType = coverType;
    }

    @Override
    public int getPrice() {
        return ((coverType == CoverType.SOFTCOVER) ? 2 : 3) * pageCount;
    }

    @Override
    public String toString() {
        return super.toString() + " (" + coverType + ")";
    }
}