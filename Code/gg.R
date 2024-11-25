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
#gg3d <- gamlss(RxnTime ~ random(Heat), sigma.formula = ~ random(Venue), data = dhm, family = GG, control = gamlss.control(n.cyc = 40))
#gg4 <- gamlss(RxnTime ~ random(Venue) + random(Heat), sigma.formula = ~ random(Venue) + random(Heat), data = dhm, family = GG, control = gamlss.control(n.cyc = 40))


AIC(gg1, gg2, gg3, gg3b, gg3c) # gg3b is the best
qq_conf_plot(residuals(gg3b), dparams = list(mean = 0, sd = 1)) ## z-scores have known mean and sd
qq_conf_plot(gg3b$sigma.coefSmo[[1]]$coef)
qq_conf_plot(gg3b$mu.coefSmo[[1]]$coef)

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

# As the models are not perfectly nested, anova() function does not work. Instead
# we manually find the appropriate measures and calculate the p value ourselves.

logLik_gg3b <- logLik(gg3b)
logLik_gg_event <- logLik(gg_event)
LRT <- 2 * (logLik_gg_event - logLik_gg3b)
df_diff <- attr(logLik_gg_event, "df") - attr(logLik_gg3b, "df")
p_value <- pchisq(LRT, df = df_diff, lower.tail = FALSE)
cat("LRT:", LRT, "\nDegrees of Freedom:", df_diff, "\nP-value:", p_value, "\n")


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

