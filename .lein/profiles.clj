{:user {:plugins [[cider/cider-nrepl "0.29.0"]]
        :dependencies [[compliment "0.3.12" :scope "runtime"]]
        :aliases {"ccheck" ^{:doc "Clean and check the source"}
                  ["do" ["clean"] ["check"]]}}}
