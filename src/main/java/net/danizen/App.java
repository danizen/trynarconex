package net.danizen;

import java.io.File;
import java.io.IOException;

import com.norconex.collector.http.HttpCollector;
import com.norconex.collector.http.HttpCollectorConfig;
import com.norconex.collector.core.CollectorConfigLoader;

import org.apache.commons.cli.DefaultParser;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.Options;
import org.apache.commons.cli.Option;
import org.apache.commons.cli.ParseException;

/**
 * Program to crawl and commit collected data to Solr.
 */
public class App 
{
    public static void main( String[] args )
    {
    		Options options = new Options();
    		options.addOption("c", true, "Path to narconex XML version");
    		options.addOption("v", true, "Path to variables");

    		CommandLineParser parser = new DefaultParser();
    		CommandLine cmd = null;
    		try { 
						cmd = parser.parse(options, args);
    		} catch (ParseException e) {
    				System.err.println("error: cannot parse errors");
    				System.exit(1);
    		}
    		

    		if (cmd.hasOption("c") == false) {
    				System.err.println("error: -c argument required");
    				System.exit(1);
    		}
    		File xmlFile = new File(cmd.getOptionValue("c"));

    		File varsFile = null;
    		if (cmd.hasOption("v") == true) {
    				varsFile = new File(cmd.getOptionValue("v"));
    		}
    		
        HttpCollectorConfig config = null;
				try {
        		config = (HttpCollectorConfig) new CollectorConfigLoader(HttpCollectorConfig.class)
        																			.loadCollectorConfig(xmlFile, varsFile);
        } catch (IOException e) {
        		System.err.println("error: I/O Exception");
        		System.exit(1);
        }
        if (config == null) {
	        	System.err.println("error: config has failed");
	        	System.exit(1);
        }
     		config.setId("myid");
     		config.setLogsDir("logs");
        
        HttpCollector collector = new HttpCollector(config);
        collector.start(true);
    }
}

