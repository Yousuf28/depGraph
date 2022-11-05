#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic
  get_plot <- shiny::eventReactive(input$submit, {
    tags <- as.character(input$pkg)
    dg <- miniCRAN::makeDepGraph(tags, suggests = F)
    p <- plot(dg, legendPosition = c(-1, -1), vertex.size = 10, cex = 0.7)
    p
})
get_table <- shiny::eventReactive(input$submit, {
    tags <- as.character(input$pkg)
    pkgs <- miniCRAN::pkgDep(tags, suggests = FALSE, enhances = FALSE)
    pkgs <- data.frame(dependency = pkgs)
    pkgs
})

 output$plot <- shiny::renderPlot({
     shiny::req(input$submit)
     get_plot()
 })

 output$table <- shiny::renderTable({
     shiny::req(input$submit)
     get_table()
 })
}
