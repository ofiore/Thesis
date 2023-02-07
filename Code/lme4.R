library(lme4)
library(ggplot2)

times <- read.csv("../Data/ThesisData.csv")
colnames(times) <- c("Year", "Type", "Time", "RxnTime", "Gender", "Batch")

## only use Finals, Male, not Disqualified runs, before 2022
men_finals <- subset(times, Type == "F" & Gender == "M" & Time != 'DQ') # & Year < 2022)
## boxplot(RxnTime ~ Year, data = finals, xlab = "Years")

library(lme4)
fit1 <- glmer(RxnTime ~ (1 | Year), data = men_finals, family = Gamma)
fit2 <- glmer(RxnTime ~ (1 | Year), data = men_finals, family = Gamma(link = "log"))
fit0 <- glm(RxnTime ~ 1, data = men_finals, family = Gamma(link = "log"))

qqnorm(resid(fit2))

## qqnorm(ranef(fit2)$Year[,1])
## qqline(ranef(fit2)$Year[,1])


## Fitted results
sfit0 <- summary(fit0)
pgamma(0.1, shape = 1 / sfit0$dispersion, scale = exp(coef(fit0)) * sfit0$dispersion)


simfit <- function(fit2, n = 12000000) {
  vc <- as.data.frame(VarCorr(fit2))
  ## mu <- exp(coef(fit2)$Year[,]) ## using fitted random effects only
  z <- rnorm(n, sd = vc$sdcor[1]) #$ using generated random effects
  mu <- exp(fixef(fit2) + z)
  shape <- 1 / vc$vcov[2]
  x <- rgamma(n, shape = shape, scale = mu / shape)
  x
}

x <- simfit(fit2)
mean(x < 0.1)
quantile(x, prob = c(.00001, .0001, .0005, .001))
## compare with and without random effect
plot(density(x)) # with random effect
curve(dgamma(x, shape = 1 / sfit0$dispersion,
             scale = exp(coef(fit0)) * sfit0$dispersion),
      0.08, 0.22, add = TRUE, col = "blue") # fixed effect only

## Does it make sense to pool the genders?
women_finals <- subset(times, Type == "F" & Gender == "F" & Time != 'DQ')
fit1 <- glmer(RxnTime ~ (1 | Year), data = women_finals, family = Gamma)
fit2 <- glmer(RxnTime ~ (1 | Year), data = women_finals, family = Gamma(link = "log"))
fit0 <- glm(RxnTime ~ 1, data = women_finals, family = Gamma(link = "log"))



simfit <- function(fit2, n = 12000000) {
  vc <- as.data.frame(VarCorr(fit2))
  ## mu <- exp(coef(fit2)$Year[,]) ## using fitted random effects only
  z <- rnorm(n, sd = vc$sdcor[1]) #$ using generated random effects
  mu <- exp(fixef(fit2) + z)
  shape <- 1 / vc$vcov[2]
  x <- rgamma(n, shape = shape, scale = mu / shape)
  x
}

x <- simfit(fit2)
mean(x < 0.1)
quantile(x, prob = c(.00001, .0001, .0005, .001))
## compare with and without random effect
plot(density(x)) # with random effect
curve(dgamma(x, shape = 1 / sfit0$dispersion,
             scale = exp(coef(fit0)) * sfit0$dispersion),
      0.08, 0.22, add = TRUE, col = "red") # fixed effect only


## Clean the data to remove those DQ data

## What if Devon Allen's DQ data is removed?

## What if the Year 2022 data were included?

## Try taking log transformation of the reaction time and then do a lmer fit/diagnosis
# Did this on the Times.Rmd

#Pooled finals and semifinals men
men_pooled <- subset(times, (Type == "F" | Type == "S") & Gender == "M" & Time != 'DQ') # & Year < 2022)
fit1 <- glmer(RxnTime ~ (1 | Year), data = men_pooled, family = Gamma)
fit2 <- glmer(RxnTime ~ (1 | Batch), data = men_pooled, family = Gamma(link = "log"))
fit0 <- glm(RxnTime ~ 1, data = men_pooled, family = Gamma(link = "log"))
qqnorm(resid(fit2))

