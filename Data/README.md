# GAMLSS
## Relevant Files
+ rxntime.csv: contains men's 110 meter hurdles data from 1999 to 2023, women's
100 meter hurdle data from 2001 to 2023, men's 100 meter dash data from 1999 to
2023, women's 100 meter dash data from 1999 to 2023, and men's 200 meter dash
data from 1999 to 2023 (not used in analysis).

## About the data
The data from the spreadsheet was taken from results found on the World Athletics
website: https://www.worldathletics.org/results/world-athletics-championships. 
Data was copied and pasted into the spreadsheet and was given a label of either 
H, S, or F which stand for "Heats", "Semifinals", and "Finals", which are the 
three stages of competition for every World Championship from 2001-2022.  In 
1999 there were four stages with a quarterfinal round taking place in between 
Heats and the Semifinals.  Following the completion of the 2023 World
Championships, data was added to the end of the spreadsheet.

## Data Dictionary
+ `Year` is the year the observation was recorded
+ `Stage` is the stage of competition the observation was recorded.  There are
3 levels: `H` denotes the time was recorded during the heats (preliminary
round), `S` denotes the time was recorded during the semifinals, `F` denotes the
time was recorded during the finals.
+ `TotalTime` is the athlete's time in seconds over the entire race. `DNF`
denotes an athlete that did not finish, `DQ` or `D`  denotes an athlete that was
disqualified.
+ `ReactionTime` is the athlete's reaction time in seconds.
+ `Gender` is coded as either `M` for male or `F` for female
+ `Batch` is an integer unique to each race.   The integer's value is not
meaningful.
+ `Event` is the type of track event the observation came from.  Men compete
in the 110 meter hurdles but women compete in the 100 meter hurdle.

# Rank Comparison
## Relevant Files
+ ClusrankNatvsWorld.csv: Contains data from male athletes that competed at the
2022 Track and Field Championship and their country's track and field
championships in the men's 100 meter dash or men's 110 meter hurdles.

+ ClusrankNatvsWorldWomens.csv: Contains data from female athletes that competed
at the 2022 Track and Field Championship and their country's track and field
championships in the women's 100 meter dash or men's 100 meter hurdles.

+ Clusrank2019vs2022.csv: Contains data from male athletes that competed at the
2019 and 2022 World Track and Field Championships in the men's 100 meter dash or
men's 110 meter hurdles.

+ Clusrank2019vs2022Womens.csv: Contains data from female athletes that competed
at the 2019 and 2022 World Track and Field Championships in the women's 100
meter dash or women's 110 meter hurdles.

+ Clusrank2022vs2023.csv: Contains data from male athletes that competed at the
2022 and 2023 World Track and Field Championships in the men's 100 meter dash or
men's 110 meter hurdles.

+ Clusrank2022vs2023Womens.csv: Contains data from female athletes that competed
at the 2022 and 2023 World Track and Field Championships in the women's 100
meter dash or women's 110 meter hurdles.

## About the Data

In both cases data was originally recorded in a more understandable form in
csv files located in the "Archive" folder before being transferred to the
Clusrank csv files located in the "Data" folder.

### National vs International Data
Data was taken from athletes who competed at their country's track and field
championship and was compared with their times at the 2022 World Track and Field
Championships.  Nearly every country that sends runners to the World
Championships host their own national championships typically in May, June, or
July, before the World Championships in August.  In contrast with the heats,
semifinals, and finals structure that is common at the World Championships, 
some countries do not have 3 rounds of competition, instead they usually have a
preliminary and finals.  In that case, the first round was entered as semifinals
and the second round was entered as finals.  This is not hugely impactful as we
look at data from all three levels in this analysis.

This data was difficult to find as it is not centrally located; each country records their 
data differently and often times in their native language and we could not find 
data for many countries.  Here are the links to the data as of November 2024:

+ [France](https://bases.athle.fr/asp.net/liste.aspx?frmbase=lives&frmmode=1&frmespace=0&frmcompetition=264985&frmepreuvem=110m+Haies+(106)+%2f+TCM&frmtour=7&frmserie=)
+ [Britain](https://www.watchathletics.com/page/3278/results-british-athletics-championships-2022)
+ [USA](https://www.flashresults.com/2022_Meets/Outdoor/06-23_USATF/116-1_compiled.htm)
+ [Netherlands](Netherlands: https://www.atletiek.nu/wedstrijd/chronoloog/37709/#day3)
+ [Poland](https://mps.domtel-sport.pl/pdf/M110_3_r.pdf)
+ [Germany](https://www.leichtathletik.de/wettkaempfe/ergebnisse/ergebnis-detail/detail/Deutsche-Meisterschaften-2022-22D03000000000001)


### 2019 and 2023
Data was taken from athletes who competed at either the 2019 or 2023 World
Championships.  There are more observations in 2023 likely because it is only
a year after the 2022 Championships.  The Covid-19 pandemic caused the 2020
Olympics to be pushed back to 2021 which then pushed the World Championship
scheduled for 2021 to be moved to 2022.

## Data Dictionary
+ `Time` is the athlete's reaction time in seconds

+ `Athlete` is a unique (to within a data set) integer assigned to each athlete.
The value is not significant and is used for the cluster aspect of the clustered
rank tests.

+ `Year` is coded as 1 if it occurred at the 2022 World Championships and 0
otherwise

+ `Event` is coded as 0 if it occured in a hurdles event and 1 if it occured
in a dash event.

