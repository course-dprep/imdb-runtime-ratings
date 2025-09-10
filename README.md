> **Important:** This is a template repository to help you set up your team project.  
>  
> You are free to modify it based on your needs. For example, if your data is downloaded using *multiple* scripts instead of a single one (as shown in `\data\`), structure the code accordingly. The same applies to all other starter files—adapt or remove them as needed.  
>  



# How does runtime influence IMDb ratings, and how is this relationship moderated by genre (Adventure, Action and Comedy) when comparing films released before 2015 to those released after 2015?


## Motivation

In today’s world, movie ratings play an integral part when viewers decide which movie to watch. Among the many factors that influence the rating of a movie, runtime stands out as a relevant one when it comes to audience evaluation. Previously, a study by Choudhary et al. (2024) found runtime to be a statistically significant variable, influencing the rating of a movie across different genres, though the magnitude of this effect varied between genres. This raises the question about exploring not only the magnitude, but also the direction of the runtime effect. On the one hand, longer movies allow for more complex storytelling and character development, but on the other hand, decreasing attention spans (Hayes, 2024) among people may actually drive longer movie ratings down. 

Previous research suggests a significant relationship between movie genres and their ratings, however often note that isolation of the genre variable is not clearly attainable (Choudhary et al., 2024). While there is no clear consensus in the literature on which genres consistently receive the highest ratings, Matthews (2021) argues that audience expectations are more structured for mainstream genres such as adventure, action, and comedy than for niche categories. In these popular genres, ratings often reflect not only film quality but also how well a movie aligns with established genre conventions. This implies that popular genres bring a variety of expectations in consumers’ perceptions of the movie, which in turn reflects in the ratings. 

In addition to examining the relationship between runtime, genre, and IMDb ratings, it is also important to define a clear time interval for the research. The global Netflix subscriber data provides a useful benchmark: in early 2013, Netflix had around 30 million paid subscribers, but by 2015 that number had more than doubled to over 70 million. (Netflix, 2025) This rapid acceleration reflects the point at which streaming shifted from an emerging model to a mainstream mode of media consumption, making 2015 a suitable cutoff year. Streaming services mark a natural cutoff point because they changed how runtimes are perceived: before streaming, films were optimized for theatrical showings and ticket sales, while streaming enabled more flexibility in length. As audiences gained on-demand access, tolerance for both shorter and longer runtimes shifted, making streaming adoption a key turning point for analyzing runtime effects on IMDb ratings. Accordingly, the research will compare films released before 2015 with those released from 2015 onward.

Thus, the research question for this project is defined as “How does runtime influence IMDb ratings, and how is this relationship moderated by genre (Adventure, Action and Comedy) when comparing films released before 2015 to those released after 2015?”
This research addresses a gap in the currently existing literature of factors that influence audience reception of movies such as IMDb ratings by investigating how the release year (before 2015 versus post 2015) and genre (Adventure, Action and Comedy) have a moderating effect on the relationship between runtime and IMDb ratings of movies. Previous research looked at the individual effects of runtime, release year and genre (Horror, Comedy and Action) on IMDb ratings while this research also looks at the relative effects of these variables and how they interact with each other. 

Further, this research is relevant to different marketing stakeholders in the movie industry such as marketing managers of movie studios, streaming platforms and cinemas. By providing valuable insights on the runtime preferences of audiences these can be used for example by movie studios to create movies across different genres with an optimal runtime and by streaming platforms and cinemas to find the optimal marketing strategy to movies of different runtimes and genres. 

## Data

- What dataset(s) did you use? How was it obtained?
  We are using two files from the IMDB database:
  1) title.basics.tsv.gz (contains unique identifier of the title, the type/format of the title, original title, the release year of a title, TV Series end year, primary runtime of the title, genres)
  2) title.ratings.tsv.gz (contains unique identifier of the title, averageRating and number of votes the title has received)
     
- The final dataset includes 20144 observations. 
- Include a table of variable description/operstionalisation. 

## Method

- What methods do you use to answer your research question?
- Provide justification for why it is the most suitable.

- For this research we will perform a multiple linear regression with interaction terms to find ou  t whether the runtime of a movie (continuous) influences its IMDb rating (continuous) and whether a film’s genre (Comedy, Adventure or Action) (categorical) and the release period (2011-2015 vs. 2016-2020) (categorical) influence this relationship. The runtime is the independent variable, the IMDb rating is the dependent variable and the two moderators are Genre (Comedy vs. Adventure vs. Action) and Release Period (2011-2015 vs. 2016-2020). Further, we will include the number of IMDb votes (expressed as a log-scaled variable) as a control variable since ratings based on more votes are usually more stable and reliable (Xie & Lui, 2013). We have chosen for a multiple linear regression with interaction terms as this is the most suitable way to combine these variable types, a continuous independent and dependent variable and two categorical moderators, into one model.
This will lead to the following model:
Rating = X_0 + $\beta$1*Runtime10 + $\beta$2*Adventure + $\beta$3*Action + $\beta$4Yeargroup2016-2020 + $\beta$5*(Runtime x Adventure) + $\beta$6*(Runtime10 x Action) + $\beta$7*(Runtime x Yeargroup2016-2020) + $\beta$8*log10(Votes) + $\epsilon$, where

$\beta$1 = How he effect of +10 minutes runtime on IMDb ratings changes for Comedy movies released in 2011-2015
$\beta$4 = How the IMDb ratings change between movies released in 2016-2020 compared to movies released in 2011-2015
$\beta$5, $\beta$6 = How the effect of +10 minutes runtime on IMDb ratings changes for Adventure and Action movies compared to Comedy movies
$\beta$7 = How the effect of +10 minutes runtime on IMDb ratings changes for movies released in 2016-2020 compared to 2011-2015
$\beta$8 = How the IMDb ratings change between movies when the number of votes increases by a factor of 10 


## Preview of Findings 
- Describe the gist of your findings (save the details for the final paper!)
- How are the findings/end product of the project deployed?
- Explain the relevance of these findings/product. 

## Repository Overview 

**Include a tree diagram that illustrates the repository structure*

## Dependencies 

*Explain any tools or packages that need to be installed to run this workflow.*

## Running Instructions 

*Provide step-by-step instructions that have to be followed to run this workflow.*

## About 

This project is set up as part of the Master's course [Data Preparation & Workflow Management](https://dprep.hannesdatta.com/) at the [Department of Marketing](https://www.tilburguniversity.edu/about/schools/economics-and-management/organization/departments/marketing), [Tilburg University](https://www.tilburguniversity.edu/), the Netherlands.

The project is implemented by team 7 
members: 
- Berkay Ustundag - 2044582

d 

