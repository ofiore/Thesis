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
gg3a  <- gamlss(RxnTime ~ random(Venue) + random(Heat), sigma.formula = ~ random(Heat), data = dhm, family = GG, control = gamlss.control(n.cyc = 40, mu.step = .5))
gg3b <- gamlss(RxnTime ~ random(Venue), sigma.formula = ~ random(Heat), data = dhm, family = GG, control = gamlss.control(n.cyc = 40))
gg3c <- gamlss(RxnTime ~ random(Heat), sigma.formula = ~ random(Heat), data = dhm, family = GG, control = gamlss.control(n.cyc = 40))
gg3d <- gamlss(RxnTime ~ random(Heat), sigma.formula = ~ random(Venue), data = dhm, family = GG, control = gamlss.control(n.cyc = 40, sigma.step = .5))
gg4 <- gamlss(RxnTime ~ random(Venue) + random(Heat), sigma.formula = ~ random(Venue) + random(Heat), data = dhm, family = GG, control = gamlss.control(n.cyc = 40, mu.step = .5))


AIC(gg1, gg2, gg3, gg3b, gg3a,gg3c, gg3d, gg4) # gg3b is the best
qq_conf_plot(residuals(gg3b), dparams = list(mean = 0, sd = 1)) ## z-scores have known mean and sd
qq_conf_plot(gg3b$sigma.coefSmo[[1]]$coef)
qq_conf_plot(gg3b$mu.coefSmo[[1]]$coef)


## For reproducibility and to ensure that we got the same results. Run the function
## that takes a GG model as input and prints all important parameters.
model_print <- function(model) {
  cat("AIC: ", AIC(model), "\n")
  cat("mu (intercept): ", model$mu.coefficients[1], "\n")
  cat("sigma (intercept): ", model$sigma.coefficients[1], "\n")
  cat("nu: ", model$nu.coefficients[1], "\n")
  cat("sigma_v or std dev of venue effect: ", model$mu.coefSmo[[1]]$sigb, "\n")
  cat("sigma_h or std dev of heat effect: ", model$sigma.coefSmo[[1]]$sigb[1], "\n")
}
model_print(gg3b)

# Simulation Code: only works for gg3b
simfit <- function(model, n = 10000000) {
    set.seed(1)
    sd_Venue <- model$mu.coefSmo[[1]]$sigb
    sd_Venue_heat <- model$sigma.coefSmo[[1]]$sigb[1]
    
    mu <- exp(model$mu.coefficients[1] + rnorm(n, mean = 0 , sd = sd_Venue))
    sigma <- exp(model$sigma.coefficients[1] + rnorm(n, mean = 0 , sd = sd_Venue_heat))
    nu <- model$nu.coefficients[1]
    
    rGG(n, mu = mu, sigma = sigma, nu = nu)
}

samplefit <- simfit(gg3b)

mean(samplefit < .10) # sim_time(gg3b, 0.1)
mean(samplefit < .09) # sim_time(gg3b, 0.09)
mean(samplefit < .08) # sim_time(gg3b, 0.08)

quantile(samplefit, c(.001, .0001))

samplefit0 <- samplefit[1:1000000]

pdf("diagnosis.pdf", height=3.25, width = 7, pointsize = 9)
par(mfrow = c(1, 2), mar = c(2.5, 2.5, .1, .1), mgp = c(1.5, 0.5, 0))
hist(dhm$RxnTime, freq=FALSE, breaks=seq(.05, .40, by = .01),
     xlab = "Reaction time", main = "")
kernfit <- density(samplefit0)
lines(kernfit$x, kernfit$y) # /1.434) ## density() seems to have a bug for n too large
## curve(dGG(x, mu = exp(gg0$mu.coefficients[1]),
##           sigma = exp(gg0$sigma.coefficients[1]),
##           nu = gg0$nu.coefficients[1]), add = TRUE, col = "blue")
qq_conf_plot(residuals(gg3b), dparams = list(mean = 0, sd = 1)) ## z-scores have known mean and sd
dev.off()

# Should we pool dash and hurdles?
dhm <- times |>
  filter(Type == "F" | Type == "S") |>
  filter(Gender == "M") |>
  filter(Time != "DNS") |>
  filter(RxnTime > 0) |>
  filter(Event == "100 Dash" | Event == "110 Hurdles")

