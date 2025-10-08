# Generate regression outputs (tables + plots) from the saved model.

### REQUIRED PACKAGES
library(here)
library(fs)
library(dplyr)
library(ggplot2)
library(broom)
library(lmtest)
library(sandwich)
library(knitr)
library(webshot2)   # to convert HTML tables to PNGs
library(gt) 

# Load the saved model (created by Regression.R)
model_path <- here("gen", "output", "regression_model.rds")
stopifnot(file.exists(model_path))
model <- readRDS(model_path)

# Output directory 
outdir <- here("gen", "output", "regression-results")
fs::dir_create(outdir)

# TABLE: robust (HC3) coefficient table 
robust_vcov <- sandwich::vcovHC(model, type = "HC3")
robust_ct   <- lmtest::coeftest(model, vcov = robust_vcov)
tidy_robust <- broom::tidy(model, conf.int = FALSE, vcov = robust_vcov)

tab_df <- tidy_robust %>%
  dplyr::select(term, estimate, std.error, statistic, p.value)

# Save CSV
readr::write_csv(tab_df, file.path(outdir, "regression_table_robust.csv"))

# Save table with gt
png_path <- file.path(outdir, "regression_table_robust.png")

tab <- gt(tab_df) |>
  tab_header(title = "Regression results (HC3 robust SEs)") |>
  fmt_number(columns = c(estimate, std.error, statistic, p.value), decimals = 3) |>
  cols_label(std.error = "SE", p.value = "p")
gtsave(tab, filename = png_path, vwidth = 1600, vheight = 700)

# PLOT: coefficient estimates ± 95% CI 
tidy_robust <- broom::tidy(model, conf.int = TRUE, conf.level = 0.95, vcov = robust_vcov)

coef_plot <- ggplot(
  tidy_robust |> dplyr::mutate(term = forcats::fct_reorder(term, estimate)),
  aes(x = estimate, y = term)
) +
  geom_point(size = 2, color = "steelblue") +
  geom_errorbarh(aes(xmin = conf.low, xmax = conf.high), height = 0.2, color = "darkred") +
  labs(
    title = "Coefficient estimates with 95% CIs (HC3 robust SEs)",
    x = "Estimate", y = NULL
  )

ggsave(file.path(outdir, "regression_coefficients.png"),
       coef_plot, width = 7, height = 5, dpi = 300)

# ========== PLOT: residuals vs fitted ==========
resid_df <- tibble::tibble(
  fitted = fitted(model),
  resid  = resid(model)
)

rvf_plot <- ggplot(resid_df, aes(x = fitted, y = resid)) +
  geom_point(alpha = 0.5, color = "steelblue") +
  geom_hline(yintercept = 0, linetype = 2, color = "red") +
  labs(title = "Residuals vs Fitted", x = "Fitted values", y = "Residuals")

ggsave(file.path(outdir, "residuals_vs_fitted.png"),
       rvf_plot, width = 6.5, height = 4.5, dpi = 300)