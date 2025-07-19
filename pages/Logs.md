query-sort-by:: page
id:: 66b1de90-efe0-4475-a82b-96893af32145
query-sort-desc:: true
#+BEGIN_QUERY
{:query [:find (pull ?page [*])
   :in $ ?current
   :where
     [?p :block/name ?current]
     [?b :block/refs ?p]
     [?b :block/page ?page]
     (not [?page :block/journal-day])]
 :inputs [:current-page]
}
#+END_QUERY
