# Meeting Notes 6/13
+ Add 200 meter data
+ Want probability not curve
+ venue effect figure is still useful, just need to explain it more and include talk about probabilities
+ in terms of devon allen, just use what I can find about Devon Allen. Explain data collection is difficult. There is need for centralized data
+ add womens dash
+ add 2022 vs 2023 womens data
+ continue with replies










# Meeting Notes 6/6
+ Include all comments including positive ones at the start
+ Include 100 meter dash results. If on different days than we can't say for sure.
Maybe include 200 meter
+ Need to respond and say that we improved structure of paper. Introduction is problem and move background/lit review into the background. Puts goals in beginning. Or move goals to start of introduction
+ Repeat analysis on 100 meter hurdle data and look at boxplot. Figure 2
+ Use 0.1 as truncation, fit legit qualification times and say there can be nothing below 0.1
+ Get pdf of Brosnan Hayes Harrison article. May need to admit this is a limitation but that this is a upper bound, bound may be even lower if we don't cut off at 0.1
+ See how they did theirs and compare
+ add some discussion about Allen's exceptionalism and admit limitations of discussions. BUt it is not reasonable to compare Allen's times to others. There are not that many races. People improve over time on their reaction times (unless they get old). Do some descriptive/informal analysis and talk about it in discussion section.
+ Allen had fastest reaction times in 2022 semifinals and finals, see if he is always the fastest or faster than the mean in every race.
+ Statistician may want to see table 2. Argue that this is fine.  Say that variables in the table are defined in the methods section and add reference.
+ Important for readers to know data difficult to collect. Indicating need for standardization of data
+ Venue effects are mean 0 with variance sigma squared. Plot a normal distribution and then show where 2022 is. Probability of observing as extreme as the venue effect. More meaningful of 2022 curve on the curve that did not use 2022. Use sigma squared v that did not include 2022.




# Meetings Notes 9/6
+ Do I need to change the Rmd file variable names: Yes
+ Should I still include the code that has the finals functions/results: no
+ Make the triple plot smaller, move title to inside the graph, and also need
to explain the differences in the 3 2022 graphs as they are not the same
+ Reference the table with the summary stats,
+ not summary stats, estimated parameters of the model
+ Change the parameter table to include the 3 models and then show the different
estimates of the parameters for each model
+ Can remove the stuff about the anova/likelihood ratio test as we talk about AIC
+ Fix latex symbols in table 3, and rephrase the old/all pooled
+ Change to "National versus International"
+ Change batch effect to heat effect
+ In concluding remarks talk about 0.1 is not that extreme, even if 2022 data is
different.
+ Remove the appendix
+ Protect IAAF in curly brackets
+ remove month from world athletics 2022 July
+ Put urls for the LetsRun article in "note", capitalize Devon Allen








# Meeting Notes 8/30
+ GLMM results just change the numbers
+ Rank Comparison: add 2023 comparison
+ update the language
+ Time between getting on block and when gun goes off can effect time so heat effect is valid
+ Put source for National competition in the Data README
+ "Our data consists of semfinals and finals" but call it "our data"
+ Analysis with and without 2022 doesnt change results much but 0.1 is not that rare
+ Change old data (pre 2022) to include 2023
+ With and without analysis we see 0.1 is not that extreme
+ 0.1 is unfair if people get there too early
+ Change all/old pooled to 2022 and excluding 2022
+ Device problem comes up in rank approach not GLMM






# Meeeting Notes 8/3
+ Give descriptive statistics for each dataset
+ Delete blue graph
+ Make one plot for natVSint and 2019vs2022
+ Remove usa table
+ Need to tell readers the cluster sizes (At least 2), in text the number of
each size cluster there are 3 2s, 4 4s, etc
+ By design treatment is within cluster, treatment is assigned individually
within the cluster, and this is why we use ds
+ Rank based stuff has same structure
+ subunit level grouping
+ exact = TRUE means permutations, but B = 1000 in methods
+ Change language of pooled vs finals
+ Add 0.09 to table 3
+ Convert 0.0001 to 10^-4
+ Remove table 5
+ Show AIC to compare two effect model
+ Talk about the table in terms of alpha, 2 standard deviations
+ Negative signs in latex
+ Called venue and heat
+ Change residual to phi
+ In results talk about why two effect model is better
+ 1 talk about why its better, parameters of better model, and then the result
of the better model
+ Remove 65/49 sample size column, talk about stuff in text in data
+ Call table permutation, asymptotic not exact = True, exact != Trie
+ Change discussion to "Concluding remarks"
+ Email Prof Schifano after and send the pdf,








