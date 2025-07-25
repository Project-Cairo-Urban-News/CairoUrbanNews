declare namespace t = "http://www.tei-c.org/ns/1.0";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "text";
declare variable $dir external;

"# Person Roles&#xa;" ||
(
let $coll := collection($dir || "?select=*.xml")
let $ARABIC := "http://www.w3.org/2013/collation/UCA?lang=ar"
return string-join(
for $role in sort(distinct-values($coll//t:TEI[t:teiHeader/t:revisionDesc/@status='cleared']//t:persName/@role), $ARABIC)
let $files := distinct-values($coll//t:TEI[t:teiHeader/t:revisionDesc/@status='cleared']//t:persName[@role=$role]/base-uri())
return " * '" || $role || "': &#x200E;" ||
    string-join(
        for $f in $files 
        let $url := "https://project-cairo-urban-news.github.io/CairoUrbanNews/?name=" || replace($f, "^.*/articles/(arabic|ottoman)/([^/]+)$", "$1/$2") || "&amp;text=" || encode-for-uri(replace($role, "[-_]", " "))
        return "[" || replace($f, "^.*/([^/]+)$", "$1") || "](" || $url || ")", ", "
    ) || "&#xa;"
))