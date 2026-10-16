\name{approxExtrap}
\alias{approxExtrap}
\title{Linear Extrapolation}
\description{
  Works in conjunction with the \code{\link{approx}} function to do linear
  extrapolation.  \code{\link{approx}} in R does not support extrapolation at
  all, and it is buggy in S-Plus 6. 
}
\usage{
approxExtrap(x, y, xout, method = "linear", n = 50, rule = 2,
             f = 0, ties = "ordered", curtail = NULL,
             na.rm = FALSE, right.slope = NULL,
             diagnostics = FALSE)
}
\arguments{
  \item{x,y,xout,method,n,rule,f}{
    see \code{\link{approx}}
  }
  \item{ties}{
    applies only to R.  See \code{\link{approx}}
  }
  \item{curtail}{
  Optional numeric vector of length two specifying lower and upper bounds for extrapolated values. 
  When supplied, values outside the range of the retained \code{x} coordinates are clipped to these bounds on both sides. 
  Values at the endpoints or within that range are not clipped. The default, \code{NULL}, applies no clipping. 
  Missing extrapolated values remain missing.
  }
  \item{na.rm}{
    set to \code{TRUE} to remove \code{NA}s in \code{x} and
    \code{y} before proceeding
  }
  \item{right.slope}{
  Optional slope for extrapolation beyond the largest retained \code{x} value. If \code{NULL}, use the slope through 
  the final two retained coordinates. Otherwise, supply one finite numeric value or \code{NA_real_}. 
  A supplied slope is anchored at the final retained coordinate. With \code{NA_real_}, right-side extrapolated values are missing.
}
\item{diagnostics}{
  Logical. If \code{TRUE}, include an \code{extrapolation} data frame in the returned list, describing each requested
  coordinate, extrapolation distance, slope, and clipping.
}
}
\details{
  Duplicates in \code{x} (and corresponding \code{y} elements) are removed
  before using \code{approx}.
}
\value{
  A list containing \code{x}, the requested coordinates, and
  \code{y}, the corresponding interpolated or extrapolated values
  after any clipping.

  If \code{diagnostics = TRUE}, the list also contains an
  \code{extrapolation} data frame with one row per requested
  coordinate, in the original request order. Its columns are:
  \describe{
    \item{\code{x}}{The requested coordinate.}
    \item{\code{side}}{
      \code{"left"}, \code{"right"}, or \code{"none"}, according
      to whether the coordinate lies below, above, or within
      the retained coordinate range. Endpoints have
      \code{side = "none"}.
    }
    \item{\code{extrapolated}}{
      Logical indicator that the requested coordinate is outside
      the retained coordinate range, even if its estimated value
      is missing.
    }
    \item{\code{anchor.x}}{
      The nearest boundary coordinate for extrapolation.
    }
    \item{\code{anchor.y}}{
      The retained ordinate at that boundary, before clipping.
    }
    \item{\code{slope}}{
      The slope used for extrapolation, or \code{NA} when unavailable.
    }
    \item{\code{x.change}}{
      Signed horizontal change from the boundary:
      \code{x - anchor.x}.
    }
    \item{\code{x.distance}}{
      Absolute horizontal extrapolation distance:
      \code{abs(x.change)}.
    }
    \item{\code{y.change.raw}}{
      Signed vertical change from the boundary before clipping:
      \code{raw.value - anchor.y}.
    }
    \item{\code{y.change}}{
      Signed vertical change from the boundary after clipping:
      \code{value - anchor.y}.
    }
    \item{\code{raw.value}}{
      The interpolated or extrapolated value before clipping.
    }
    \item{\code{value}}{
      The final value, matching the corresponding element of
      the returned \code{y}.
    }
    \item{\code{clipping.correction}}{
      Signed adjustment due to clipping:
      \code{value - raw.value}.
    }
    \item{\code{clipped}}{
      Logical indicator that clipping changed the value.
      Set to \code{NA} if either the raw or final value is missing.
    }
  }

  For coordinates within the retained range, including endpoints,
  \code{anchor.x}, \code{anchor.y}, and \code{slope} are \code{NA}.
  The horizontal and vertical change fields are zero for these
  coordinates; they do not measure interpolation changes.

  These diagnostics describe numerical extrapolation and clipping.
  They do not quantify statistical uncertainty or predictive accuracy.
}
\author{Frank Harrell}
\seealso{\code{\link{approx}}}
\examples{
approxExtrap(1:3,1:3,xout=c(0,4))
}
\keyword{arith}
\keyword{dplot}
