{:user {:plugins [[cider/cider-nrepl "0.27.3"]
                  [lein-ancient "1.0.0-RC3"]]
        :dependencies [[compliment "0.3.12" :scope "runtime"]]
        :aliases {"ccheck" ^{:doc "Clean and check the source"}
                  ["do" ["clean"] ["check"]]}}}
