{:user {:plugins [[lein-ring "0.8.3"]
                  [org.bodil/lein-noderepl "0.1.11"]
                  [lein-ancient "0.5.5"]
                  [lein-spell "0.1.0"]
                  [codox "0.6.4"]
                  [lein-ancient "0.5.5"]
                  [cider/cider-nrepl "0.8.0-SNAPSHOT"]
                  [lein-kibit "0.0.8"]
                  [jonase/eastwood "0.1.0"]
                  [lein-clojars "0.9.1"]]
        :dependencies [[compliment "0.0.3" :scope "runtime"]]
        :aliases {"ccheck" ^{:doc "Clean and check the source"}
                  ["do" ["clean"] ["check"]]}}}
