#!/bin/sh

#A script to generate log html page template

read -p "Enter slug/filename (*.html): " SLUG

while [ -z $SLUG ]
  do
    echo "Filename can't be empty."
    read -p "Enter slug/filename (*.html): " SLUG
  done

read -p "Enter article's title (for <title> and <h1>): " TITLE

read -p "Enter short description: " DESC

read -p "Enter keywords (separated by comma): " KEYWORDS

read -p "Enter publication date (format: 2020-07-15T12:05EEST). Leave empty to edit later. " PUBDATE

dest="./log/$SLUG"

echo '<!doctype html>' > $dest
echo '<html class="no-js" lang="uk">\n' >> $dest

echo  '\t<head>' >> $dest
echo  '\t\t<meta charset="utf-8">' >> $dest
echo  "\t\t<title>bebyx: $TITLE</title>" >> $dest
echo  "\t\t<meta name=\"description\" content=\"`echo $DESC | sed 's/"/\&quot;/g' `\">" >> $dest
echo  '\t\t<meta name="author" content="Артем Бебик">' >> $dest
echo  "\t\t<meta name=\"keywords\" content=\"$KEYWORDS\">">> $dest
echo  "\t\t<meta property=\"article:published_time\" content=\"$PUBDATE\" />\n" >> $dest

echo  '\t\t<meta name="viewport" content="width=device-width, initial-scale=1">' >> $dest
echo  '\t\t<link rel="stylesheet" href="../main.css">' >> $dest
echo  '\t\t</head>\n' >> $dest

echo  '\t<body>' >> $dest
echo  '\t\t<article>\n' >> $dest
echo  "\t\t\t<header>" >> $dest
echo  "\t\t\t\t<h1>$TITLE</h1>" >> $dest
echo  "\t\t\t\t<small><time datetime=\"$PUBDATE\">` date -d $PUBDATE +%d-%m-%Y `</time></small>" >> $dest
echo  "\t\t\t</header>\n" >> $dest

echo  '\t\t</article>' >> $dest
echo  '\t\t<nav>\n\t\t\t<a href="/">Повернутися</a>\n\t\t</nav>' >> $dest
echo  '\t</body>\n' >> $dest

echo  '</html>' >> $dest
