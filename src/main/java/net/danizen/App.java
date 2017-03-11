package net.danizen;

import com.norconex.collector.http.HttpCollector;
import com.norconex.collector.http.HttpCollectorConfig;

/**
 * Program to crawl and commit collected data to Solr.
 */
public class App 
{
    public static void main( String[] args )
    {
        HttpCollectorConfig config = new HttpCollectorConfig();
        config.setId("myid");
        config.setLogsDir("logs");
        
        HttpCollector collector = new HttpCollector(config);
        collector.start(true);
    }
}

