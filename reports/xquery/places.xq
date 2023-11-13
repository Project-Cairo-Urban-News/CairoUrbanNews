declare namespace t = "http://www.tei-c.org/ns/1.0";
declare namespace tf = "http://www.tei-c.org/ns/1.0/functions";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:indent "yes";
declare variable $dir external;
declare variable $dataDir external;

declare function tf:value_or_ref($val as node()) as xs:string {
    if ($val/@ref) then (
        $val/@ref/tokenize(., ' ')[not(contains(., 'http'))]
    ) else (
        normalize-space($val)
    )
};

(: Normalize the input value if it's the empty string or an empty
   sequence, so that we can treat those cases as equal  :)
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
            let $buildings := doc($dataDir || 'WM_Buildings.xml')
            (: use the Arabic collation for sorting :)
            let $ARABIC := "http://www.w3.org/2013/collation/UCA?lang=ar"
            (: make a list in $places of NAME|@type|@ref to try to get actually distinct places :)
            let $places := sort(distinct-values(
                for $p in $coll[//t:revisionDesc[@status='cleared']]//t:text//t:placeName
                return concat(normalize-space($p), '|', $p/@type, '|', $p/@ref),
                $ARABIC))
            (: iterate through the list of distinct places :)
            for $p at $i in $places
            (: split the NAME|@type|@ref back up into a sequence of (NAME, @type, @ref) :)
            let $q := tokenize($p, '\|')
            (: use the collated list values to go back to the actual collection and get the placeName elements 
               matching the current (NAME, @type, @ref) :)
            let $place := $coll[//t:revisionDesc[@status='cleared']]//t:text//t:placeName[normalize-space(.) = $q[1] 
              and tf:empty(@type) = tf:empty($q[2]) 
              and tf:empty(@ref) = tf:empty($q[3]) ]
            (: get the list of files where this place occurs and print them as a URI in the form wm:arabic/1286.xml#place_id :)
            let $files := for $f in sort(distinct-values($place/base-uri()))
              return for $pl in $place where contains($f, substring($pl/@xml:id, 8, 4)) return replace($f, "^.*/articles/(arabic|ottoman)/([^/]+)$", "wm:$1/$2#" || $pl/@xml:id)
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
                    return 
                      ((if($buildings/id(substring-after($p/@xml:id, 'place-'))) then 
                        for $elt in $buildings/id(substring-after($p/@xml:id,'place-'))/*
                        return $elt
                        else ''),
                    <idno>{xs:string($p/@xml:id)}</idno>)
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
      }
    </listPlace>
  </standOff>
</TEI>