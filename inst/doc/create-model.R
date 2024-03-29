## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(agena.ai)

## -----------------------------------------------------------------------------
A <- new("Node", id="A", name="Visit to Asia?")
S <- new("Node", id="S", name="Smoker?")

TB <- new("Node", id="T", name="Has tuberculosis")
L <- new("Node", id="L", name="Has lung cancer")
B <- new("Node", id="B", name="Has bronchitis")

TBoC <- new("Node", id="TBoC", name="Tuberculosis or cancer")

X <- new("Node", id="X", name="Positive X-ray?")
D <- new("Node", id="D", name="Dyspnoea?")

## -----------------------------------------------------------------------------
TB$add_parent(A)
L$add_parent(S)
B$add_parent(S)
TBoC$add_parent(TB)
TBoC$add_parent(L)
X$add_parent(TBoC)
D$add_parent(TBoC)
D$add_parent(B)

## -----------------------------------------------------------------------------
A$set_probabilities(list(0.99, 0.01))
TB$set_probabilities(list(c(0.99,0.01),c(0.95,0.05)),by_rows = FALSE)
L$set_probabilities(list(c(0.9,0.1),c(0.99,0.01)),by_rows = FALSE)
B$set_probabilities(list(c(0.7,0.3), c(0.4,0.6)),by_rows = FALSE)
TBoC$set_probabilities(list(c(1,0),c(0,1),c(0,1),c(0,1)),by_rows = FALSE)
X$set_probabilities(list(c(0.95,0.05), c(0.02,0.98)),by_rows = FALSE)
D$set_probabilities(list(c(0.9,0.1),c(0.2,0.8),c(0.3,0.7),c(0.1,0.9)),by_rows = FALSE)

## -----------------------------------------------------------------------------
asia_net = new("Network", id="asia_net", nodes=c(A,S,TB,L,B,TBoC,X,D))
asia_model = new("Model", networks = list(asia_net))

## -----------------------------------------------------------------------------
asia_model$to_cmpx()

