# Michael Z (MichaelZ@cs.umass.edu) 6/2019
# Script to convert robust04 topics into queries for Galago's batch search.


from bs4 import BeautifulSoup
import sys
import string

input_file = sys.argv[1]
out_file_path =  sys.argv[2]
out_file = open(out_file_path, 'w')
out_file.write('{ "queries" : [')
with open(input_file) as fp:
    soup = BeautifulSoup(fp.read(), features="lxml" )

# topic file is not well formed XML - there are no end tags for "num" or "title" so
# we'll add them in so we can easily use beautiful soup
cleanSoup = BeautifulSoup(str(soup).replace("<title>", "</num><title>").replace("<desc>", "</title><desc>"), features="lxml")

topics = cleanSoup.find_all('top')

for topic in topics:

    query_num = topic.num.text.replace('Number:', '').strip()
    # strip out punctuation from: https://stackoverflow.com/questions/265960/best-way-to-strip-punctuation-from-a-string-in-python
    query_text = topic.title.text.strip().translate(str.maketrans('', '', string.punctuation))
    out_file.write(' {{\n "number" : "{}",\n"text" : "{}"\n}},'.format(query_num, query_text));

out_file.write('] }')
out_file.close()