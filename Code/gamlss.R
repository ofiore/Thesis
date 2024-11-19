## get the right dataset
library(tidyverse)
times <- read.csv("../Data/GLMMData.csv")
colnames(times) <- c("Venue", "Type", "Time", "RxnTime", "Gender", "Heat", "Event")

## Please reduce the length of your variable and object names;
## they are too long and distracting.

## dash/hurdle/man
dhm <- times |>
  filter(Type == "F" | Type == "S") |>
  filter(Gender == "M") |>
  filter(Time != "DNS" & Time != "DQ" & Time != "D") |>
  filter(RxnTime != 0) |>
  filter(Event == "100 Dash" | Event == "110 Hurdles")

dhm$Venue <- as.factor(dhm$Venue)
dhm$Heat <- as.factor(dhm$Heat)


## Fit various distributions available from gamlss
## Plot standarized residuals q-q plot
library("gamlss")
library("qqconf")

## log-normal
ln0  <- gamlss(RxnTime ~ 1, data = dhm, family = LOGNO)
ln1  <- gamlss(RxnTime ~ 1 + random(Venue), data = dhm, family = LOGNO)
ln2  <- gamlss(RxnTime ~ random(Venue) + random(Heat), data = dhm, family = LOGNO)
ln3  <- gamlss(RxnTime ~ random(Venue) + random(Heat), sigma.formula = ~ random(Venue), data = dhm, family = LOGNO)
ln4  <- gamlss(RxnTime ~ random(Venue) + random(Heat), sigma.formula = ~ random(Venue) + random(Heat), data = dhm, family = LOGNO)

AIC(ln0, ln1, ln2, ln3, ln4)

qq_conf_plot(residuals(ln0))
qq_conf_plot(residuals(ln1))
qq_conf_plot(residuals(ln2))

## three-parameter: generalized gamma
gg1  <- gamlss(RxnTime ~ random(Venue), data = dhm, family = GG)
gg2  <- gamlss(RxnTime ~ random(Venue) + random(Heat), data = dhm, family = GG)
gg3  <- gamlss(RxnTime ~ random(Venue) + random(Heat), sigma.formula = ~ random(Venue), data = dhm, family = GG, control = gamlss.control(n.cyc = 40))
gg3a  <- gamlss(RxnTime ~ random(Venue) + random(Heat), sigma.formula = ~ random(Heat), data = dhm, family = GG, control = gamlss.control(n.cyc = 40))
gg3b  <- gamlss(RxnTime ~ random(Venue), sigma.formula = ~ random(Heat), data = dhm, family = GG, control = gamlss.control(n.cyc = 40))
gg3c  <- gamlss(RxnTime ~ random(Heat), sigma.formula = ~ random(Heat), data = dhm, family = GG, control = gamlss.control(n.cyc = 40))
gg3d  <- gamlss(RxnTime ~ random(Heat), sigma.formula = ~ random(Venue), data = dhm, family = GG, control = gamlss.control(n.cyc = 40))
gg4  <- gamlss(RxnTime ~ random(Venue) + random(Heat), sigma.formula = ~ random(Venue) + random(Heat), data = dhm, family = GG, control = gamlss.control(n.cyc = 40))


AIC(gg1, gg2, gg3, gg3a, gg3b, gg3c, gg3d, gg4) # gg3b is the best
qq_conf_plot(residuals(gg3b), dparams = list(mean = 0, sd = 1)) ## z-scores have known mean and sd
qq_conf_plot(gg3b$sigma.coefSmo[[1]]$coef)
qq_conf_plot(gg3b$mu.coefSmo[[1]]$coef)

             
### random effects in mu
gg3b$mu.coefSmo
gg3b$mu.coefSmo[[1]]$sigb
gg3b$sigma.coefSmo[[1]]$sigb

### Owen, with the random effects sd and the parameters (mu, sigma, nu),
### you can develop code to simulate from the model for threshold evaluation

### The lognormal fit is also quite good, except on the right tail.
### Since our focus is the left tail, it'd be interesting to simulate
### from the lognromal too as a sensitivity check for the threshold evaluation.

### random effects in sigma
             
## gamma
ga0  <- gamlss(RxnTime ~ 1, data = dhm, family = GA)
ga1  <- gamlss(RxnTime ~ random(Venue), data = dhm, family = GA)
ga2  <- gamlss(RxnTime ~ random(Venue) + random(Heat), data = dhm, family = GA)
ga4  <- gamlss(RxnTime ~ random(Venue) + random(Heat), sigma.formula = ~ random(Venue) + random(Heat), data = dhm, family = GA, control = gamlss.control(n.cyc = 40))

