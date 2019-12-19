# mixturer

## Overview

Translation of [Paul Bays'](http://www.psychol.cam.ac.uk/people/paul-bays) Matlab functions for modelling precision data into R.  The code is also as close as possible to the Matlab code 'under the hood'. The model implemented is described in:

The precision of visual working memory is set by allocation of a shared resource. Bays PM, Catalao RFG & Husain M. *Journal of Vision* 9(10): 7, 1-11 (2009).

## Installation

```
remotes::install_github('eddjberry/mixturer')
```

## Example


```r
library(mixturer)

set.seed(1295)

response <- randomvonmises(1000, 0, 1)
target <- response + rnorm(1000, 0, 0.01)

df_test_von_mises <- data.frame(response, target)

df_test_von_mises$response_rad <- wrap(df_test_von_mises$response/90*pi)
df_test_von_mises$target_rad <- wrap(df_test_von_mises$target/90*pi)

(ests1 = bays_2009_fit(X = df_test_von_mises$response_rad, Tg = df_test_von_mises$target_rad, return.ll= F))
```

```
##   K   Pt Pn   Pu
## 1 1 0.99  0 0.01
```

## Comparison to Matlab functions

The function names have been changes to have the prefix `bays_2009_` to hopefully make it obvious that model is being used.
The table below shows the Matlab function names as described in [Bays' guide](http://www.paulbays.com/code/JV10/), and the equivalent function in this package.

| Matlab function | R function        |
|-----------------|-------------------|
| JV10_error()    | bays_2009_error() |
| JV10_fit()      | bays_2009_fit()   |

## Citation

Bays PM, Catalao RFG & Husain M. *Journal of Vision* 9(10): 7, 1-11 (2009).

Berry E, & Bays P (2019). mixturer: Mixture Models for Analogue Response Data. R package version 0.1.0.

## Contributing

I did the orignal translation used for this package back in 2016. 
It could certainly been improved upon.
In addition, there are a number of other models for continuous response data that have been proposed.
If someone wanted to, the [other models that Paul Bays has proposed](https://www.paulbays.com/code.php) could be translation into R and added to this package.

