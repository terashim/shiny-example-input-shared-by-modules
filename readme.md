複数のShinyモジュール間で一つの入力値を共通に利用する
------

Shinyアプリをモジュールで構造化する際、複数のモジュールで共通に利用したい入力値がある場合を考える。
モジュールの階層構造の中で親階層から子階層へと入力値を受け渡すには、`reactive()` を使って工夫する必要がある。

## 参考

* [Using global input values inside of R Shiny modules · goonR blog](https://tbradley1013.github.io/2018/07/20/r-shiny-modules--using-global-inputs/)
* [r - observeEvent Shiny function used in a module does not work - Stack Overflow](https://stackoverflow.com/questions/45169876/observeevent-shiny-function-used-in-a-module-does-not-work)