# Meeting Notes 7/26
+ Use relevel in R to fix the order of heats, semifinals, finals
+ Group A and Group B and then clusters, which can be A or B, if there is no difference
between A and B then A/B label does not matter, so you can randomly assign A/B to
members of cluster. For each permutation can calulcate the statistic. Do 1000,
these form a distribution and then observe test stat relative to this dist and
see how extreme it is. Suppose cluster sizes are equal, randomly take group labels
from one cluster and randomly assing to group members of another clusters, under
null hypothesis this should be true. Can also shuffle within clusters, then this
gives lots of possibility and for every possibility can calculate a stat and how
extreme it is.
+ Put more text in RankComparison.Rmd
+ Go through and make sure 2 effect model text is correct
+ Discuss results in results, acknowledge limitations in Discussion
+ Discussion should be 2 paragraphs
+ Dont cite zhang2021 paper if its not helpful
+ Put more about permutation approach at the end of section 3. We report both
because of limited sample size (exact = True).
+ Clean up GLMM results








# Meeting Notes 7/19
+ As there are warnings for finals dataset, report pooled results: 4.15 and 5.15
+ Change the range of the blue curve from 0.8 to 0.22 to something more wide
+ Condense paragraph on Seiko timing device
+ Put tables in results, talk about them in discussion
+ As sample size is small, and ds approach is for large samples, put exact = True
+ Hurley reference is wrong and needs to have a title
+ Add note field to misc
+ Protect appropriate fields in bib file






# Meeting Notes 7/12
+ we have 3 mixed effects models: year, batch, and both
+ for each dataset compare the probabilities associated with all 3
+ select the best model and dataset to report
+ Put this in a table but first need to do analysis in Rmd file
+ show with and without 2022 what 0.1 means how extreme it is
+ Justify 0.08 by talking about other papers, and how under 0.08 Allen would not
be DQd
+ 0.1 second does not make sense for both genders, cite papers








# Meeting Notes 7/5
+ Can put equations and explanations in the text block of Rmd files (not in the R blocks).
+ Fix the Rmd files
+ ReadMe in code folder to explain what each Rmd file does.
+ Come up with alternative to "race effect": how about heat, round, flight
+ What is probability reperesented by threshold, what is threshold for probability
+ Dont need sub sub sections for methods but can for data and results



# Meeting Notes 5/31
Things I want to talk about:
Athlete effect, various language stuff, inclusion of prelims in rank based comparisons,
Moving paragraphs

To do:
Update the simulation code to include second random effect and do the time analysis
2022 batch effects are all negative
- will not include athlete effect for now
Justify the inclusion of the heats in the rank analysis
Change orange/tan bar graph to dots to show spread
Keep the sprinters/hurdles








# Meeting Notes 4/25
Maybe paper less conversational, more scholarly
Just say that there are gender differences so not going to pool
Break paragraph into 2022 vs 2019 and 2022 vs national
Discuss results in table, and show that the standard error increases.  This is
sigma-hat, -1.901 is alpha, sigma is standard deviation of random effect
Report alpha first. 2nd col is alpha hat, 3rd is sigma hat
Keep the intercept standard error col but need to keep resid var, remove int var
Need to include shape parameter: phi
Alpha is mean
can also report dispersion parameter
Call the columns by their greek letters
Log = link so everything is positive
alpha means that if you exponentiate alpha+z that gives you mean of the gamma dist
can also parameterize gamma dist by mean and variance
Look at varcorr or phi is 0.02345

Get rid of 0.09, look at for probability level what time: 2 columns. 1/1000 and
maybe something else (5/1000, 1/10000, etc)
Need to be more descriptive and introduce the datasets in section 4.2.  Need to
have 1 paragraph for each data type.  There is strong evidence that 2022 is diff

For this data there is signficant difference, easier to remove, but still need
a conclusion.  Same athletes shouldnt get better, then its weird that they do
what we observe is unlikely to happen, this is evidence against timing device is
the same
Document data in data folder, can document in paper where you got data.  Mention
in introduction where we got the data

every citations needs year,

For Ken, remove comments and clean everything up







# Meetings Notes 4/18
Double subscript for group and cluster?
Define what S, W, other variables are
Why is DS better: cluster size refers to how many data points for each athlete
As data is national and world championship, if someone appeared in both that
means that the athlete is very good, that is why ds is better.  Cluster size
is informative.  Need to explain why this is preferable.  Larger cluster size
indicates that they reached finals more and may be faster/better

