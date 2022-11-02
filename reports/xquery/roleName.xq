declare namespace t = "http://www.tei-c.org/ns/1.0";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "text";
declare variable $dir external;

"#Role Types&#xa;" ||
(
let $coll := collection($dir || "?select=*.xml")
let $ARABIC := "http://www.w3.org/2013/collation/UCA?lang=ar"
for $type in sort(distinct-values($coll//t:roleName/@type), $ARABIC)
let $files := distinct-values($coll//t:roleName[@type=$type]/base-uri())
return " * '" || $type || "': " ||
    string-join(
        for $f in $files 
        let $url := " * /Project-Cairo-Urban-News/CairoUrbanNews/blob/master/" || replace($f, "^.*/articles/(arabic|ottoman)/([^/]+)$", "articles/$1/$2")
        return "[" || replace($f, "^.*/([^/]+)$", "$1") || "](" || $url || ")", ", "
    ) || "&#xa;"
)