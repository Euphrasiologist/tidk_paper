library(lattice)

d <- read.table("../data/bomSyl_telomeric_repeat_windows.tsv", header = TRUE)

d$telomere_count <- d$forward_repeat_number + d$reverse_repeat_number

d <- d[d$id %in% as.character(1:10), ]
d$id <- factor(d$id, levels = as.character(rev(1:10)))

d <- d[, c("id", "window", "telomere_count")]

# pdf(file = "../img/telomere_plot.pdf")
png(filename = "../img/telomere_plot.png", width = 800)
xyplot(telomere_count ~ window | id,
  data = d,
  type = "l",
  layout = c(1, 10),
  strip = FALSE,
  strip.left = TRUE,
  scales = list(
    y = list(at = NULL),
    x = list(
      at = c(0, 5000000, 10000000, 15000000, 20000000),
      labels = c("0Mb", "5Mb", "10Mb", "15Mb", "20Mb")
    )
  ),
  par.settings = list(strip.background = list(col = "white")),
  xlab = "Length along genome",
  ylab = "Count of AACCT"
)
dev.off()
