package printed.material;

public class Book {
    public static final String DEFAULT_AUTHOR = "Anonymous";
    public static final String DEFAULT_TITLE = "Untitled";
    public static final int DEFAULT_PAGE_COUNT = 1;

    private String author;
    private String title;
    protected int pageCount;


    protected void initBook(String author, String title, int pageCount) {
        this.author = author;
        this.title = title;
        this.pageCount = pageCount;
    }

    public Book() {
        this.checkInitData(DEFAULT_AUTHOR, DEFAULT_TITLE, DEFAULT_PAGE_COUNT);
        this.initBook(DEFAULT_AUTHOR, DEFAULT_TITLE, DEFAULT_PAGE_COUNT);
    }

    public Book(String author, String title, int pageCount) {
        this.checkInitData(author, title, pageCount);
        this.initBook(author, title, pageCount);
    }

    public String getAuthor() {
        return this.author;
    }

    public String getTitle() {
        return this.title;
    }

    public int getPageCount() {
        return this.pageCount;
    }

    private void checkInitData(String author, String title, int pageCount) {
        if (author.length() < 2 || title.length() < 4 || pageCount <= 0) {
            throw new IllegalArgumentException("Nem felel meg a követelményeknek: " + author + title);
        }
    }


}