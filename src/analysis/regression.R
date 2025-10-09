# Set CRAN mirror
options(repos = c(CRAN = "https://cloud.r-project.org"))

###REQUIRED PACKAGES
library(dplyr)
library(tidyverse)
library(stringr)
library(sandwich)
library(lmtest)
library(car)
library(scales)
library(knitr)
library(here)

merged_df <- readr::read_csv(here("gen", "output", "final_dataset.csv"), show_col_types = FALSE)

## Regression Analysis
# Model: Rating ~ Runtime10 * Genre + Runtime10 * YearGroup + logVotes
# modeling helpers
merged_df <- merged_df %>% mutate(
  logVotes  = log10(numVotes),
  Runtime10 = (runtimeMinutes - mean(runtimeMinutes, na.rm = TRUE)) / 10
)

merged_df <- merged_df %>%
  mutate(
    Genre      = factor(Genre, levels = c("Comedy","Adventure","Action")),  # baseline = Comedy
    year_group = factor(year_group, levels = c("2011-2015","2016-2020"))    # baseline = 2011–2015
  )

model <- lm(averageRating ~ Runtime10*Genre + Runtime10*year_group + logVotes,
            data = merged_df)
summary(model)
#Save the fitted model as an .rds for reproducibility
saveRDS(model, here("gen", "output", "regression_model.rds"))
# β1: slope of Runtime10 for the reference group (Comedy, 2011–2015)
beta1 <- coef(model)[["Runtime10"]]

# Genre interactions change the slope relative to Comedy:
# β5 (Runtime10 × Adventure), β6 (Runtime10 × Action)
beta5 <- coef(model)[["Runtime10:GenreAdventure"]]
beta6 <- coef(model)[["Runtime10:GenreAction"]]

# Year interaction changes the slope for 2016–2020 vs 2011–2015: β7
beta7 <- coef(model)[["Runtime10:year_group2016-2020"]]

# Main effects:
# β2, β3 (genre level shifts vs Comedy), β4 (2016–2020 shift vs 2011–2015)
beta2 <- coef(model)[["GenreAdventure"]]
beta3 <- coef(model)[["GenreAction"]]
beta4 <- coef(model)[["year_group2016-2020"]]

# Control: β8 (effect of a 10x increase in votes)
beta8 <- coef(model)[["logVotes"]]

round(c(beta1=beta1,beta2=beta2,beta3=beta3,beta4=beta4,beta5=beta5,beta6=beta6,beta7=beta7,beta8=beta8), 3)

#Checking Assumptions and Providing Fixes if Necessary
# Build a data frame that matches the model's rows (and order)
assump_df <- cbind(model.frame(model), residuals_lm = resid(model))
# columns in assump_df: averageRating, Runtime10, Genre, YearGroup, logVotes, residuals_lm

# Homoscedasticity (Levene across Genre × YearGroup)
leveneTest(residuals_lm ~ Genre * year_group, data = assump_df, center = mean)

# Robust SEs (fix heteroscedasticity in inference)
robust_se <- vcovHC(model, type = "HC3")
coeftest(model, vcov = robust_se)

# Normality tests on residuals actually used in the model
ks.test(assump_df$residuals_lm, "pnorm",
        mean = mean(assump_df$residuals_lm),
        sd   = sd(assump_df$residuals_lm))

set.seed(1)
shapiro.test(sample(assump_df$residuals_lm,
                    size = min(5000, length(assump_df$residuals_lm))))

# Multicollinearity
vif(model)
