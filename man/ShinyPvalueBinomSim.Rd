\name{ShinyPvalueBinomSim}
\alias{ShinyPvalueBinomSim}
\title{ Interactively Simulate P-values for a Binomial Test }
\description{
  Launches a Shiny app wrapping \code{\link{Pvalue.binom.sim}}: given a
  population proportion and a hypothesized proportion, it simulates
  many samples, tests each with an approximate or exact binomial test,
  and plots the resulting p-values in a histogram and QQ-plot.
}
\usage{
ShinyPvalueBinomSim(n = 100, p = 0.5, p0 = 0.5,
                     test = c("approx", "exact"),
                     alternative = c("two.sided", "less", "greater"),
                     alpha = 0.05, B = 1000)
}
\arguments{
  \item{n}{ Initial sample size. }
  \item{p}{ Initial true population proportion. }
  \item{p0}{ Initial hypothesized proportion (null value). }
  \item{test}{ Initial test type, \code{"approx"} or \code{"exact"}. }
  \item{alternative}{ Initial alternative hypothesis. }
  \item{alpha}{ Initial significance level. }
  \item{B}{ Initial number of simulated samples. }
}
\details{
  This function requires the \pkg{shiny} package to be installed.  Use
  the \dQuote{Refresh} button to redraw the simulation with the
  current settings.  When \code{p == p0}, the simulated p-values
  should approximately follow a uniform distribution; as the true
  proportion moves away from the hypothesized value, the distribution
  of p-values shifts towards 0, illustrating power.
}
\value{
  Called for the side effect of running a Shiny app.  Returns whatever
  \code{\link[shiny]{runApp}} returns (typically invisible \code{NULL}
  when the app is stopped).
}
\author{ Greg Snow \email{538280@gmail.com} }
\seealso{ \code{\link{Pvalue.binom.sim}}, \code{\link{ShinyPvalueNormSim}} }
\examples{
if(interactive()) {
  ShinyPvalueBinomSim()
}
}
\keyword{ dynamic }