simfit <- function(fit2, n = 12000000) {
  vc <- as.data.frame(VarCorr(fit2))
  ## mu <- exp(coef(fit2)$Year[,]) ## using fitted random effects only
  z <- rnorm(n, sd = vc$sdcor[2]) #$ using generated random effects
  #Need to add another z varaiable for batch and sdcor for the second random effect
  #z1 <- rnorm(n, sd = vc$sdcor[1] )
  mu <- exp(fixef(fit2) + z)
  shape <- 1 / vc$vcov[2]
  x <- rgamma(n, shape = shape, scale = mu / shape)
  x
}

x <- simfit(fit2)
mean(x < 0.1)
quantile(x, prob = c(.00001, .0001, .0005, .001))
## compare with and without random effect
plot(density(x)) # with random effect
curve(dgamma(x, shape = 1 / sfit0$dispersion,
             scale = exp(coef(fit0)) * sfit0$dispersion),
      0.08, 0.22, add = TRUE, col = "blue") # fixed effect only

#Pooled finals and semifinals women
women_pooled <- subset(times, (Type == "F" | Type == "S") & Gender == "F" & Time != 'DQ') # & Year < 2022)
fit1 <- glmer(RxnTime ~ (1 | Year), data = women_pooled, family = Gamma)
fit2 <- glmer(RxnTime ~ (1 | Year), data = women_pooled, family = Gamma(link = "log"))
fit0 <- glm(RxnTime ~ 1, data = women_pooled, family = Gamma(link = "log"))

simfit <- function(fit2, n = 12000000) {
  vc <- as.data.frame(VarCorr(fit2))
  ## mu <- exp(coef(fit2)$Year[,]) ## using fitted random effects only
  z <- rnorm(n, sd = vc$sdcor[1]) #$ using generated random effects
  mu <- exp(fixef(fit2) + z)
  shape <- 1 / vc$vcov[2]
  x <- rgamma(n, shape = shape, scale = mu / shape)
  x
}

x <- simfit(fit2)
mean(x < 0.1)
quantile(x, prob = c(.00001, .0001, .0005, .001))
## compare with and without random effect
plot(density(x)) # with random effect
curve(dgamma(x, shape = 1 / sfit0$dispersion,
             scale = exp(coef(fit0)) * sfit0$dispersion),
      0.08, 0.22, add = TRUE, col = "blue") # fixed effect only

#QQ plot
#Log Men pooled vs Gamma men pooled
par(mfrow = c(2,1))
men_pooled <- subset(times, (Type == "F" | Type == "S") & Gender == "M" & Time != 'DQ') # & Year < 2022)
gamma_men_pooled <- glmer(RxnTime ~ (1 | Year), data = men_pooled, family = Gamma(link = "log"))
log_men_pooled <- lmer(log(RxnTime) ~ (1|Year), data = men_pooled)
qqnorm(resid(gamma_men_pooled), main = "Gamma")
qqnorm(resid(log_men_pooled), main = "Log")

#2 random effects
two_effect <- glmer(RxnTime ~ (1 | Year) + (1 | Batch), data = men_pooled, family = Gamma(link = "log"))
one_effect <- glmer(RxnTime ~ (1 | Year) , data = men_pooled, family = Gamma(link = "log"))
no_effect <- glm(RxnTime ~ 1, data = men_pooled, family = Gamma(link = "log"))
batch <- glmer(RxnTime ~ (1 | Batch) , data = men_pooled, family = Gamma(link = "log"))
anova(batch, two_effect)
anova(one_effect, two_effect)
par(mfrow=c(1,1))
qqnorm(resid(two_effect))
par(mfrow=c(2,1))
qqnorm(ranef(two_effect)$Year[,1])
qqnorm(ranef(two_effect)$Batch[,1])
qqnorm(ranef(batch)$Batch[,1])
qqnorm(resid(one_effect), main = "Without Batch Effect")
anova(one_effect, two_effect)

