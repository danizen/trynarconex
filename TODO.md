# Tasks to get to something good

- Read more from Elasticsearch In Action book
- Get rest committer to work for me

# Advanced tasks that aren't really needed right now

- Split the indexing by using the LanguageTagger to tag the language,
  and then index english to an index with an english analyzer, and spanish
  to an index with a spanish analyzer.  Don't index pages in german.
  (this is probably over-engineering)
- Develop some sort of UI
- Write a Summarizer using sumy implementation as guide

# Issues with the crawl

The crawl is *not* stripping boiler plate, and it is not going deep enough.

The lack of boilerplate removal is a big problem for building quality summaries,because we lose the ability to extract sentences - OpenNLP nor NLTK can effectively deal with "Skip navigation Home Healthy Living Volunteering Donate The point we wish to make about nutrition..."

The issue with depth has to do with either robots.txt and depth meters.  When I set the depth to 4 and crawl from the top of "http://www.cancer.org", then I don't find much of anything - I get 52 documents period.  We'll have to experiment and use domain as a facet to see which domains are being crawled well, and why/why not.

# Writing a summarizer

After reviewing the documentation for the summarizers in Sumy, I'm quite happy 
implementing the following sentence extraction summarizers, TfIdfSummarizer, 
which is based solely on the tfidf of terms over the entire crawl, DegreeSummarizer, which is the simpler summarizer with cut-off of .1 discussed in the Lex Rank paper, and LexRankSummarizer.   A SumBasicSummarizer could also be implemented.

To use true IDF, these have to be done after the fact, not within the crawl,
because otherwise IDF is nearly meaningless.  What do you do?  Make each 
sentence a document?  No, using the term info from elastic search is 
clearly the way to go.

Because of the analysis above, there is no need to blindly 

sumy/summarizers/_summarizer.py --> 
	net.danizen.nlp.summary.ISummarizer
	net.danizen.nlp.summary.SentenceInfo
	net.danizen.nlp.summary.AbstractSummarizer

sumy/summarizers/*.py -->
	net.danizen.nlp.summary.impl.LexRankSummarizer (numpy)
	net.danizen.nlp.summary.impl.LsaSummarizer (linear algebra)
	net.danizen.nlp.summary.impl.KLSummarizer  (basic math)
	net.danizen.nlp.summary.impl.BasicSummarizer (word freq)
	net.danizen.nlp.summary.impl.TextRankSummarizer (basic math)
	net.danizen.nlp.summary.impl.EdmundsonSummarizer (other classes)

sumy/summarizers/data/stopwords.py ->
	net.danizen.nlp.stopwords.English
	net.danizen.nlp.stopwords.Spanish
	...

/* NOTE: These may be purely provided by OpenNLP */
sumy/summarizers/nlp/*.py ->
	net.danizen.nlp.stemmers.IStemmer
	net.danizen.nlp.steemmers.NullStemmer
	net.danizen.nlp.tokenizers.ITokenizer

sumy/models/tf.py

	net.danizen.nlp.models.TfDocumentModel
	(maybe can avoid?)

So, start with the stopwords.  Then, implement abstract and BasicSummarizer, TextRankSummarizer, and KLSummarizer.

These will be enough to get started.

NOTE: org.jblas|blas is a linear algebra library for Java.

