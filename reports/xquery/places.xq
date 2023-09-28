declare namespace t = "http://www.tei-c.org/ns/1.0";
declare namespace tf = "http://www.tei-c.org/ns/1.0/functions";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:indent "yes";
declare variable $dir external;

declare function tf:value_or_ref($val as node()) as xs:string {
    if ($val/@ref) then (
        $val/@ref/tokenize(., ' ')[not(contains(., 'http'))]
    ) else (
        normalize-space($val)
    )
};

declare function tf:empty($val) {
    switch ($val)
    case '' return ('empty')
    case () return ('empty')
    default return $val
};

<TEI xmlns="http://www.tei-c.org/ns/1.0">
  {doc("../../master_CairoUrbanNews.xml")//t:teiHeader}
  <standOff>
    <listPlace>
      {
        let $places := 
          <listPlace xmlns="http://www.tei-c.org/ns/1.0">
          {
            let $coll := collection($dir || "?select=*.xml")
            let $ARABIC := "http://www.w3.org/2013/collation/UCA?lang=ar"
            let $places := sort(distinct-values(
                for $p in $coll[//t:revisionDesc[@status='cleared']]//t:text//t:placeName
                return concat(normalize-space($p), '|', $p/@type, '|', $p/@ref),
                $ARABIC))
            for $p at $i in $places
            let $q := tokenize($p, '\|')
            let $place := $coll[//t:revisionDesc[@status='cleared']]//t:text//t:placeName[normalize-space(.) = $q[1] 
              and tf:empty(@type) = tf:empty($q[2]) 
              and tf:empty(@ref) = tf:empty($q[3]) ]
            let $files := for $f in sort(distinct-values($place/base-uri()))
              return replace($f, "^.*/articles/(arabic|ottoman)/([^/]+)$", "https://project-cairo-urban-news.github.io/CairoUrbanNews/?name=$1/$2&amp;text=" || replace(normalize-space($place[1]), ' ', '+'))
            return 
              <place xml:id="pl{$i}">
                <placeName xml:lang="ar">{if ($place[1]/@type) then 
                    attribute type {$place[1]/@type}
                    else ()}{if ($place[1]/@ref) then
                    attribute ref {$place[1]/@ref}
                    else ()}{normalize-space($place[1])}</placeName>
                {
                  if (count($place) gt 0) then
                    for $p in $place 
                    return <idno>{xs:string($p/@xml:id)}</idno>
                  else <idno>{xs:string($place/@xml:id)}</idno>
                }
                {if ($place[1]/@ref/contains(., 'http')) then (
                  for $ref in tokenize($place[1]/@ref, ' ')[contains(., 'http')]
                  return 
                      <idno type="URL">{$ref}</idno>
                ) else () }
                <ptr target="{string-join($files, ' ')}"/>
              </place>
          }
          </listPlace>
          for $p in $places 
          return $p
          (:
        for $name at $i in distinct-values($places//t:placeName/tf:value_or_ref(.))
        let $p := $places//t:place[t:placeName = $name or contains(t:placeName/@ref, $name)]
        return
          for $place at $j in $p
          return 
            <place xml:id="p{$i}-{$j}">
              <placeName xml:lang="ar">{if ($place/t:placeName/@type) then (
                attribute type {$place/t:placeName/@type}
              ) else () }
              {$name}</placeName>
              {$place//t:idno}
              <ptr target="{string-join(distinct-values(sort($place//t:ptr/@target/replace(., "^.*/articles/(arabic|ottoman)/([^/]+)$", "https://project-cairo-urban-news.github.io/CairoUrbanNews/?name=$1/$2&amp;text=" || replace(normalize-space($place/t:placeName), ' ', '+')))), ' ')}"/>
            </place>
            :)
      }
    </listPlace>
  </standOff>
</TEI>