dont Combine tables for the probability section
Negative sign put in math mode
Put year as 2023 and the author as, need to give last accessed date, put author as Seiko
Choose a p, and then calculate reaction time barrier in 2 other columns



# Meeting Notes 4/11
Include pdf reference with link, include last referrenced date
Change the language regarding the references
We want to say that times don't change between heats and finals
Add references folder to make it easy to find stuff
Update the keywords from writing repo
Change bibtex keywords for non journals
Every reference needs author, title, year, etc.
Journal should be in journal style: Sports Sciences need to be capitalized.
Use curly braces to protect names, titles, etc.
Break up literature review into smaller paragraphs
Fix the ?? marks on page 6
In the data section, show there is 2 types of data: semifinals and finals
Since 2011, there is a ? mark
To cite 3 papers in one sentence: put all 3 in the same citep
Break up all long paragraphs: in data section
Say exlicityly two types of data: 2 subsections, the GLMM and the ranked comparison
Can include all 15 nationals vs international competition
Fix the lines on the table
Do subsections for data, methods, results
Cite the correct package
Move the clusrank p values to the results sectoin 
Change n = 10mil to math latex
If we wanted to have a mis disqualfication once every 100
Find lower quantiles of the distribution









# Meeting Notes 4/4
Find more papers (10+)
Review scholarly literature and include in paragraph 3 of intro
Look at related works and include references
Fix question marks
2 blank lines to seperate paragraphs
Fix section references
Fix the glmm model latex and explain what everything means
Remove X
Data should be where got data and should
Remove the title in R
Specify the size in R not latex
1 figure 2 panels for boxplot in R
Put the formula in the Methods section
Move the simulation data table to results
In methods section talk about how the distribution has mixed form and that
the best way to get percentile is to generate a large sample and then use this
to estimate the probability
Change 12 million to 10 million
Seperate method and application of method for ex: method is generate large sample
application of method: we use 10 mil
Present results in subsections: including and not including the last year.
Methods are same regardless how you pick data, this motivates next section
Any conclusions from tests go in results
Discussion is about any limitations, future work, etc
Put the results after the end-document so they arent compiled
Clean references
Discussion is where we talk about Allen's disqualification


# Meeting Notes 3/28
In line with the manuscript


# Meeting Notes 3/21

+ Introduction, Data: Talk about each dataset: world championships and the matched
pairs athletes for 2019vs2022 and National Vs world
+ Explain how data is useful
>Methods section for GLMM, clustered data comparison (2 subsections)
>One way anova with random effect don't need to include the linear algebra formulas
yij = mu + alpha*i + epsiloni is the linear mixed effects model
i is the year, j is player
yij follows gamma distribution
Show that the linear mixed effects model is not as good as gamma model. Talk about this
For gamma model: yij ~ gamma dist with mean(mu+alphai) and the variance is found
 in simulations code.  Gamma dist has shape and scale but can reparameterize
 to be in terms of mu and sd
 > For gamma distribution the variance is equal to mean squared and then there is
 a scale parameter (Prof Yan can edit this but still work on it)
 Results section:
 > Establish that normal model is inferior to gamma model
 > Then gamma with random effect is better than gamma without random effect
 > Gamma family has different links, link does not make much of difference but 
 we use link=log
 > Now focus on Gamma with random effect and estimate the probability of something 
 below 0.1
 > With and without 2022 data the results are different. p value for 0.1 and
 other thresholds.  For a given probabilty find the threshold
 > Change instances of "year effect" to "venue effect"
 Hyptothesis about whether 2022 makes a differrence, makes us wonder about device
 effect, and then lead this into the comparispon of atheltes who competed twice
 > Don't mention names of data file this is academic paper
 > Results has 3 analysis: gamma model, with and without 2022 data, clustered
 rank sum tests: same atheletes diff year and same atheletes same year
 >Discussion: discuss limitations of work
 >Include tables based on what I talk about and what makes sense, AIC cant be
 compared across data sets
 > Don't need table if there is not a lot of data.
 > Look at heats and include boxplots showing all data in the data section
 >Remove figures
 > Use width = textwidth, don't scale them
 > Soft references to other parts of the paper
 > Cite more references and update bib file, find google scholar papers that
 are cited by articles




