set.seed(42)
n <- 200
dat <- data.frame(id = 1:n)
for (i in 1:6) {
  dat[[paste0('sdo_', i)]] <- sample(c(1:7, -99), n, replace = TRUE,
                                     prob = c(rep(0.13, 7), 0.09))
}
write.csv(dat, 'data/raw/wave1.csv', row.names = FALSE)
