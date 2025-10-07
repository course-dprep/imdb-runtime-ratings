
###REQUIRED PACKAGES
library(dplyr)
library(tidyr)
library(forcats)
library(ggplot2)
library(here)

fs::dir_create(here::here("gen", "output", "data-exploration-figures"))

merged_df <- readr::read_csv(here("gen", "output", "final_dataset.csv"), show_col_types = FALSE)
basics  <- readr::read_csv(here("gen", "temp", "basics.csv"),  show_col_types = FALSE)
ratings <- readr::read_csv(here("gen", "temp", "ratings.csv"), show_col_types = FALSE)

###SUMMARY STATISTICS

summary(ratings)
summary(basics)
str(ratings)
str(basics)

###NOT AVAILABLE VALUES and THEIR RANDOMNESS

sum(is.na(basics$runtimeMinutes))                                #Count how many NAs there are
mean(is.na(basics$runtimeMinutes))                               # proportion of missing values

# Compare distributions (movies with vs. without runtimeMinutes)
basics$runtime_missing <- is.na(basics$runtimeMinutes)
table(basics$runtime_missing)

# Check if NAs are related to popularity (ratings dataset)

# Step 1: Split multi-genre strings into separate rows
basics_long <- basics %>% 
  separate_rows(genres, sep = ",") %>%
  mutate(runtime_missing = is.na(runtimeMinutes))

# Step 1b: Add runtime_missing to basics (needed for runtime_by_year plot)
basics <- basics %>%
  mutate(runtime_missing = is.na(runtimeMinutes))

# Step 2: Collapse to top 10 genres (rest -> "Other")
basics_long <- basics_long %>%
  mutate(genres = fct_lump(genres, n = 10))

# Run all of the plots at once to view them side by side

runtime_by_year <- ggplot(basics, aes(x = startYear, fill = runtime_missing)) +
  geom_bar(position = "fill") +
  labs(title = "Proportion of Missing Runtimes by Release Year",
       y = "Proportion")

runtime_by_genre <- ggplot(basics_long, aes(x = genres, fill = runtime_missing)) +
  geom_bar(position = "fill") +
  labs(title = "Proportion of Missing Runtimes by Top 10 Genres",
       x = "Genre",
       y = "Proportion") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

runtime_by_vote <- merged_df %>%
  mutate(vote_bin = cut(numVotes,
                        breaks = c(0, 100, 1000, 10000, 100000, Inf),
                        labels = c("0–100", "101–1k", "1k–10k", "10k–100k", "100k+"))) %>%
  ggplot(aes(x = vote_bin, fill = is.na(runtimeMinutes))) +
  geom_bar(position = "fill") +
  labs(title = "Proportion of Missing Runtimes by Vote Category",
       x = "Vote Category",
       y = "Proportion")

runtime_by_rating <- ggplot(merged_df, aes(x = averageRating, fill = is.na(runtimeMinutes))) +
  geom_bar(position = "fill") +
  labs(title = "Proportion of missing runtimes by Average Rating",
       y = "Proportion")

# save plots to ROOT/gen/output/folder
ggsave(here::here("gen", "output", "data-exploration-figures", "runtime_by_year.png"),
       plot = runtime_by_year, width = 6, height = 4)

ggsave(here::here("gen", "output", "data-exploration-figures", "runtime_by_genre.png"),
       plot = runtime_by_genre, width = 6, height = 4)

ggsave(here::here("gen", "output", "data-exploration-figures", "runtime_by_vote.png"),
       plot = runtime_by_vote, width = 6, height = 4)

ggsave(here::here("gen", "output", "data-exploration-figures", "runtime_by_rating.png"),
       plot = runtime_by_rating, width = 6, height = 4)

# STATISTICAL TEST ON MISSING PATTERNS
chisq.test(table(basics$startYear, basics$runtime_missing))
chisq.test(table(basics_long$genres, basics_long$runtime_missing))

