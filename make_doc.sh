#!/bin/bash -ve

dune build @doc
rsync -avz --delete _build/default/_doc/_html/ubase/Ubase/ docs
for file in $(find docs/ -name index.html)
    #"docs/index.html" "docs/Ttf/index.html" "docs/Ttf/Style/index.html"
do
    echo $file
    sed -i 's|"../../|"|g' $file
    sed -i 's|<span class="arrow">&#45;&gt;</span>|<span class="arrow">→</span>|g' $file
    sed -i 's|val</span>\([^:]*\) :|val</span><span class="val">\1</span> :|g' $file
done

CSS=docs/odoc.support/odoc.css
sed -i "s| (ubase.Ubase)||g" docs/index.html
cp -r ./_build/default/_doc/_html/odoc.support docs/
chmod 644 $CSS
#echo "header nav {display: none;} header nav.toc {display: block;} header dl dd, header dl dt {display: inline-block;} " >> $CSS
echo "span.keyword {color: #999;} span.val {font-weight: bold;}" >> $CSS

echo "Done"
