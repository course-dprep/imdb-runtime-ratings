# How does runtime influence IMDb ratings, and how is this relationship moderated by genre (Adventure, Action and Comedy) when comparing films released before 2015 to those released after 2015?


## Motivation

In today’s world, movie ratings play an integral part when viewers decide which movie to watch. Among the many factors that influence the rating of a movie, runtime stands out as a relevant one when it comes to audience evaluation. Previously, a study by Choudhary et al. (2024) found runtime to be a statistically significant variable, influencing the rating of a movie across different genres, though the magnitude of this effect varied between genres. This raises the question about exploring not only the magnitude, but also the direction of the runtime effect. On the one hand, longer movies allow for more complex storytelling and character development, but on the other hand, decreasing attention spans (Hayes, 2024) among people may actually drive longer movie ratings down.

Previous research suggests a significant relationship between movie genres and their ratings, however often note that isolation of the genre variable is not clearly attainable (Choudhary et al., 2024). While there is no clear consensus in the literature on which genres consistently receive the highest ratings, Matthews (2021) argues that audience expectations are more structured for mainstream genres such as drama, action, and comedy than for niche categories. In these popular genres, ratings often reflect not only film quality but also how well a movie aligns with established genre conventions. Building on this, the present research focuses specifically on adventure, action, and comedy, as these genres have consistently generated the highest box office revenues in North America over the past decades (Statista, 2025). Adventure and action dominate due to their large-scale productions, international appeal, and substantial commercial success, while comedy plays a complementary role by reflecting cultural preferences and offering insights into audience diversity. Together, these genres allow for a balanced analysis that captures both the financial strength of blockbuster categories and the cultural relevance of humor-driven films.

In addition to examining the relationship between runtime, genre, and IMDb ratings, it is also important to define a clear time interval for the research. The global Netflix subscriber data provides a useful benchmark: in early 2013, Netflix had around 30 million paid subscribers, but by 2015 that number had more than doubled to over 70 million. (Netflix, 2025) This rapid acceleration reflects the point at which streaming shifted from an emerging model to a mainstream mode of media consumption, making 2015 a suitable cutoff year. Streaming services mark a natural cutoff point because they changed how runtimes are perceived: before streaming, films were optimized for theatrical showings and ticket sales, while streaming enabled more flexibility in length. As audiences gained on-demand access, tolerance for both shorter and longer runtimes shifted, making streaming adoption a key turning point for analyzing runtime effects on IMDb ratings. Accordingly, the research will compare films released before 2015 with those released from 2015 onward.

Thus, the research question for this project is defined as “How does runtime influence IMDb ratings, and how is this relationship moderated by genre (Adventure, Action and Comedy) when comparing films released before 2015 to those released after 2015?” This research addresses a gap in the currently existing literature of factors that influence audience reception of movies such as IMDb ratings by investigating how the release year (before 2015 versus post 2015) and genre (Adventure, Action and Comedy) have a moderating effect on the relationship between runtime and IMDb ratings of movies. Previous research looked at the individual effects of runtime, release year and genre (Horror, Comedy and Action) on IMDb ratings while this research also looks at the relative effects of these variables and how they interact with each other.

Further, this research is relevant to different marketing stakeholders in the movie industry such as marketing managers of movie studios, streaming platforms and cinemas. By providing valuable insights on the runtime preferences of audiences these can be used for example by movie studios to create movies across different genres with an optimal runtime and by streaming platforms and cinemas to find the optimal marketing strategy to movies of different runtimes and genres.

## Data

- What dataset(s) did you use? How was it obtained?
  We are using two files from the IMDB database:
  1) title.basics.tsv.gz (contains unique identifier of the title, the type/format of the title, original title, the release year of a title, TV Series end year, primary runtime of the title, genres)
  2) title.ratings.tsv.gz (contains unique identifier of the title, averageRating and number of votes the title has received)
     
- The final dataset includes 20144 observations. 
A variable description / operationalisation table is below.

## Variable Description and Operationalisation

| Variable        | Description                                           | Operationalisation (How it is measured/defined)                   |
|-----------------|-------------------------------------------------------|-------------------------------------------------------------------|
| `titleType. `   | Type of the production (eg.movie, tv series)         | Taken directly from dataset (string)                              |
| `primaryTitle`  | Movie title                                           | Taken directly from dataset (string)                              |
| `startYear`     | Year of release                                       | Taken directly from dataset (string)                              |
| `runtimeMinutes`| Duration of the movie                                 | Taken directly from dataset, minutes (numeric)                    |  
| `genres`        | Movie genres (e.g. "Comedy, Action")                  | Taken directly from dataset (string), may include multiple genres |
| `averageRating` | Average rating                                        | Mean user score (scale 1–10) taken directly from dataset          |
| `numVotes`      | Number of votes                                       | Count of user ratings submitted taken directly from dataset |