gg_event <- gamlss(RxnTime ~ random(Venue) + Event, sigma.formula = ~ random(Heat), data = dhm, family = GG, control = gamlss.control(n.cyc = 40))

summary(gg_event)

## women 100 dash/hurdle
dhw <- times |>
filter(Type == "F" | Type == "S") |>
filter(Time != "DNS") |>
filter(Gender == "F") |>
filter(RxnTime > 0.072) |>
filter(Event %in% c("100 Dash", "100 Hurdles"))

dhw <- within(dhw, {Gender = as.factor(Gender); Event = as.factor(Event);
    Venue = as.factor(Venue); Heat = as.factor(Heat)})
dhw <- dhw[- which.min(dhw$RxnTime), ]


gg3b.w <- gamlss(RxnTime ~ random(Venue) + Event, sigma.formula = ~ random(Heat), data = dhw, family = GG, control = gamlss.control(n.cyc = 40))
gg3b0.w <- gamlss(RxnTime ~ random(Venue), sigma.formula = ~ random(Heat), data = dhw, family = GG, control = gamlss.control(n.cyc = 40))
gg3d.w <- gamlss(RxnTime ~ random(Venue) + Event, sigma.formula = ~ random(Venue) + random(Heat), data = dhw, family = GG, control = gamlss.control(n.cyc = 40))

AIC(gg3b.w, gg3b0.w, gg3d.w)
## Let's report gg3b0.w
qq_conf_plot(residuals(gg3b0.w), dparams = list(mean = 0, sd = 1)) ## z-scores have known mean and sd

##  summary(gg_dhw) # event is significant for women!
## one rxn time is too small, probabily really was a DQ

gg_dhw3 <- gamlss(RxnTime ~ random(Venue) + random(Heat), sigma.formula = ~ random(Venue) + Event, data = dhw, family = GG, control = gamlss.control(n.cyc = 40))
gg_dhw3a <- gamlss(RxnTime ~ random(Venue) + random(Heat), sigma.formula = ~ random(Heat) + Event, data = dhw, family = GG, control = gamlss.control(n.cyc = 40))
gg_dhw3b <- gamlss(RxnTime ~ random(Venue) + Event, sigma.formula = ~ random(Heat), data = dhw, family = GG, control = gamlss.control(n.cyc = 40))
gg_dhw3c <- gamlss(RxnTime ~ random(Heat), sigma.formula = ~ random(Heat), data = dhw, family = GG, control = gamlss.control(n.cyc = 40))
gg_dhw3d <- gamlss(RxnTime ~ random(Heat) + Event, sigma.formula = ~ random(Venue), data = dhw, family = GG, control = gamlss.control(n.cyc = 40))
gg_dhw4 <- gamlss(RxnTime ~ random(Venue) + random(Heat) + Event, sigma.formula = ~random(Venue) + random(Heat), data = dhw, family = GG, control = gamlss.control(n.cyc = 40))
#qq_conf_plot(residuals(gg_dhw4))
AIC(gg_dhw3, gg_dhw3a, gg_dhw3b, gg_dhw3c, gg_dhw3d, gg_dhw4)


## How much does including dqs matter?
dhm <- times |>
  filter(Type == "F" | Type == "S") |>
  filter(Gender == "M") |>
  filter(Time != "DNS") |>
  filter(RxnTime > 0) |>
  filter(Event == "100 Dash" | Event == "110 Hurdles")

dhm_nodq <- times |>
  filter(Type == "F" | Type == "S") |>
  filter(Gender == "M") |>
  filter(Time != "DNS", Time != "DQ", Time != "D") |>
  filter(RxnTime > 0) |>
  filter(Event == "100 Dash" | Event == "110 Hurdles")

gg3b_nodq <- gamlss(RxnTime ~ random(Venue), sigma.formula = ~ random(Heat), data = dhm_no2022, family = GG, control = gamlss.control(n.cyc = 40))
samplefit_nodq <- simfit(gg3b_nodq)

mean(samplefit_nodq < .10) # sim_time(gg3b, 0.1)
mean(samplefit_nodq < .09) # sim_time(gg3b, 0.09)
mean(samplefit_nodq < .08)

## Values are slighly smaller but are actually very similar to results without 2022

median(filter(dhm, Venue == 2022)$RxnTime)
median(filter(filter(dhm, Event == "100 Dash"), Venue == 2022)$RxnTime)