# Meeting Notes 3/2
Ds Method is better
Use rank sum but remove "Pair = true"
Keep only gamma link=log
Only compare AIC for within datasets and make a table showing with and without random effect
Then forget about random effect and present results: models with random effect
Show addition of 2022 makes a difference
Talk about p values and what the chance of 1 of 1000 etc to be disqualified (this all goes in section 2)
Section 3 talks about clustered data tests to verify whether there is a difference
In discussion/conclusion talk about women's data (100 meters?)
Remove horizontal lines and use 3494W writing tips repo
Latex code can be generated using xtable to export data frame from R to latex
Call it venue effect, last years data is influential














Meeting Notes 2/21
Need to show that including year effect, model is better
Show this with AIC 
Show the standard deviation of random effect
Generalized linear model does not have linear effect, GLMM does
AIC, SE rand effect (only for mixed model)
The random effect measures how much variation

After working on conclusion, can repeat analysis for women's data to see if this supports our claim
Tab under simulations should be moved under results, simulation just used to approximate the distribution

Paper structure:
Introduction: This is an interesting question but nothing has been done (blogs but no scholarly works), outline what to do
> we did 2 types of analysis: fit GLMM model with and w/o last year, w and w/o year effect. These suggest that 0.1 is not that extreme compared to when you exclude last years data.  Suspect that last year's data is suspicious
> Same athletes over different years and same athletes in the same year but at National vs World competition (data is smaller but rank based suggests that the results are significantly different) (3rd paragraph in intro this is my introduction)
> Last paragraph of intro is road map of paper
Section 2: GLMM gamma model. Present models and results.  Summarize what you find and lead into section 3. Talk about model selection
Section 3: Reason to suspect that last year is bad (clustered data analysis) Find womens data for this
Section 4: Conclusion and talk about women's data (repeat what was done for the men's data) and we expect to see similar patterns for women










Meeting Notes 2/14
Put all the models in a table and include log-lik, AIC, summary
Include estimate of random effect (variance)
Use link=Log
Keep same number of decimal places the same
Change unit columns to be more readable
Probability is not as extreme as if you include semifinals
Pooled and not pooled gives different estimate
Uncertainity of model parameter increases for the finals compared to pooled
Generate parameters from normal approximation and then simulate and then pool

Rename excel spreadsheet variables
We show that including or not last years data makes a difference
The athletes should not be getting faster, the device must be responsible
Year effect and athlete improvement confound
Conclusion: last year's data is not reliable
Allen disqualified without good reason

Datafest at Wesleyan, UConn is organizing teams (3-5 people) for contest
1 day event












Meeting 2/7
Cant compare AIC with different data sets
For each block look only at one data set
Repeat simulation for different data sets
Present results of gamma model
4 analyses: gamma with and without 2022, finals, pooled data
Record these results in the paper
What does the 0.1 second mean? p value of 0.00658
Talk about what this means
If you want this to be 1 in 1000 or 10000, what threshold should be set
Put this in table for analysis
Want to show difference between data with and without 2022
group = year, cluster = athlete
Reformat 2019 vs 2022 to show group and cluster
Try both group and cluster with paired
We don't expect that reaction time increases significantly from 2019 to 2022 but this justifies year effect
List in Markdown
Repeat for Nationals vs Worlds


Draft rec letter paragraphs to help


Meeting 1/31
Table of all results to summarize everything
Rank test or permutation test see if everyone got faster
First part is 2019 vs 2022 world championships and see if venue effect is significant
Save graphs as pdf
Do lots of analysis and then select what to report
Fix github or start over

Want to see:
Final only and then pooled for each set: gamma, log normal, include w and w/o 2022 data. 2022 data may increase variance of random effect
Want to see diagnostics, AIC, etc.



Meeting 1/24
Remove Race effect, look only at year/venue effect X
Clean the GitHub X
Update the thesis repo to match with what is from 3494W X
Clean the R file X
Analysis of log scale and compare it to original scale and look at the p value of this
And Show diagnostics
Compare AIC of log and gamma, put other in appendix X
Find national competition data
Look at 2019 data
Matched pairs t test between 2019 and 2022 and common competitors
Matched pairs t test between 2019 usa championship and 2019 worlds
Instead of t test use a clustered rank test R package is clusrank
Make no assumptions about distribution



Meeting 12/8
Need to find the largest batch
In the writing need to explain the logistics of how many semifinals there are and how people move on
Can remove high outliers if there is sufficient evidence

