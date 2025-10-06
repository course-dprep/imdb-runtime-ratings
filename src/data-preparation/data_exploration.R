# Set CRAN mirror
options(repos = c(CRAN = "https://cloud.r-project.org"))

###REQUIRED PACKAGES

install.packages("dplyr")
install.packages("tidyr")
install.packages("forcats")
install.packages("ggplot2")

library(dplyr)
library(tidyr)
library(forcats)
library(ggplot2)
library(here)


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

# Step 2: Collapse to top 10 genres (rest -> "Other")
basics_long <- basics_long %>%
  mutate(genres = fct_lump(genres, n = 10))

#Run all of the plots at once to view them side by side

runtime_by_year <- ggplot(basics, aes(x = startYear, fill = runtime_missing)) +
  geom_bar(position = "fill") +
  labs(title = "Proportion of Missing Runtimes by Release Year",
       y = "Proportion")

ggsave("gen/output/runtime_by_year.png", plot = runtime_by_year, width = 6, height = 4)

runtime_by_genre <- ggplot(basics_long, aes(x = genres, fill = runtime_missing)) +
  geom_bar(position = "fill") +
  labs(title = "Proportion of Missing Runtimes by Top 10 Genres",
       x = "Genre",
       y = "Proportion") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave("gen/output/runtime_by_genre.png", plot = runtime_by_genre, width = 6, height = 4)


runtime_by_vote <- merged_df %>%
  mutate(vote_bin = cut(numVotes,
                        breaks = c(0, 100, 1000, 10000, 100000, Inf),
                        labels = c("0–100", "101–1k", "1k–10k", "10k–100k", "100k+"))) %>%
  ggplot(aes(x = vote_bin, fill = is.na(runtimeMinutes))) +
  geom_bar(position = "fill") +
  labs(title = "Proportion of Missing Runtimes by Vote Category",
       x = "Vote Category",
       y = "Proportion")

ggsave("gen/output/runtime_by_vote.png", plot = runtime_by_vote, width = 6, height = 4)


runtime_by_rating <- ggplot(merged_df, aes(x = averageRating, fill = runtime_missing)) +
  geom_bar(position = "fill") +
  labs(title = "Proportion of missing runtimes by Average Rating",
       y = "Proportion")

ggsave("gen/output/runtime_by_rating.png", plot = runtime_by_rating, width = 6, height = 4)


#STATISTICAL TEST ON MISSING PATTERNS

chisq.test(table(basics$startYear, basics$runtime_missing))
chisq.test(table(basics_long$genres, basics_long$runtime_missing))
