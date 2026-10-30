\name{ShinyPvalueNormSim}
\alias{ShinyPvalueNormSim}
\title{ Interactively Simulate P-values for a Normal-Based Test }
\description{
  Launches a Shiny app wrapping \code{\link{Pvalue.norm.sim}}: given
  population and hypothesized parameters, it simulates many datasets,
  analyzes each with a z- or t-test, and plots the resulting p-values
  in a histogram and QQ-plot.
}
\usage{
ShinyPvalueNormSim(n = 50, mu = 10, mu0 = 10, sigma = 3, sigma0 = 3,
                    test = c("z", "t"),
                    alternative = c("two.sided", "less", "greater"),
                    alpha = 0.05, B = 1000)
}
\arguments{
  \item{n}{ Initial sample size. }
  \item{mu}{ Initial true population mean. }
  \item{mu0}{ Initial hypothesized mean (null value). }
  \item{sigma}{ Initial true population standard deviation. }
  \item{sigma0}{ Initial hypothesized standard deviation (used for the z-test). }
  \item{test}{ Initial test type, \code{"z"} or \code{"t"}. }
  \item{alternative}{ Initial alternative hypothesis. }
  \item{alpha}{ Initial significance level. }
  \item{B}{ Initial number of simulated datasets. }
}
\details{
  This function requires the \pkg{shiny} package to be installed.  Use
  the \dQuote{Refresh} button to redraw the simulation with the
  current settings.  When \code{mu == mu0} and other assumptions are
  met, the simulated p-values should follow a uniform distribution; as
  the true mean moves away from the hypothesized value, the
  distribution of p-values shifts towards 0, illustrating power.  The
  demo can also be used to explore what happens when assumptions (such
  as equal variance) are violated.
}
\value{
  Called for the side effect of running a Shiny app.  Returns whatever
  \code{\link[shiny]{runApp}} returns (typically invisible \code{NULL}
  when the app is stopped).
}
\author{ Greg Snow \email{538280@gmail.com} }
\seealso{ \code{\link{Pvalue.norm.sim}}, \code{\link{ShinyPvalueBinomSim}} }
\examples{
if(interactive()) {
  ShinyPvalueNormSim()
}
}
\keyword{ dynamic }