By looking at Batch effect model, try to show that 0.1 is not that extreme
Look at hglm package
Compare results of lme4 to hglm, then can fit gamma model with gamma random effects
Fit all 4 models and select the best using diagnostics (from qqnorm, are assumptions valued, )
qqnorm shows random effect model isn't normal
Then explore if results chance by excluding 2022 and if you include Allen's data
Modify sim function to allow second random effect

Why isnt plot() not showing all batches
Explain what happened to batch 41
Paper will argue that Allen's Data is not that extreme from batch effect








Meeting 12/5
Need to look at men and women
Can include semifinals
Ned to get batch
Including and not including 2022
Just take log of reaction time and see if that corrects the linear model





Meeting Notes 12/1
Year effect or batch effect (Heat 1, heat 2, heat 3, etc), look at womens data and compare
Paired t test for men and women
Can pool men and women but then there may be batch effect
2 random effect model: year effect and batch effect, can check whether both effects are necessary or only one
Compare likelihood between model with 2 random effects and only one random effect in lmer4 package
Find google scholar paper on gender differnce in reaction time
Create new variable in excel for batch effect
Just compare men and women in finals with batch effect
From that model









Meeting Notes 11/17
What is correct interpretation of p value in linear mixed effects model and in pnorm()

Update R

First simulate from random effects, then simulate from gamma distribution
Look at a million observations, how many fail under 0.01
Fit model with and without Allen's data
Fit model with and without 2022
We argue that gamma mixed effects model is a good model, it passes all checks
Once we know this is a good model, check distribution of reaction times
Gamma mean is random
Try all 3 Gamma models, with u as random effect, pick highest likelihood
Batch effect not year effect
Include Heat and Semifinal in Data
Remove Anthony's code
Talk to Lets Run about their statistical analysis





Meeting Notes 11/10
Look mostly at finals data
Read up on generalized linear mixed effect model with gamma dist
We are assuming given year effect can still be normal, but RxnTime follows gamma dist with some mean and variance
Instead of assuming normal residuals, we are assuming reaction follows Gamma dist
Mixed effect gamma regression
Present linear mixed effect model for 3494W first draft, talk about p value and assuming normality
0.01 vs 0.1 vs 0.001 threshold
As limitation can plot qqplot and show that there is still work to do about the right tail
Use package and understand gamma mixed model to solve qq plot
Put random effect looking at run level looking at athletes in the semi vs final
May be different for heats than for finals
Every run will have a random effect and look at that plot

Read thesis data in as relative path so other users can read the data in
And fix negative






Meeting Notes 11/3
How to test if a random effect is significant?
Observed variance is sum of two variances
Do estimation based on previous years not including 2022
Then see if 2022 falls within acceptable range of variances
Mixed effects model
Run with and without 2022
Make an argument about prob of given random effect that someone has a rxn time below 0.1
Year effect should be important, quantify p value someone has a rxn time below 0.1










Meeting Notes 10/27
Include more scholarly works from Google Scholar
Change Notes.txt to Notes.Rmd
Copy Proposal Preamble from writing demo Git repo
Research Seiko Computer/timing device
How to Protect fields in bibtex
Want to investigate whether athletes got better, whether limit they set (0.01) is too slow or unreasonable
Can Pool men and women together
Heats vs Semis vs Finals, type I error (see if there is a pattern)
Plot total time vs reaction time and see if there is correlation (probably no relationship)
Some year effect on finals reaction time
Plot residuals of ANOVA data
Use lme() instead of ANOVA.  To estimate variance of year effect
Total variance = year effect variance + residuals
How to justify year effect: compare semifinals and finals to see if certain years are slower or faster
Prob that the disqualification was an error? - Type I error
Set up manuscript, slowing start writing
Set up webex meeting





Meeting Notes 10/15
Put ReadME for Data with link to world atheltics
Give source for where you copy paste, document how excel spreadsheet data was inputted
Can include finals and semifinals data from 1999, keep missing as missing
Include geomety package
Scatterplot data and model trend, after having distribution can ask questions
If there is a trend, model the trend starting with finals

Talk about after: UNIV 4697W (can register on Student Admin)
permission numer: 861168



Meeting notes 10/13:
Find citations and put it in 
Make Folder for Proposal
Terminal basics and how to make a folder
Make Interesting Title
Add more data
Data needs to be comparable, maybe only finals
Compare finals, semifinals, heats
Find USA Tf championships
Can also look at 100m and womens 110m hurdle
Look at Google Scholar info
