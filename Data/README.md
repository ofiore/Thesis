# GLMM
## Relevant Files
+ GLMMData.csv: contains the updated data to include 2023

## About the data
The data from the spreadsheet was taken from results found on the World Athletics
website: https://www.worldathletics.org/results/world-athletics-championships. 
Data was copied and pasted into the spreadsheet and was given a label of either 
H, S, or F which stand for "Heats", "Semifinals", and "Finals", which are the 
three stages of competition for every World Championship from 2001-2022.  In 
1999 there were four stages with a quarterfinal round taking place in between 
Heats and the Semifinals.  The data was cleaned to remove any instances of DNS 
(Did not start).  Following the completion of the 2023 World Championships, data
was added to the end of the spreadsheet.  As we had already determined that we
were going to focus on the men's results, we only added the men's data.  When
adding the "Batch column" we coded each heat as a number from 1 to 111 before
eventually adding the 2023 data to get to 120 batches.  There is no significance
to the coding and is not important to the analysis.

# Rank Comparison
## Relevant Files
+ Each athlete was given a number 1-15 (numbers are not significant) and the
column 'Year' was coded as 1 if the observation took place in 2019 and 2 if in
2022.

+ Clusrank2019vs2022NoPrelims.csv: removed any data from the heats and thus
significantly reduced sample size.  The results from this analysis can be found
at the bottom of the RankComparison.Rmd file.

+ Each athlete was given a number 1-11 (numbers are not significant) and the
column 'Year' was coded as 1 if the observation took place at a national
championships and 2 if at the World Championships. This data was difficult to
find as it is not centrally located; each country records their data differently
and often times in their native language and we could not find data for many
countries.  Here are the links to the data as of September 2023:

+ [France](https://bases.athle.fr/asp.net/liste.aspx?frmbase=lives&frmmode=1&frmespace=0&frmcompetition=264985&frmepreuvem=110m+Haies+(106)+%2f+TCM&frmtour=7&frmserie=)
+ [Britain](https://www.watchathletics.com/page/3278/results-british-athletics-championships-2022)
+ [USA](https://www.flashresults.com/2022_Meets/Outdoor/06-23_USATF/116-1_compiled.htm)
+ [Brazil](https://cbat.org.br/novo/competicoes/trofeu_brasil/2022/resultados.php)
+ [Poland](https://mps.domtel-sport.pl/pdf/M110_3_r.pdf)

It is worth noting that many countries do not have 3 rounds of hurdles, typically
they usually have a preliminary and finals.  In that case, the first round was
entered as semifinals and the second round was entered as finals.

+ Each athlete was given a number 1-22 (numbers are not significant)
and the column 'Year' was coded as 2 if the observation took place in 2022 and 
3 if in 2023.

