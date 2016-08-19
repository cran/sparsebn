sparsebn
========

[![Travis-CI Build Status](https://travis-ci.org/itsrainingdata/sparsebn.svg?branch=master)](https://travis-ci.org/itsrainingdata/sparsebn)

Methods for learning sparse Bayesian networks and other graphical models from high-dimensional data via sparse regularization. Designed to handle:

-   Experimental data with interventions
-   Mixed observational / experimental data
-   High-dimensional data with *p &gt;&gt; n*
-   Datasets with thousands of variables (tested up to *p*=8000)
-   Continuous and discrete data

The workhorse behind [`sparsebn`](http://www.github.com/itsrainingdata/sparsebn/) is the [`sparsebnUtils`](http://www.github.com/itsrainingdata/sparsebnUtils/) package, which provides various S3 classes and methods for representing and manipulating graphs. The basic algorithms are implemented in [`ccdrAlgorithm`](http://www.github.com/itsrainingdata/ccdrAlgorithm/) and [`discretecdAlgorithm`](http://www.github.com/gujyjean/discretecdAlgorithm/).

Overview
--------

The main methods for learning graphical models are:

-   `estimate.dag` for directed acyclic graphs (Bayesian networks).
-   `estimate.precision` for undirected graphs (Markov random fields).
-   `estimate.covariance` for covariance matrices.

Currently, estimation of precision and covariances matrices is limited to Gaussian data.

Installation
------------

You can install:

-   the latest CRAN version with

    ``` r
    install.packages("sparsebn")
    ```

-   the latest development version from GitHub with

    ``` r
    devtools::install_github(c("itsrainingdata/sparsebn/", "itsrainingdata/sparsebnUtils/dev", "itsrainingdata/ccdrAlgorithm/dev", "gujyjean/discretecdAlgorithm"))
    ```

References
----------

\[1\] Aragam, B. and Zhou, Q. (2015). [Concave penalized estimation of sparse Gaussian Bayesian networks.](http://jmlr.org/papers/v16/aragam15a.html) *The Journal of Machine Learning Research*. 16(Nov):2273−2328.

\[2\] Fu, F., Gu, J., and Zhou, Q. (2014). [Adaptive penalized estimation of directed acyclic graphs from categorical data.](http://arxiv.org/abs/1403.2310) arXiv: 1403.2310.

\[3\] Aragam, B., Amini, A. A., and Zhou, Q. (2015). [Learning directed acyclic graphs with penalized neighbourhood regression.](http://arxiv.org/abs/1511.08963) arXiv: 1511.08963.

\[4\] Fu, F. and Zhou, Q. (2013). [Learning sparse causal Gaussian networks with experimental intervention: Regularization and coordinate descent.](http://amstat.tandfonline.com/doi/abs/10.1080/01621459.2012.754359) Journal of the American Statistical Association, 108: 288-300.