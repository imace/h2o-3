setwd(normalizePath(dirname(R.utils::commandArgs(asValues=TRUE)$"f")))
source("../../../scripts/h2o-r-test-setup.R")



#import multimodal data set; parse as FV
test.summary2.numeric <- function() {
  Log.info("Importing wonkysummary.csv data...")
  wonkysummary.hex <- h2o.importFile(locate("smalldata/jira/wonkysummary.csv"), "wonky.hex")

#check that summary2 gives expected output
  Log.info("Check that summary gives output...")
  summary(wonkysummary.hex)
  summary_ <- summary(wonkysummary.hex, exact_quantiles=TRUE)
  Log.info("Check that we get a table back from the summary(hex)")
  expect_that(summary_, is_a("table"))


#check produced values against known values
  Log.info("Check that the summary from H2O matches known good values: ")
  H2Osum<- summary(wonkysummary.hex, exact_quantiles=TRUE)
  wonky.df<- read.csv(locate("smalldata/jira/wonkysummary.csv"))
  wonky.Rsum<-as.table(summary(wonky.df))
  
  Log.info("R's summary:")
  print(summary(wonky.df))
 
  Log.info("H2O's Summary:")
  print(summary_)

  checkSummary(H2Osum, wonky.Rsum) 
  
}

doTest("Summary Tests", test.summary2.numeric)

