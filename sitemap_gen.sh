#!/bin/sh

#A script to generate sitemap.xml

find . -name '*.html' -not -name '404.html' -printf '%p %TY-%Tm-%Td \n' | sed "s|\./|https://bebyx\.co\.ua/|g" | sed "s|/index\.html||g" > out

echo '<?xml version="1.0" encoding="UTF-8"?>' > sitemap.xml
echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' >> sitemap.xml

while read LINE
  do
    echo '\t<url>' >> sitemap.xml
    echo "\t\t<loc>`echo "$LINE" | cut -d " " -f1`</loc>" >> sitemap.xml
    echo "\t\t<lastmod>`echo "$LINE" | cut -d " " -f2`</lastmod>" >> sitemap.xml
    echo '\t</url>' >> sitemap.xml
done < out

echo '</urlset>' >> sitemap.xml

rm ./out

exit
