type:: [[小説]]

- #+BEGIN_QUERY
  {:query [:find (pull ?page [*])
     :in $ ?current
     :where
       [?p :block/name ?current]
       [?b :block/refs ?p]
       [?b :block/page ?page]
       (not [?page :block/journal-day]) 
   ]
   :inputs [:current-page]
  }
  #+END_QUERY