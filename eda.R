#Exploratory Data Analysis
source("dataprep.R")
library(ggplot2)
library(reshape2)

# Bar chart: Distribution of final result of students (Module CCC October 2014)
result_bar<- ggplot(data, aes(final_result)) +
  geom_bar(fill = "steelblue1") +
  xlab("Final result") + 
  ylab("Total number of students") +
  ggtitle("Distribution of final result of students (Module CCC October 2014)")

# reorder age band by levels
data$age_band <- factor(data$age_band,levels(data$age_band)[c(2, 3, 1)])

# Bar chart: Distribution of final result of students by age band (Module CCC October 2014)
result_ageband_bar <- ggplot(data, aes(x= final_result,  group=age_band)) + 
  geom_bar(aes(y = ..prop.., fill = factor(..x..)), stat="count") +
  geom_text(aes( label = scales::percent(..prop..),
                 y= ..prop.. ), stat= "count", vjust = -.5) +
  labs(y = "Percent", fill="result") +
  facet_grid(~age_band) +
  scale_y_continuous(labels = scales::percent) + 
  ggtitle("Distribution of final result of students by age band (Module CCC October 2014)")

# reorder highest education by levels
data$highest_education <- factor(data$highest_education,levels(data$highest_education)[c(5, 4, 2, 1, 3)])

# Bar chart: Distribution of final result of students by highest education (Module CCC October 2014)
result_education_bar <- ggplot(data, aes(x= final_result,  group=highest_education)) + 
  geom_bar(aes(y = ..prop.., fill = factor(..x..)), stat="count") +
  geom_text(aes( label = scales::percent(..prop..),
                 y= ..prop.. ), stat= "count", vjust = -.5) +
  labs(y = "Percent", fill="result") +
  facet_grid(~highest_education) +
  scale_y_continuous(labels = scales::percent) + 
  ggtitle("Distribution of final result of students by highest education (Module CCC October 2014)")

# Boxplot: Distribution of student assessment score by final result (Module CCC October 2014)
exam_boxplot <- ggplot(data) +
  aes(x = final_result, y = exam_score) + 
  geom_boxplot() +
  xlab("Final result") + 
  ylab("Exam score (%)") + 
  ggtitle("Distribution of student exam score by final result (Module CCC October 2014)")

# Bar chart: Distribution of final result of students by activity type (Module CCC October 2014)
activity_df <- melt(data[, c(9, 12:20)], id.vars='final_result')
activity_bar <- ggplot(activity_df, aes(x=final_result, y=value, fill=variable)) + 
  geom_bar(stat='identity', position='dodge') +
  xlab("Final result") +
  ylab("Total number of clicks") +
  ggtitle("Distribution of final result of students by activity type (Module CCC October 2014)")