| Variable        | Type              | Source              | Operationalisation (How it is measured/defined)                                 |
|-----------------|-------------------|---------------------|---------------------------------------------------------------------------------|
| `Rating`        | Dependent         | `title.ratings`     | `averageRating` (on a scale of 1-10, continuous)                                |
| `Runtime10`     | Independent       | `title.basics`      | (`runtimeMinutes` - mean(`runtimeMinutes`))/10                                  |
| `Genre`         | Moderator         | `title.basics`      | Comedy (reference), Adventure (dummy), Action (dummy)                           |
| `YearGroup`     | Moderator         | `title.basics`      | 2011-2015 (reference), 2016-2020 (dummy)                                        |  
| `numVotes`      | Control           | `title.rating`      | Total IMDb votes                                                                |
| `logVotes`      | Control           |  Derived            | log10(`numVotes`). Interpreted as +1 = 10x more votes                           |
| `Intercept`     | Derived           |  Model              | Comedy movie, 2011-2015, mean `runtimeMinutes`, mean `logVotes`                 |

To ensure data quality and meaningful analysis, we applied the following filters to the dataset:

1) Runtime filter: We excluded movies with a runtime below 30 minutes.

Rationale: Very short films (e.g., shorts, experimental pieces) are structurally different from feature-length movies, and including them would bias our analysis of how runtime affects ratings.

2) Vote count filter: We excluded movies with fewer than 50 votes.

Rationale: IMDb ratings for movies with very few votes are often unstable and unreliable. Setting a threshold of 50 votes ensures that our dataset contains movies with sufficient audience engagement to provide a more representative measure of audience opinion.

### Handling Missing Values (Runtime)

During the data preparation phase, we observed that some movies in the IMDb dataset had missing values for runtimeMinutes. Further exploration revealed that these missing values were not randomly distributed: they tended to occur more frequently in certain genres and time periods. Because runtime is our main independent variable, we could not simply drop these movies, as that might bias our analysis.

To address this, we applied a median imputation strategy grouped by genre and release period. Specifically:
Movies were grouped by genre (Comedy, Action, Adventure) and release year group (2011–2015 vs. 2016–2020).
Within each group, missing runtimes were replaced with the median runtime of that group. (Median was chosen instead of the mean because it is more robust to outliers.)
This approach ensures that our dataset remains complete without artificially inflating runtimes or discarding a large number of observations. 

## Method

- What methods do you use to answer your research question?
- Provide justification for why it is the most suitable.

- For this research we will perform a multiple linear regression with interaction terms to find ou  t whether the runtime of a movie (continuous) influences its IMDb rating (continuous) and whether a film’s genre (Comedy, Adventure or Action) (categorical) and the release period (2011-2015 vs. 2016-2020) (categorical) influence this relationship. The runtime is the independent variable, the IMDb rating is the dependent variable and the two moderators are Genre (Comedy vs. Adventure vs. Action) and Release Period (2011-2015 vs. 2016-2020). Further, we will include the number of IMDb votes (expressed as a log-scaled variable) as a control variable since ratings based on more votes are usually more stable and reliable (Xie & Lui, 2013). We have chosen for a multiple linear regression with interaction terms as this is the most suitable way to combine these variable types, a continuous independent and dependent variable and two categorical moderators, into one model.
This will lead to the following model:
Rating = X₀ + β₁·Runtime10 + β₂·Adventure + β₃·Action + β₄·Yeargroup<sub>2016–2020</sub> + β₅·(Runtime10 × Adventure) + β₆·(Runtime10 × Action) + β₇·(Runtime10 × Yeargroup<sub>2016–2020</sub>) + β₈·log₁₀(Votes) + ϵ  

where:  
- β₁ = How the effect of +10 minutes runtime on IMDb ratings changes for Comedy movies released in 2011–2015  
- β₂, β₃ = How the effect of +10 minutes runtime on IMDb ratings changes for Adventure and Action movies compared to Comedy movies  
- β₄ = How the IMDb ratings change between movies released in <sub>2016–2020</sub> compared to movies released in 2011–2015  
- β₅, β₆ = How the effect of +10 minutes runtime on IMDb ratings changes for Adventure and Action movies compared to Comedy movies  
- β₇ = How the effect of +10 minutes runtime on IMDb ratings changes for movies released in 2016–2020 compared to 2011–2015  
- β₈ = How the IMDb ratings change between movies when the number of votes increases by a factor of 10  


## Preview of Findings 
- Describe the gist of your findings (save the details for the final paper!)
- How are the findings/end product of the project deployed?
- Explain the relevance of these findings/product. 

## Repository Overview 

**Include a tree diagram that illustrates the repository structure*

## Dependencies 
The following packages are necessary: 

install.packages(c("dplyr","readr","stringr","tidyr","data.table","fs","ggplot2","rmarkdown","knitr"))

## Running Instructions 

*Provide step-by-step instructions that have to be followed to run this workflow.*

## About 

This project is set up as part of the Master's course [Data Preparation & Workflow Management](https://dprep.hannesdatta.com/) at the [Department of Marketing](https://www.tilburguniversity.edu/about/schools/economics-and-management/organization/departments/marketing), [Tilburg University](https://www.tilburguniversity.edu/), the Netherlands.

The project is implemented by team 7 
members: 
- Berkay Ustundag - 2044582
- Eva Kortezova - 2163260
- Berk Yilmaz - 2164297
- Yaz Ucar - 2153214
- Victor van Rossum - 2042008


