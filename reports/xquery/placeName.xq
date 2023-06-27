declare namespace t = "http://www.tei-c.org/ns/1.0";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "text";
declare variable $dir external;

"# Place Types&#xa;" ||
(
let $coll := collection($dir || "?select=*.xml")
let $ARABIC := "http://www.w3.org/2013/collation/UCA?lang=ar"
for $type in sort(distinct-values($coll//t:TEI[t:teiHeader/t:revisionDesc/@status='cleared']//t:placeName/@type), $ARABIC)
let $files := distinct-values($coll//t:TEI[t:teiHeader/t:revisionDesc/@status='cleared']//t:placeName[@type=$type]/base-uri())
return " * '" || $type || ": '&#x200E;" ||
    string-join(
        for $f in $files 
        let $url := "https://project-cairo-urban-news.github.io/CairoUrbanNews/?name=" || replace($f, "^.*/articles/(arabic|ottoman)/([^/]+)$", "$1/$2") || "&amp;text=" || encode-for-uri(replace($type, "[-_]", " "))
        return "[" || replace($f, "^.*/([^/]+)$", "$1") || "](" || $url || ")", ", "
    ) || "&#xa;"
)