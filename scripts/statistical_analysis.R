# set working directory
RPROJ <- list(PROJHOME = normalizePath(getwd()))
attach(RPROJ)
rm(RPROJ) 
getwd()

# libraries
library(jtools)

#read data
df <- read.table("output/data.csv", sep = ";", header = T)


# models nRPM
mod0 <- glm(log10(nRPM+1)~1, 
            data=df)
mod1 <- glm(log10(nRPM+1)~log10(virus_copies), 
            data=df)
mod2 <- glm(log10(nRPM+1)~log10(virus_copies)+virus, 
            data=df)
mod3 <- glm(log10(nRPM+1)~log10(virus_copies)+virus+library_kit, 
            data=df)
mod4 <- glm(log10(nRPM+1)~log10(virus_copies)+virus+library_kit+
              log10(virus_copies):library_kit, 
            data=df)
mod5 <- glm(log10(nRPM+1)~log10(virus_copies)+virus+library_kit+
              virus:library_kit, 
            data=df)

# likelihood ratio test (e.g. https://api.rpubs.com/tomanderson_34/lrt)
anova(mod3, mod5, test="LRT")
anova(mod3, mod4, test="LRT")
anova(mod2, mod3, test="LRT")
anova(mod1, mod2, test="LRT")
anova(mod0, mod1, test="LRT")

# best model
summ(mod3)


# models mean depth
mod0 <- glm(log10(mean_depth+1)~1, 
            data=df)
mod1 <- glm(log10(mean_depth+1)~log10(virus_copies), 
            data=df)
mod2 <- glm(log10(mean_depth+1)~log10(virus_copies)+virus, 
            data=df)
mod3 <- glm(log10(mean_depth+1)~log10(virus_copies)+virus+library_kit, 
            data=df)
mod4 <- glm(log10(mean_depth+1)~log10(virus_copies)+virus+library_kit+
              log10(virus_copies):library_kit, 
            data=df)
mod5 <- glm(log10(mean_depth+1)~log10(virus_copies)+virus+library_kit+
              virus:library_kit, 
            data=df)

# likelihood ratio test (e.g. https://api.rpubs.com/tomanderson_34/lrt)
anova(mod3, mod5, test="LRT")
anova(mod3, mod4, test="LRT")
anova(mod2, mod3, test="LRT")
anova(mod1, mod2, test="LRT")
anova(mod0, mod1, test="LRT")

# best model
summ(mod3)


## models percent_refseq_10x
mod0 <- glm(percent_refseq_10x/100~1, 
            data=df, family = "binomial")
mod1 <- glm(percent_refseq_10x/100~log10(virus_copies), 
            data=df, family = "binomial")
mod2 <- glm(percent_refseq_10x/100~log10(virus_copies)+virus, 
            data=df, family = "binomial")
mod3 <- glm(percent_refseq_10x/100~log10(virus_copies)+virus+library_kit, 
            data=df, family = "binomial")
mod4 <- glm(percent_refseq_10x/100~log10(virus_copies)+virus+library_kit+
              log10(virus_copies):library_kit, 
            data=df, family = "binomial")
mod5 <- glm(percent_refseq_10x/100~log10(virus_copies)+virus+library_kit+
              virus:library_kit, 
            data=df, family = "binomial")

# likelihood ratio test
anova(mod3, mod5, test="LRT")
anova(mod3, mod4, test="LRT")
anova(mod2, mod3, test="LRT")
anova(mod1, mod2, test="LRT")
anova(mod0, mod1, test="LRT")

# best model
summ(mod2)


#read clinical data
df2 <- read.table("output/data_clinical.csv", sep = ";", header = T)


## models SARS percent_refseq_10x
mod0 <- glm(percent_refseq_10x/100~1, 
            data=subset(df2, virus == "sars"), family = "binomial")
mod1 <- glm(percent_refseq_10x/100~Ct, 
            data=subset(df2, virus == "sars"), family = "binomial")
mod2 <- glm(percent_refseq_10x/100~Ct+library_kit, 
            data=subset(df2, virus == "sars"), family = "binomial")
mod3 <- glm(percent_refseq_10x/100~Ct+library_kit+Ct:library_kit, 
            data=subset(df2, virus == "sars"), family = "binomial")

# likelihood ratio test
anova(mod2, mod3, test="LRT")
anova(mod1, mod2, test="LRT")
anova(mod0, mod1, test="LRT")

# best model
summ(mod1)

## models mpx percent_refseq_10x
mod0 <- glm(percent_refseq_10x/100~1, 
            data=subset(df2, virus == "mpx"), family = "binomial")
