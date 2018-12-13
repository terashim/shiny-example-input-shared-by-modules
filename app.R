# Shiny moduleへのreactiveな値の受け渡し
library(shiny)

# モジュールの定義 ------------------------------

# histモジュールのUI
histPlotUI <- function(id) {
  ns <- NS(id)
  tagList(
    plotOutput(ns("distPlot"))
  )
}

# histモジュールのサーバー側ロジック
histPlot <- function(input, output, session, color, inputBins) {
  output$distPlot <- renderPlot({
    x    <- faithful[, 2] 
    
    # 悪い例その１: 名前空間の違いでモジュールの親階層から値を受け取れない
    # bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    bins <- seq(min(x), max(x), length.out = inputBins() + 1)
    hist(x, breaks = bins, col = color, border = 'white')
  })
}

# UI ------------------------------
ui <- fluidPage(
  column(
    12,
    h3("共通の入力"),
    # モジュールの外で定義されたスライダー入力
    # これを複数のモジュール間で共有したい
    sliderInput(
      inputId = "bins",
      label = "Number of bins :",
      min = 1, max = 50, value = 30
    )
  ),
  column(
    6,
    h3("histモジュール１"),
    # histモジュールのUI呼び出し
    histPlotUI("hist1")
  ),
  column(
    6,
    h3("histモジュール２"),
    # histモジュールのUI呼び出し
    histPlotUI("hist2")
  )
)

# サーバー ------------------------------
server <- function(input, output, session) {
  
  # 悪い例その２: callModuleにそのままinput$binsを渡しても入力値の変化に対して応答しない
  # callModule(histPlot, "hist1", "darkgray", input$bins)
  # callModule(histPlot, "hist2", "black", input$bins)
  
  # 正解: reactiveなオブジェクトinputBinsを作成してcallModuleに渡す
  inputBins <- reactive(input$bins)
  callModule(histPlot, "hist1", "darkgray", inputBins)
  callModule(histPlot, "hist2", "black", inputBins)
}

# Shinyアプリの開始 ------------------------------
shinyApp(ui = ui, server = server)
