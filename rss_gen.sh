#!/bin/bash

#A script to generate rss.xml

find ./log/ -name '*.html' -type f > out

echo -e '<?xml version="1.0" encoding="UTF-8"?>' > rss.xml
echo -e '<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">' >> rss.xml

echo -e '\t<channel>' >> rss.xml
echo -e '\t\t<atom:link href="https://bebyx.co.ua/rss.xml" rel="self" type="application/rss+xml" />' >> rss.xml
echo -e '\t\t<title>bebyx: сайт Артема Бебика</title>' >> rss.xml
echo -e '\t\t<link>https://bebyx.co.ua</link>' >> rss.xml
echo -e '\t\t<description>Тексти українською мовою.</description>' >> rss.xml
echo -e '\t\t<language>uk-UA</language>' >> rss.xml

while read LINE
  do
    url="$(echo "$LINE" | sed 's|\./|https://bebyx\.co\.ua/|g')"
    pubDate="$(cat $LINE | grep "meta property=\"article:published_time\"" | sed 's/^.*content="//g' | sed 's/".*$//g')"

    echo -e '\t\t<item>' >> rss.xml

    echo -e "\t\t\t`cat $LINE | grep \<title\>.*\</title\> | sed 's/^\s*//g' `" >> rss.xml
    echo -e "\t\t\t<author>Артем Бебик</author>" >> rss.xml
    echo -e "\t\t\t<link>$url</link>" >> rss.xml
    echo -e "\t\t\t<guid>$url</guid>" >> rss.xml
    echo -e "\t\t\t<pubDate>` date -d $pubDate -R `</pubDate>" >> rss.xml
    echo -e "\t\t\t<description>`cat $LINE | grep 'meta name=\"description\"' | sed 's/^.*content="//g' | sed 's/">.*$//g' `</description>" >> rss.xml

    echo -e '\t\t</item>' >> rss.xml
done < out


echo -e '\t</channel>' >> rss.xml

echo -e '</rss>' >> rss.xml

rm ./out

sed -i 's/&quot;/"/g' rss.xml

exit
