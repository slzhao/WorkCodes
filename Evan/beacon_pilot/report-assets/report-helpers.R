# reporttemplates: table and figure helpers, sourced by the report's setup chunk.
# Needs gt, DT and ggplot2.

# Two-colour palette for groups (teal, rust). Pair colour with line type or shape so groups
# stay distinguishable in greyscale.
report_palette <- c("#237a89", "#b85c38")

# ggplot2 look: minimal theme, white background, legend at the bottom.
ggplot2::theme_set(ggplot2::theme_minimal(base_size = 13) + ggplot2::theme(
  panel.grid.minor = ggplot2::element_blank(), plot.title.position = "plot",
  plot.title = ggplot2::element_text(face = "bold"), legend.position = "bottom",
  plot.background = ggplot2::element_rect(fill = "white", colour = NA),
  panel.background = ggplot2::element_rect(fill = "white", colour = NA)))

# House style for gt tables (also for gtsummary tables after gtsummary::as_gt()).
# 18px text; quarto.disable_processing stops Quarto restyling the table (no effect elsewhere).
style_gt <- function(tbl) {
  gt::tab_options(tbl,
    table.width = gt::pct(100), table.font.names = c("Arial", "sans-serif"),
    table.font.size = gt::px(18), data_row.padding = gt::px(10),
    table.background.color = "white", table.font.color = "#243747",
    column_labels.background.color = "#edf4f5", table.border.top.color = "#237a89",
    table.border.top.width = gt::px(3),
    quarto.disable_processing = TRUE)
}

# Downloadable table: search, sort, pages, and CSV/Excel export buttons.
#   data     data frame to show (all rows are embedded in the HTML file)
#   id       short unique name; used for the HTML element and the download file names
#   colnames column headings to show (default: the data's column names)
#   wide     TRUE for many columns: gives each column a minimum width of 150px
# "filtered rows" exports every row matching the search, across all pages;
# "CSV: all rows" exports the whole table even when a search is active.
result_table <- function(data, id, colnames = names(data), wide = FALSE) {
  export_filtered <- list(columns = ":visible", modifier = list(search = "applied", page = "all"))
  export_all <- list(columns = ":visible", modifier = list(search = "none", page = "all"))
  DT::datatable(data, rownames = FALSE, colnames = colnames,
    elementId = id, extensions = "Buttons", class = "display compact stripe",
    selection = "none", escape = TRUE, width = "100%",
    options = list(
      dom = "Blfrtip", pageLength = 10, lengthMenu = c(10, 25, 50, 100),
      scrollX = TRUE, autoWidth = TRUE, order = list(list(0, "asc")),
      buttons = list(
        list(extend = "csvHtml5", text = "CSV: filtered rows", filename = paste0(id, "-filtered"), exportOptions = export_filtered),
        list(extend = "excel", text = "Excel: filtered rows", filename = paste0(id, "-filtered"), exportOptions = export_filtered),
        list(extend = "csvHtml5", text = "CSV: all rows", filename = paste0(id, "-all"), exportOptions = export_all)
      ),
      columnDefs = if (wide) list(list(width = "150px", targets = seq_len(ncol(data)) - 1L)) else list(),
      language = list(search = "Find rows:", lengthMenu = "Show _MENU_ rows",
                      info = "_START_–_END_ of _TOTAL_ rows")
    ))
}
