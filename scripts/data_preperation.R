##########
# set working directory
##########
RPROJ <- list(PROJHOME = normalizePath(getwd()))
attach(RPROJ)
rm(RPROJ) 
getwd()

##########
# libraries
##########
library(stringr)
library(ggplot2)
library(dplyr)
library(tidyr)

##########
# read data
##########
all_files <- list.files("data")

all_csvs <- str_subset(all_files, "csv")

# remove csvs with clinical samples
all_csvs <- all_csvs[!all_csvs %in% c("fuo_stats.csv", 
                                      "mpx_stats.csv",
                                      "sars_stats.csv")]

virus_names <- lapply(str_split(all_csvs, "_stats.csv"), `[[`, 1)

virus_group <- c("cchfv","cchfv","cchfv",
                 "other",  "other",  "other", 
                 "other",
                 "rvfv","rvfv","rvfv",
                 "other")


datas <- lapply(all_csvs,
                           function(x) read.csv(paste("data/",x, sep = ""), 
                                                sep = ",",
                                                header = TRUE))
  
datas2 <- lapply(1:11, function(x) data.frame(datas[[x]],
                                    virus = virus_names[[x]]))

datas3 <- lapply(1:11, function(x) data.frame(datas2[[x]],
                                              virus_group = virus_group[x]))

datas_full <- bind_rows(datas3)

# mean value over replicates
datas_full2 <- datas_full %>%
  group_by(virus_group, virus, library_kit, virus_copies)  %>%
  summarize(mean_depth = mean(mean_depth),
            median_depth = mean(median_depth),
            nRPM = mean(nRPM),
            reads_sample = mean(reads_sample),
            reads_virus = mean(reads_virus),
            percent_refseq = mean(percent_refseq),
            percent_refseq_10x = mean(percent_refseq_10x))

# save data
write.table(datas_full2, "output/data.csv", sep = ";", col.names = NA)

##########
# clinical samples
##########

all_files <- list.files("data")

all_csvs <- str_subset(all_files, "csv")

all_csvs <- all_csvs[all_csvs %in% c("fuo_stats.csv", 
                                      "mpx_stats.csv",
                                      "sars_stats.csv")]

virus_names <- lapply(str_split(all_csvs, "_stats.csv"), `[[`, 1)

datas <- lapply(all_csvs,
                function(x) read.csv(paste("data/",x, sep = ""), 
                                     sep = ",",
                                     header = TRUE))

datas[[1]]$virus_spec <- datas[[1]]$Blast_result 
datas[[2]]$virus_spec <- "MPX"
datas[[3]]$virus_spec <- "SARS"


datas2 <- lapply(1:3, function(x) data.frame(datas[[x]],
                                              virus = virus_names[[x]]))



datas_full <- bind_rows(datas2)


datas_full$sample2 <- paste(datas_full$virus_spec,
                    unlist(lapply(str_split(datas_full$sample, "_"), `[[`, 2)),
                    sep = "")
  
datas_full$Ct[is.na(datas_full$Ct)] <- datas_full$virus_copies[is.na(datas_full$Ct)]


# save data
write.table(datas_full, "output/data_clinical.csv", sep = ";", col.names = NA)
