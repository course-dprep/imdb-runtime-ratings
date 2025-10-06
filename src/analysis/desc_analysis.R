
library(ggplot2)

# Number of films per year
p1 <- merged_df %>%
  count(startYear) %>%
  ggplot(aes(x = startYear, y = n)) +
  geom_col(fill = "steelblue") +
  scale_x_continuous(labels = number_format(accuracy = 1)) +
  labs(title = "Number of Films per Year (2011–2020)",
       x = "Year", y = "Number of Films")
ggsave("gen/output/films_per_year.png", plot = p1, width = 6, height = 4, dpi = 300)


# Average rating per year
p2 <- merged_df %>%
  group_by(startYear) %>%
  summarise(mean_rating = mean(averageRating, na.rm = TRUE)) %>%
  ggplot(aes(x = startYear, y = mean_rating)) +
  geom_line(color = "darkred", size = 1) +
  scale_x_continuous(labels = number_format(accuracy = 1)) +
  labs(title = "Average IMDb Rating per Year",
       x = "Year", y = "Average Rating")
ggsave("gen/output/avgrating_per_year.png", plot = p2, width = 6, height = 4, dpi = 300)



# Distribution of ratings
p3 <- merged_df %>%
  ggplot(aes(x = averageRating)) +
  geom_histogram(binwidth = 0.2, fill = "goldenrod", color = "white") +
  labs(title = "Distribution of IMDb Ratings",
       x = "Rating", y = "Number of Films")

ggsave("gen/output/dist_of_ratings.png", plot = p3, width = 6, height = 4, dpi = 300)


# Average rating per genre
p4 <- merged_df %>%
  separate_rows(genres, sep = ",") %>%
  filter(genres %in% c("Action","Comedy","Adventure")) %>%
  group_by(genres) %>%
  summarise(mean_rating = mean(averageRating, na.rm = TRUE)) %>%
  ggplot(aes(x = reorder(genres, -mean_rating), y = mean_rating, fill = genres)) +
  geom_col() +
  labs(title = "Average IMDb Rating by Genre",
       x = "Genre", y = "Average Rating")
ggsave("gen/output/avgrating_per_genre.png", plot = p4, width = 6, height = 4, dpi = 300)


# Distribution of votes (log scale)
p5 <- merged_df %>%
  ggplot(aes(x = numVotes)) +
  geom_histogram(bins = 50, fill = "steelblue", color = "white") +
  scale_x_log10() +
  labs(title = "Distribution of Number of Votes (log scale)",
       x = "Number of Votes (log10)", y = "Number of Films")
ggsave("gen/output/logdist_of_votes.png", plot = p5, width = 6, height = 4, dpi = 300)



# Average number of votes per genre
p6 <- merged_df %>%
  separate_rows(genres, sep = ",") %>%
  filter(genres %in% c("Action","Comedy","Adventure")) %>%
  group_by(genres) %>%
  summarise(mean_votes = mean(numVotes, na.rm = TRUE)) %>%
  ggplot(aes(x = reorder(genres, -mean_votes), y = mean_votes, fill = genres)) +
  geom_col() +
  labs(title = "Average Number of Votes by Genre",
       x = "Genre", y = "Average Votes")
ggsave("gen/output/avgvotes_per_genre.png", plot = p6, width = 6, height = 4, dpi = 300)



# Distribution of runtimes
p7 <- merged_df %>%
  ggplot(aes(x = runtimeMinutes)) +
  geom_histogram(binwidth = 10, fill = "darkgreen", color = "white") +
  labs(title = "Distribution of Runtimes",
       x = "Runtime (minutes)", y = "Number of Films")
ggsave("gen/output/dist_of_runtimes.png", plot = p7, width = 6, height = 4, dpi = 300)



# Average runtime per year
p8 <- merged_df %>%
  group_by(startYear) %>%
  summarise(mean_runtime = mean(runtimeMinutes, na.rm = TRUE)) %>%
  ggplot(aes(x = startYear, y = mean_runtime)) +
  geom_line(color = "darkblue", size = 1) +
  scale_x_continuous(labels = number_format(accuracy = 1)) +
  labs(title = "Average Runtime per Year",
       x = "Year", y = "Runtime (minutes)")
ggsave("gen/output/avgruntime_per_year.png", plot = p8, width = 6, height = 4, dpi = 300)


# Runtime distribution by genre
p9 <- merged_df %>%
  separate_rows(genres, sep = ",") %>%
  filter(genres %in% c("Action", "Comedy", "Adventure")) %>%
  ggplot(aes(x = genres, y = runtimeMinutes, fill = genres)) +
  geom_boxplot() +
  labs(title = "Runtime Distribution by Genre",
       x = "Genre", y = "Runtime (minutes)")
ggsave("gen/output/runtimedist_by_genre.png", plot = p9, width = 6, height = 4, dpi = 300)


# Heatmap: Average rating per genre per year
p10 <- merged_df %>%
  separate_rows(genres, sep = ",") %>%
  filter(genres %in% c("Action","Comedy","Adventure")) %>%
  group_by(startYear, genres) %>%
  summarise(mean_rating = mean(averageRating, na.rm = TRUE)) %>%
  ggplot(aes(x = startYear, y = genres, fill = mean_rating)) +
  geom_tile(color = "white") +
  scale_fill_gradient(low = "lightyellow", high = "red") +
  scale_x_continuous(labels = number_format(accuracy = 1)) +
  labs(title = "Average IMDb Rating per Genre per Year",
       x = "Year", y = "Genre", fill = "Average Rating")
ggsave("gen/output/heatmap_of_averagerating_per_year.png", plot = p10, width = 6, height = 4, dpi = 300)


# Summary by genre
merged_df %>%
  separate_rows(genres, sep = ",") %>%
  filter(genres %in% c("Action","Comedy","Adventure")) %>%
  group_by(genres) %>%
  summarise(
    n_films = n(),
    mean_rating = mean(averageRating, na.rm = TRUE),
    sd_rating = sd(averageRating, na.rm = TRUE),
    mean_votes = mean(numVotes, na.rm = TRUE),
    mean_runtime = mean(runtimeMinutes, na.rm = TRUE)
  )

# Summary by year
merged_df %>%
  group_by(startYear) %>%
  summarise(
    n_films = n(),
    mean_rating = mean(averageRating, na.rm = TRUE),
    mean_votes = mean(numVotes, na.rm = TRUE),
    mean_runtime = mean(runtimeMinutes, na.rm = TRUE)
  ) 