mod1 <- glm(percent_refseq_10x/100~Ct, 
            data=subset(df2, virus == "mpx"), family = "binomial")
mod2 <- glm(percent_refseq_10x/100~Ct+library_kit, 
            data=subset(df2, virus == "mpx"), family = "binomial")
mod3 <- glm(percent_refseq_10x/100~Ct+library_kit+Ct:library_kit, 
            data=subset(df2, virus == "mpx"), family = "binomial")

# likelihood ratio test
anova(mod2, mod3, test="LRT")
anova(mod1, mod2, test="LRT")
anova(mod0, mod1, test="LRT")

# best model
summ(mod1)

library(ROCR)


## models  percent_refseq_10x
mod0 <- glm(percent_refseq_10x/100~1, 
            data=subset(df2, virus_spec == "fuo"), family = "binomial")
mod1 <- glm(percent_refseq_10x/100~Ct, 
            data=subset(df2, virus_spec == "fuo"), family = "binomial")
mod2 <- glm(percent_refseq_10x/100~Ct+library_kit, 
            data=subset(df2, virus_spec == "fuo"), family = "binomial")
mod3 <- glm(percent_refseq_10x/100~Ct+library_kit+Ct:library_kit, 
            data=subset(df2, virus_spec == "fuo"), family = "binomial")

# likelihood ratio test
anova(mod2, mod3, test="LRT")
anova(mod1, mod2, test="LRT")
anova(mod0, mod1, test="LRT")

# best model
summ( ) # none

# not important
# models median depth
mod0 <- glm(log10(median_depth+1)~1, 
            data=df)
mod1 <- glm(log10(median_depth+1)~log10(virus_copies), 
            data=df)
mod2 <- glm(log10(median_depth+1)~log10(virus_copies)+virus, 
            data=df)
mod3 <- glm(log10(median_depth+1)~log10(virus_copies)+virus+library_kit, 
            data=df)
mod4 <- glm(log10(median_depth+1)~log10(virus_copies)+virus+library_kit+
              log10(virus_copies):library_kit, 
            data=df)
mod5 <- glm(log10(median_depth+1)~log10(virus_copies)+virus+library_kit+
              virus:library_kit, 
            data=df)

# likelihood ratio test (e.g. https://api.rpubs.com/tomanderson_34/lrt)
anova(mod3, mod5, test="LRT")
anova(mod3, mod4, test="LRT")
anova(mod2, mod3, test="LRT")
anova(mod1, mod2, test="LRT")
anova(mod0, mod1, test="LRT")

# best model
summ(mod3)

# likelihood ratio test (e.g. https://api.rpubs.com/tomanderson_34/lrt)
anova(mod3, mod5, test="LRT")
anova(mod3, mod4, test="LRT")
anova(mod2, mod3, test="LRT")
anova(mod1, mod2, test="LRT")
anova(mod0, mod1, test="LRT")

# best model
summ(mod3)

## models percent_refseq
mod0 <- glm(percent_refseq/100~1, 
            data=df, family = "binomial")
mod1 <- glm(percent_refseq/100~log10(virus_copies), 
            data=df, family = "binomial")
mod2 <- glm(percent_refseq/100~log10(virus_copies)+virus, 
            data=df, family = "binomial")
mod3 <- glm(percent_refseq/100~log10(virus_copies)+virus+library_kit, 
            data=df, family = "binomial")
mod4 <- glm(percent_refseq/100~log10(virus_copies)+virus+library_kit+
              log10(virus_copies):library_kit, 
            data=df, family = "binomial")
mod5 <- glm(percent_refseq/100~log10(virus_copies)+virus+library_kit+
              virus:library_kit, 
            data=df, family = "binomial")

# likelihood ratio test
anova(mod3, mod5, test="LRT")
anova(mod3, mod4, test="LRT")
anova(mod2, mod3, test="LRT")
anova(mod1, mod2, test="LRT")
anova(mod0, mod1, test="LRT")

# best model
summ(mod1)




# models reads_virus
mod0 <- glm(log10(reads_virus+1)~1, 
            data=df)
mod1 <- glm(log10(reads_virus+1)~log10(virus_copies), 
            data=df)
mod2 <- glm(log10(reads_virus+1)~log10(virus_copies)+virus, 
            data=df)
mod3 <- glm(log10(reads_virus+1)~log10(virus_copies)+virus+library_kit, 
            data=df)
mod4 <- glm(log10(reads_virus+1)~log10(virus_copies)+virus+library_kit+
              log10(virus_copies):library_kit, 
            data=df)
mod5 <- glm(log10(reads_virus+1)~log10(virus_copies)+virus+library_kit+
              virus:library_kit, 
            data=df)
