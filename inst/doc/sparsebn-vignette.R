## ------------------------------------------------------------------------
mean.vector <- rep(0, 3)
covariance.matrix <- rbind(c(3,2,1),
                           c(2,2,1),
                           c(1,1,1))

## ------------------------------------------------------------------------
gaussian.data <- mvtnorm::rmvnorm(n = 100, mean = mean.vector, sigma = covariance.matrix)
colnames(gaussian.data) <- c("X1", "X2", "X3")

## ----message=FALSE, warning=FALSE----------------------------------------
library("sparsebn")
dat <- sparsebnData(gaussian.data, type = "continuous")

## ------------------------------------------------------------------------
dags.out <- estimate.dag(data = dat, 
                         lambdas.length = 20, 
                         edge.threshold = 10, 
                         verbose = FALSE)
dags.out

## ------------------------------------------------------------------------
dags.out[[3]]
get.adjacency.matrix(dags.out[[3]])

## ---- warning=FALSE, message=FALSE---------------------------------------
cov.out <- estimate.covariance(data = dat)

## ------------------------------------------------------------------------
class(cov.out)

## ------------------------------------------------------------------------
cov.out[[3]]

## ---- warning=FALSE, message=FALSE---------------------------------------
gaussian.data <- mvtnorm::rmvnorm(n = 1000, mean = mean.vector, sigma = covariance.matrix)
dat <- sparsebnData(gaussian.data, type = "continuous")
cov.out <- estimate.covariance(data = dat)
cov.out[[3]]

## ------------------------------------------------------------------------
data(pathfinder)
dat <- sparsebnData(pathfinder$data, type = "c", ivn = NULL)

## ----message=FALSE, warning=FALSE----------------------------------------
nn <- num.samples(dat) # number of samples in the dataset / equivalent to nrow(dat$data)
lambdas <- generate.lambdas(sqrt(nn), 0.05, lambdas.length = 50, scale = "linear")
dags.out <- estimate.dag(data = dat, 
                         lambdas = lambdas,
                         edge.threshold = 500, 
                         verbose = FALSE)
dags.out

## ------------------------------------------------------------------------
solution <- get.solution(dags.out, edges = 195)
plot(solution,
     layout = igraph::layout.circle(to_igraph(solution$edges)),
     vertex.label = NA,
     vertex.size = 5,
     vertex.color = gray(0.75),
     edge.color = gray(0),
     edge.width = 1,
     edge.arrow.size = .25)

## ------------------------------------------------------------------------
plot(pathfinder$dag,
     layout = igraph::layout.circle(to_igraph(pathfinder$dag)),
     vertex.label = NA,
     vertex.size = 5,
     vertex.color = gray(0.75),
     edge.color = gray(0),
     edge.width = 1,
     edge.arrow.size = .25)

## ------------------------------------------------------------------------
select.idx <- select.parameter(dags.out, dat)
solution <- get.solution(dags.out, index = select.idx)
plot(solution,
     layout = igraph::layout.circle(to_igraph(solution$edges)),
     vertex.label = NA,
     vertex.size = 5,
     vertex.color = gray(0.75),
     edge.color = gray(0),
     edge.width = 1,
     edge.arrow.size = .25)

## ------------------------------------------------------------------------
out.fit <- estimate.parameters(dags.out, data = dat)

## ------------------------------------------------------------------------
unlist(lapply(out.fit, function(x) x$coefs[1,2]))

## ------------------------------------------------------------------------
data(pathfinder)
B <- as.matrix(get.adjacency.matrix(pathfinder$dag)) # pathfinder network as an adjacency matrix

## ------------------------------------------------------------------------
id <- diag(rep(1, num.nodes(pathfinder$dag)))   # 109x109 identity matrix
Omega <- id                                     # conditional variances
Sigma <- solve(t(id - B)) %*% Omega %*% solve(id - B)

## ------------------------------------------------------------------------
set.seed(123)
nn <- 1000
gaussian.data <- mvtnorm::rmvnorm(nn, sigma = Sigma)

## ------------------------------------------------------------------------
B[B!=0] <- runif(n = num.edges(pathfinder$dag), min = 0.5, max = 2)
Sigma <- solve(t(id - B)) %*% Omega %*% solve(id - B)
gaussian.data <- mvtnorm::rmvnorm(nn, sigma = Sigma)

