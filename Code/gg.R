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
  filter(Time != "DNS") |>
  filter(RxnTime > 0) |>
  filter(Event == "100 Dash" | Event == "110 Hurdles")

dhm$Venue <- as.factor(dhm$Venue)
dhm$Heat <- as.factor(dhm$Heat)


## Fit various distributions available from gamlss
## Plot standarized residuals q-q plot
library("gamlss")
library("qqconf")

## three-parameter: generalized gamma
gg0 <- gamlss(RxnTime ~ 1, data = dhm, family = GG)
gg1 <- gamlss(RxnTime ~ random(Venue), data = dhm, family = GG)
gg2 <- gamlss(RxnTime ~ random(Venue) + random(Heat), data = dhm, family = GG)
gg3 <- gamlss(RxnTime ~ random(Venue) + random(Heat), sigma.formula = ~ random(Venue), data = dhm, family = GG, control = gamlss.control(n.cyc = 40))
## gg3a  <- gamlss(RxnTime ~ random(Venue) + random(Heat), sigma.formula = ~ random(Heat), data = dhm, family = GG, control = gamlss.control(n.cyc = 40))
gg3b <- gamlss(RxnTime ~ random(Venue), sigma.formula = ~ random(Heat), data = dhm, family = GG, control = gamlss.control(n.cyc = 40))
gg3c <- gamlss(RxnTime ~ random(Heat), sigma.formula = ~ random(Heat), data = dhm, family = GG, control = gamlss.control(n.cyc = 40))
gg3d <- gamlss(RxnTime ~ random(Heat), sigma.formula = ~ random(Venue), data = dhm, family = GG, control = gamlss.control(n.cyc = 40))
gg4 <- gamlss(RxnTime ~ random(Venue) + random(Heat), sigma.formula = ~ random(Venue) + random(Heat), data = dhm, family = GG, control = gamlss.control(n.cyc = 40))


AIC(gg1, gg2, gg3, gg3a, gg3b, gg3c, gg3d, gg4) # gg3b is the best
qq_conf_plot(residuals(gg3b), dparams = list(mean = 0, sd = 1)) ## z-scores have known mean and sd
qq_conf_plot(gg3b$sigma.coefSmo[[1]]$coef)
qq_conf_plot(gg3b$mu.coefSmo[[1]]$coef)

# Simulation Code: only works for gg3b
simfit <- function(model, n = 10000000) {
    sd_Venue <- model$mu.coefSmo[[1]]$sigb
    sd_Venue_heat <- model$sigma.coefSmo[[1]]$sigb[1]
    
    mu <- exp(model$mu.coefficients[1] + rnorm(n, mean = 0 , sd = sd_Venue))
    sigma <- exp(model$sigma.coefficients[1] + rnorm(n, mean = 0 , sd = sd_Venue_heat))
    nu <- model$nu.coefficients[1]
    
    rGG(n, mu = mu, sigma = sigma, nu = nu)
}

samplefit <- simfit(gg3b)

mean(samplefit < .010) # sim_time(gg3b, 0.1)
mean(sampltfit < .009) # sim_time(gg3b, 0.09)
mean(samplefit < .008) # sim_time(gg3b, 0.08)

quantile(samplefit, c(.001, .0001))

samplefit0 <- samplefit[1:1000000]

hist(dhm$RxnTime, freq=FALSE, breaks=seq(.05, .40, by = .01))
kernfit <- density(samplefit0)
lines(kernfit$x, kernfit$y) # /1.434) ## density seems to have a bug for n too large
curve(dGG(x, mu = exp(gg0$mu.coefficients[1]),
          sigma = exp(gg0$sigma.coefficients[1]),
          nu = gg0$nu.coefficients[1]), add = TRUE, col = "blue")