AIC(ga2)
AIC(ga4)
qq_conf_plot(residuals(ga4), dparams = list(mean = 0, sd = 1)) ## z-scores have known mean and sd


## weibull
we0  <- gamlss(RxnTime ~ 1, data = dhm, family = WEI3)
we1  <- gamlss(RxnTime ~ random(Venue), data = dhm, family = WEI3)
we2  <- gamlss(RxnTime ~ random(Venue) + random(Heat), data = dhm, family = WEI3)

AIC(we2)
qq_conf_plot(residuals(we2), dparams = list(mean = 0, sd = 1)) ## z-scores have known mean and sd

## inverse gaussian
igau2  <- gamlss(RxnTime ~ random(Venue) + random(Heat), data = dhm, family = IG)
igau3  <- gamlss(RxnTime ~ random(Venue) + random(Heat), sigma.formula = ~ random(Venue), data = dhm, family = IG, cont3ol = gamlss.control(n.cyc = 40))
igau3a  <- gamlss(RxnTime ~ random(Venue) + random(Heat), sigma.formula = ~ random(Heat), data = dhm, family = IG, control = gamlss.control(n.cyc = 40))
igau3b  <- gamlss(RxnTime ~ random(Venue), sigma.formula = ~ random(Heat), data = dhm, family = IG, control = gamlss.control(n.cyc = 40))
igau3c  <- gamlss(RxnTime ~ random(Heat), sigma.formula = ~ random(Heat), data = dhm, family = IG, control = gamlss.control(n.cyc = 40))
igau4  <- gamlss(RxnTime ~ random(Venue) + random(Heat), sigma.formula = ~ random(Venue) + random(Heat), data = dhm, family = IG, control = gamlss.control(n.cyc = 40)) 

AIC(igau2, igau3, igau3a, igau3b, igau3c, igau4)
qq_conf_plot(residuals(igau4), dparams = list(mean = 0, sd = 1)) ## z-scores have known mean and sd # good looking

## inverse gamma
igam2  <- gamlss(RxnTime ~ random(Venue) + random(Heat), data = dhm, family = IGAMMA)


## exGAUS # does not fit
## eg0 <- gamlss(RxnTime ~ 1, data = dhm, family = exGAUS)
## eg1 <- gamlss(RxnTime ~ random(Venue), data = dhm, family = exGAUS)
## eg2 <- gamlss(RxnTime ~ random(Venue) + random(Heat), data = dhm, family = exGAUS)

## qq_conf_plot(residuals(eg0))

# Generalized Inverse Gaussian
gig1 <- gamlss(RxnTime ~ random(Venue), sigma.formula = ~ random(Heat), data = dhm, family = GIG, control = gamlss.control(n.cyc = 40))
gig2 <- gamlss(RxnTime ~ random(Venue) + random(Heat), data = dhm, family = GIG, control = gamlss.control(n.cyc = 40))
gig3 <- gamlss(RxnTime ~ random(Venue) + random(Heat), sigma.formula = ~ random(Heat), data = dhm, family = GIG, control = gamlss.control(n.cyc = 40))
gig3b <- gamlss(RxnTime ~ random(Venue), sigma.formula = ~ random(Heat), data = dhm, family = GIG, control = gamlss.control(n.cyc = 40))
gig4 <- gamlss(RxnTime ~ random(Venue) + random(Heat), sigma.formula = ~ random(Venue) + random(Heat), data = dhm, family = GIG, control = gamlss.control(n.cyc = 40))


AIC(gig1, gig2, gig3, gig3b, gig4)
qq_conf_plot(residuals(gig3b), dparams = list(mean = 0, sd = 1)) ## z-scores have known mean and sd
# While some of the AIC are strong and better than gg3b, the residuals are weak


# Simulation Code: only works for gg3b
sim_time <- function(model, RxnTime) {
  simfit <- function(model, n = 10000000) {
    
    sd_Venue <- model$mu.coefSmo[[1]]$sigb
    sd_Venue_heat <- model$sigma.coefSmo[[1]]$sigb[1]
    
    mu <- exp(model$mu.coefficients[1] + rnorm(n, mean = 0 , sd = sd_Venue))
    sigma <- exp(model$sigma.coefficients[1] + rnorm(n, mean = 0 , sd = sd_Venue_heat))
    nu <- model$nu.coefficients[1]
    
    x <- rGG(n, mu = mu, sigma = sigma, nu = nu)
    x
  }
  x <- simfit(model)
  print(mean(x < RxnTime))
}
sim_time(gg3b, 0.1)


