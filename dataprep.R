#Data Preparation
library(dplyr)
library(data.table)

#read files
assessment <- read.csv("data_CCC_2014J/assessments_CCC_2014J.csv", stringsAsFactors=FALSE)
studentAssessment <- read.csv("data_CCC_2014J/studentAssessment_CCC_2014J.csv", stringsAsFactors=FALSE)
studentInfo <- read.csv("data_CCC_2014J/studentInfo_CCC_2014J.csv", stringsAsFactors=FALSE)
studentVle <- read.csv("data_CCC_2014J/studentVle_CCC_2014J.csv", stringsAsFactors=FALSE)
vle <- read.csv("data_CCC_2014J/vle_CCC_2014J.csv", stringsAsFactors=FALSE)
studentRegistration <- read.csv("data_CCC_2014J/studentRegistration_CCC_2014J.csv", stringsAsFactors=FALSE)

# fill blank imd_band with NA
studentInfo$imd_band <- gsub("^$", "NA", studentInfo$imd_band)

# rename age_band of 55<= to >=55
studentInfo$age_band <- gsub("55<=", ">=55", studentInfo$age_band, fixed=TRUE)

# select 'id_assessment' and 'weight' columns from assessment
new_assessment <- assessment[, c(3,6)]

# merge studentAssessment with new_assessment
new_student_assessment <- merge(studentAssessment, new_assessment, by='id_assessment')

# compute weighted score for each student
new_student_assessment$weighted_score <- (new_student_assessment$score * new_student_assessment$weight) / 100

# make each assessment weighted score as a column
assessments_weighted_score <- dcast(new_student_assessment, id_student ~ id_assessment, value.var='weighted_score')

# fill NA of assessments with 0
assessments_weighted_score[is.na(assessments_weighted_score)] <- 0

# compute sum for Tutor Marked Assessment (TMA) and computer marked Assessment (CMA)
assessments_weighted_score$assessment_score <- rowSums(assessments_weighted_score[, c(2:9)])

# rename id_assessment '24299' as 'exam'
colnames(assessments_weighted_score)[colnames(assessments_weighted_score)=="24299"] <- "exam_score"

# select 'id_student', assessment' and 'exam' columns
all_scores <- assessments_weighted_score[, c(1, 10, 11)]

# merge all_scores with studentInfo
studentInfo_scores <- merge(studentInfo, all_scores, by= 'id_student')

# merge studentVle with vle
new_student_vle <- merge(studentVle, vle, by='id_site')
new_student_vle <- new_student_vle %>%
  group_by(id_student, activity_type) %>%
  summarize(sum = sum(sum_click))

# make each activity_type as a column
activity_clicks <- dcast(new_student_vle, id_student ~ activity_type, value.var='sum')

# fill NA of activity clicks with 0
activity_clicks[is.na(activity_clicks)] <- 0

# merge activity_clicks with studentInfo
studentInfo_activity_clicks <- merge(studentInfo_scores, activity_clicks, by= 'id_student')

# fill NA of data_unregistration as 269 days (total days of course)
# meaning that the student stay throughout the course without withdrawing
studentRegistration$date_unregistration[is.na(studentRegistration$date_unregistration)] <- 269

# select 'id_student', 'date_registration' and 'date_unregistration' columns
new_studentRegistration = studentRegistration[, c(3:5)]

# merge new_studentRegistration with studentInfo
data <- merge(studentInfo_activity_clicks, new_studentRegistration, by= 'id_student')
data <- data[, c(4:25)]

# make categorical columns as factor
data[, c(1:6, 8, 9)] <- lapply(data[, c(1:6, 8, 9)], factor)

# data_2: drop Withdrawn as an outcome
# this dataset will not contain students that withdrawn
data_2 <- merge(studentInfo_activity_clicks, new_studentRegistration, by= 'id_student')
data_2 <- data_2[, c(4:25)]
data_2 <- data_2[!grepl("Withdrawn", data$final_result),]
data_2[, c(1:6, 8, 9)] <- lapply(data_2[, c(1:6, 8, 9)], factor)

# data_pass: make final_result a binary outcome of Pass vs Fail
# this dataset is used to predict students who pass vs students who do 
data_pass <- merge(studentInfo_activity_clicks, new_studentRegistration, by= 'id_student')
data_pass <- data_pass[, c(4:25)]
data_pass <- data_pass[!grepl("Withdrawn", data_pass$final_result),]
data_pass$final_result[data_pass$final_result=="Distinction"] <- "Pass"
data_pass[, c(1:6, 8, 9)] <- lapply(data_pass[, c(1:6, 8, 9)], factor)

# data_distinction: make final_result a binary outcome of Distinction vs Not Distinction
# this dataset is used to predict students who receive distinction vs student who did not receive distinction
data_dist <- merge(studentInfo_activity_clicks, new_studentRegistration, by= 'id_student')
data_dist<- data_dist[, c(4:25)]
data_dist <- data_dist[!grepl("Withdrawn", data_dist$final_result),]
data_dist$final_result[data_dist$final_result=="Pass"] <- "NotDistinction"
data_dist$final_result[data_dist$final_result=="Fail"] <- "NotDistinction"
data_dist[, c(1:6, 8, 9)] <- lapply(data_dist[, c(1:6, 8, 9)], factor)