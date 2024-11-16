## After fitting
## fit <- dash_and_hurdles_two_effect_gamma_log

pit <- function(fit) {
    shape <- 1/sigma(fit)^2
    pgamma(fit@frame$RxnTime, shape = shape, rate = shape/fitted(fit))
}

pp <- pit(fit)

library("qqconf")

qq_conf_plot(pp, qunif)
