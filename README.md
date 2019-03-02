# INFO 370 Final Project Proposal
#### Group 3: Grant Suyama, Kathy Chiu, Kevin Lim, Eshin Ang
#### 28 February 2019

## Project Description
__What is the overarching purpose of your research project, and why is it an important undertaking?__
* The purpose of our research project is  to investigate the relationship between student’s use of Virtual Learning Environment (VLE) and their learning performance
* It is an important undertaking as it would allow us to examine the influence and effectiveness of VLE as an educational, web-based platform for universities and students

__How does your research fit into the broader problem domain? You should cite at least 3 papers that help contextualize your research.__  
* Do VLE’s have actual pedagogical effects? (https://telearn.archives-ouvertes.fr/hal-00190701/document)
* Factors that Influence Students' Decision to Dropout of Online Courses (https://eric.ed.gov/?id=EJ862360)
* Early Prediction of Student Success: Mining Students Enrolment Data (https://pdfs.semanticscholar.org/e48e/ba98bde33586c20442d46ab9a59c411196e5.pdf)
* Advantages and disadvantages of adopting e-learning in higher education (http://itdl.org/Journal/Jan_15/Jan15.pdf#page=33)

__What specific hypothesis (hypotheses) are you going to test?__
__Our Research Questions:__
* Does a student background affect the likelihood of the student passing an online course?
* _How does a student interaction with the online courses (i.e. how often do they log in, what resources do they access?) affect their grades?
* What are the factors that indicate success among people using VLE?
* What are the factors that affect the educational effect of VLE?
* What are the factors that cause people to withdraw from a course?
* Who is most disadvantaged when attempting VLE classes?
__Our Hypothesis:__
* There is a relationship between a student’s online learning behavior (interaction with VLE) and demographics and their performance in VLE.

__What are the datasets you'll be working with to answer this question? Please include relevant background describing the datasets you identify.__
* Open University Learning Analytics dataset (https://analyse.kmi.open.ac.uk/open_dataset) 
* The dataset features demographic information about 28,000+ students who, in 2013 and 2014, enrolled in any of seven particular distance learning courses at the UK’s Open University; their final results (distinction, pass, fail, or withdrawn); 173,000+ graded assignments; and 10+ million rows describing each student’s interactions with the courses.

__What statistical and machine learning methods do you plan on using to test your hypothesis?__
* Multiclass classification (random forest)
* Multinomial Logistic Regression

__Who is your target audience for the resource you will build? Depending on the domain of your data, there may be a variety of audiences interested in using the dataset. You should hone in on one of these audiences.__
* Potential Open University students who are considering VLEs (as opposed to the conventional university/college setting)
* Academic institutions, in particular, Open University
* Students who are considering taking courses in VLE in general
* Course instructors who teach online courses

__What should your audience learn from your resource? Consider specific questions they may want to answer.__
* Provide insights for potential future Open University students or any students in general on the effectiveness of VLE and whether or not the students would be compatible with VLEs
* Provide academic institutions the indicators that may affect a student’s performance while using VLE
* Give course instructors a better understanding of a students learning processes and behaviors to help them improve the existing course format

## Technical Description

__What will be the format of your final web resource (Shiny app, HTML page or slideshow compiled with KnitR, etc.)?__
* HTML notebook

__Do you anticipate any specific data collection/data management challenges?__
* All the data should be there but the only potential issue would be joining the multiple CSV files

__What new technical skills will need to learn in order to complete your project?__
* New machine learning/statistical modeling methods such as multinomial logistic regression and multiclass classification and learn how to interpret and improve our models

__How will you conduct your analysis? Please include a detailed description of your intended modeling approach.__
* Step 1: Data preprocessing, data wrangling
* Step 2: Exploratory data analysis
* Step 3: Implement Multinomial Logistic Regression using sklearn
* Step 4: Visualize and interpret results
* Step 5: Predict outcome (whether a student would pass/fail) with models

__What major challenges do you anticipate?__
* Joining and cleaning the data
* Using a dataset of this large size
* Working with 4 teammates on GitHub
* Figuring out what to use for R or Python



