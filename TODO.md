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


# Writing a summarizer

We port sumy to these java classes

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

