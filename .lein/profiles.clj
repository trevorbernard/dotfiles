{:user {:plugins [[lein-ring "0.9.7"]
                  [lein-ancient "0.6.14"]
                  [lein-spell "0.1.0"]
                  [codox "0.10.0"]
                  [cider/cider-nrepl "0.15.1"]
                  [lein-kibit "0.1.2"]
                  [jonase/eastwood "0.2.3"]
                  [lein-clojars "0.9.1"]]
        :dependencies [[compliment "0.3.1" :scope "runtime"]]
        :aliases {"ccheck" ^{:doc "Clean and check the source"}
                  ["do" ["clean"] ["check"]]}}}
