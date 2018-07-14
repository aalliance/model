package aa.util;

import java.io.BufferedReader;
import java.io.IOException;

import java.nio.file.Path;
import java.nio.file.Files;

public class SimpleCSV
{
    private String delimiter;
    private BufferedReader handle;
    private String currentLine;

    public SimpleCSV(Path file, String delimiter) throws IOException
    {
        handle = Files.newBufferedReader(file);

        currentLine = handle.readLine();

        this.delimiter = delimiter;
    }

    public SimpleCSV(Path file) throws IOException
    {
        this(file, ",");
    }

    public boolean hasNext()
    {
        return currentLine != null;
    }

    public String[] nextRecord() throws IOException
    {
        String[] ret = currentLine.split(delimiter);

        currentLine = handle.readLine();

        return ret;
    }

    public void close() throws IOException
    {
        handle.close();
    }
}
