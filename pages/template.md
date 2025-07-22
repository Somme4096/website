- #+BEGIN_IMPORTANT
  **注意**：このページは開発者専用のページです。もしあなたがサイトの閲覧者である場合、このページには有用な情報がありません。他のページを閲覧してください。
  #+END_IMPORTANT
- #+BEGIN_IMPORTANT
  **WARNING**: This page is for developer only. Visitors are recommended to navigate to other pages."
  #+END_IMPORTANT
- publish:: false
- # Component type
	- template:: ReferencedNote
	  collapsed:: true
	  #+BEGIN_QUERY
	  { :query (and (property :type [[note]] ) (property :tags [[]] )(not (page [[template]]))  (not))}}
	  #+END_QUERY
	- template:: SearchText
	  collapsed:: true
	  #+BEGIN_QUERY		  
	  {:title "SearchText"
	  		  :query
	  		   [:find (pull ?b [*])
	  		    :in $ ?pattern
	  		    :where
	  		    [?b :block/content ?c]
	  		    [(re-pattern ?pattern) ?q]
	  		    [(re-find ?q ?c)]]
	  		   :inputs ["note"]
	  		   :collapsed? true}
	  #+END_QUERY
	- template:: RefTable
	  #+BEGIN_QUERY
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
	- template:: Subproject
	  #+BEGIN_QUERY
	  {:title [:h3"サブプロジェクト"]
	   :query [:find (pull ?p [*])
	    :in $ ?current
	    :where
	     [?c :block/name ?current]
	     [?p :block/namespace ?c]
	   ]
	   :inputs [:query-page]
	  }
	  #+END_QUERY
	- template:: Links
	  #+BEGIN_QUERY
	  {:title [:h3 "[[links]] "]
	   :inputs [:current-page]
	    :query [:find (pull ?b [*])
	      :in $ ?current
	      :where
	             [?p :block/name ?current]    ; get current page
	             [?b :block/page ?p]          ; block must be on current page    
	             [ ?b :block/content ?content]    
	             [(clojure.string/includes? ?content "http")]
	    ]
	  }
	  #+END_QUERY
	- template:: References
	  #+BEGIN_QUERY
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
	- template:: ReferencedTask
	  #+BEGIN_QUERY
	  {:title [:h3 "参照されているタスク"]
	   :query [:find (pull ?b [*])
	     :in $ ?page %
	     :where
	       [?b :block/marker "TODO"]
	       [?p :block/name ?page]
	       (or-join [?b ?p]
	         (check-ref ?p ?b) 
	         (and 
	            [?p :block/alias ?a]
	            (check-ref ?a ?b)
	         )
	       )
	   ]
	   :rules [
	     [(check-ref ?p ?b)
	       [?b :block/refs ?p]
	     ]
	     [(check-ref ?p ?b)
	       [?b :block/parent ?t]
	       (check-ref ?p ?t)
	     ]
	   ]
	   :table-view? false
	   :inputs [:current-page]
	  }
	  #+END_QUERY
	- template:: ReferencedTaskbyTag
	  collapsed:: true
	  #+BEGIN_QUERY		 
	   {:title [:h3"All TODO items related to the tag"]
	  		  :query
	  		   [:find (pull ?b [*])
	  		    :where
	  		    [?b :block/marker "TODO"]
	  		    [?b :block/page ?p]
	  		    (or [?b :block/path-ref-pages [:page/name "school"]]
	  		        [?p :page/tags [:page/name "school"]])
	  		  ]
	  		   :collapsed? true}
	  #+END_QUERY
- # Page type
	- ## Logs
	  template:: project
	  template-including-parent:: false
		- type:: [[Logs]]
		    status:: [[TODO]] 
		    date:: <%today%>
		    tags::
	- ## ☘️ノートカード
	  template:: notecard
		- type:: [[note]]
		  tags::
		- #### [[links]]
	- ## 📃 エッセイ
	  template:: essay
		- type:: [[essay]]
		  tags::
	- ## 📝ノートページ
	  template:: notepage
		- type:: [[note]]
		  tags::
		- #+BEGIN_QUERY
		  {:query [:find (pull ?page [*])
		     :in $ ?current
		     :where
		       [?p :block/name ?current]
		       [?b :block/refs ?p]
		       [?b :block/page ?page]
		   ]
		   :inputs [:current-page]
		  }
		  #+END_QUERY
		- #+BEGIN_QUERY
		  {:title [:h3 " [[🖇️links]] "]
		   :inputs [:current-page]
		    :query [:find (pull ?b [*])
		      :in $ ?current
		      :where
		             [?p :block/name ?current]    ; get current page
		             [?b :block/page ?p]          ; block must be on current page    
		             [ ?b :block/content ?content]    
		             [(clojure.string/includes? ?content "http")]
		    ]
		  }
		  #+END_QUERY
		- #+BEGIN_QUERY
		  {:title [:h3" [[📝References]] "]
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