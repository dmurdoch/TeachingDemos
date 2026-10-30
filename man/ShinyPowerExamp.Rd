\name{ShinyPowerExamp}
\alias{ShinyPowerExamp}
\title{ Interactively Demonstrate Statistical Power }
\description{
  Launches a Shiny app wrapping \code{\link{power.examp}}: it plots the
  sampling distributions of a test statistic under the null and
  alternative hypotheses, along with the rejection region, alpha, and
  power.
}
\usage{
ShinyPowerExamp(n = 1, sd = 1, diff = 0, alpha = 0.05, xmin = -2, xmax = 4)
}
\arguments{
  \item{n}{ Initial sample size. }
  \item{sd}{ Initial population standard deviation. }
  \item{diff}{ Initial true difference from the null hypothesis. }
  \item{alpha}{ Initial significance level. }
  \item{xmin}{ Initial minimum x value for the plot. }
  \item{xmax}{ Initial maximum x value for the plot. }
}
\details{
  This function requires the \pkg{shiny} package to be installed.
  Changing the sample size, standard deviation, true difference, or
  alpha updates the plot so you can see the effect of each parameter
  on statistical power.
}
\value{
  Called for the side effect of running a Shiny app.  Returns whatever
  \code{\link[shiny]{runApp}} returns (typically invisible \code{NULL}
  when the app is stopped).
}
\author{ Greg Snow \email{538280@gmail.com} }
\seealso{ \code{\link{power.examp}}, \code{\link{power.t.test}} }
\examples{
if(interactive()) {
  ShinyPowerExamp()
}
}
\keyword{ dynamic }
