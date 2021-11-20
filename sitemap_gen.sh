#!/bin/bash

#A script to generate sitemap.xml

find . -name '*.html' -not -name '404.html' -printf '%p %TY-%Tm-%Td \n' | sed "s|\./|https://bebyx\.co\.ua/|g" | sed "s|/index\.html||g" > out

cat <<-EOF > sitemap.xml
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9
          http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">
EOF

while read LINE
  do
    echo -e '\t<url>' >> sitemap.xml
    echo -e "\t\t<loc>`echo "$LINE" | cut -d " " -f1`</loc>" >> sitemap.xml
    echo -e "\t\t<lastmod>`echo "$LINE" | cut -d " " -f2`</lastmod>" >> sitemap.xml
    echo -e '\t</url>' >> sitemap.xml
done < out

echo '</urlset>' >> sitemap.xml

rm ./out

exit
