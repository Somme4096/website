- #+BEGIN_QUERY
  {:title [:h3" [[📝 References]] "]
   :inputs [:current-page]
   :query [:find ?link                    ; only care about link name
           :in $ ?current
           :where 
             [?p :block/name ?current]    ; get current page
             [?b :block/page ?p]          ; block must be on current page
             [?b :block/refs ?refpage]    ; blocks with references
             [?refpage :block/name ?link] ; reference page name
  
   ]
   :view (fn [result]
       [:ul (for [link result]
         [:li [:a {:href (str "#/page/" link)} link]]
       )])
  }
  #+END_QUERY