# MedlinePlus Monitor Crawler (OSS version)

## Summary

Uses norconex-collector-http and norconex-committer-elasticsearch to do a crawl of MedlinePlus monitor sites.
Python is also used in the scripts in src/main/assembly to manage the mongodb and elasticsearch resources.

The complete requirements can be viewed in the [MedlinePlus Monitor Crawler](https://wiki.nlm.nih.gov/confluence/x/rIhmBg) document.

## How to build

You can build a version like this:

```
mvn clean package
```

Then, look in the target directory for the ZIP file, and that has everything you need.

## How to use

After you unpack this, run:

```
collector-http -c mplusmonitor.xml -v mplusmonitor.properties -a start
```

This can be run in the background, and then stopped with another crontab:

```
collector-http -c mplusmonitor.xml -v mplusmonitor.porperties -a stop
```

## Next steps

To complete the original design, the following must be done:

- Configure Elasticsearch to use the Synonyms from the IBM Watson search collections for MedlinePlus
- Add a `content_flags` un-analyzed field and configure in the XML `DOMTagger` or `ScriptTagger` instances
  to figure out whether there is structured data.
- Use the Open-i Summarizer to obtain keywords and summary
- Enrich the index also with a summary generated using a general purpose algorithm.

Before any of that is done, we need to run the crawler at scale.
