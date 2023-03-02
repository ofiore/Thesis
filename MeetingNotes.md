Meeting Notes 3/2
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