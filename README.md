# Data Warehouse of the immigration data of the United States
### Data Engineering Capstone Project

#### Project Summary
To build a data warehouse on the immigration data of the United States.

The project follows the follow steps:
* Step 1: Scope the Project and Gather Data
* Step 2: Explore and Assess the Data
* Step 3: Define the Data Model
* Step 4: Run ETL to Model the Data
* Step 5: Complete Project Write Up

### Step 1: Scope the Project and Gather Data

#### Scope 
*Explain what you plan to do in the project in more detail. What data do you use? What is your end solution look like? What tools did you use? etc*

I plan to build a data warehouse on AWS, the end use cases I would like to prepare the data for are analytic tables.
The main dataset will include data on immigration to the United States, and supplementary datasets will include data on airport codes, U.S. city demographics, and temperature data.

#### Describe and Gather Data 
Describe the data sets you're using. Where did it come from? What type of information is included? 
- **I94 Immigration Data:** This data comes from the US National Tourism and Trade Office. It contains international visitor arrival statistics by world regions and select countries (including top 20), type of visa, mode of transportation, age groups, states visited (first intended address only), and the top ports of entry (for select countries). [This](https://travel.trade.gov/research/reports/i94/historical/2016.html) is where the data comes from. The 12 datasets have got more than 40 million rows (40,790,529) and 28 columns. For most of the work we used only the month of April of 2016 which has more than three million records (3,096,313).

##### Data Dictionary
Column Name|Description
---|---
CICID*|ID that uniquely identify one record in the dataset
I94YR|4 digit year
I94MON|Numeric month
I94CIT|3 digit code of source city for immigration (Born country)
I94RES|3 digit code of source country for immigration (Residence country)
I94PORT|Port addmitted through
ARRDATE|Arrival date in the USA
I94MODE|Mode of transportation (1 = Air; 2 = Sea; 3 = Land; 9 = Not reported)
I94ADDR|State of arrival
DEPDATE|Departure date
I94BIR|Age of Respondent in Years
I94VISA|Visa codes collapsed into three categories: (1 = Business; 2 = Pleasure; 3 = Student)
COUNT|Used for summary statistics
DTADFILE|Character Date Field
VISAPOST|Department of State where where Visa was issued
OCCUP|Occupation that will be performed in U.S.
ENTDEPA|Arrival Flag. Whether admitted or paroled into the US
ENTDEPD|Departure Flag. Whether departed, lost visa, or deceased
ENTDEPU|Update Flag. Update of visa, either apprehended, overstayed, or updated to PR
MATFLAG|Match flag
BIRYEAR|4 digit year of birth
DTADDTO|Character date field to when admitted in the US
GENDER|Gender
INSNUM|INS number
AIRLINE|Airline used to arrive in U.S.
ADMNUM|Admission number, should be unique and not nullable
FLTNO|Flight number of Airline used to arrive in U.S.
VISATYPE|Class of admission legally admitting the non-immigrant to temporarily stay in U.S.

- **U.S. City Demographic Data:** This dataset contains information about the demographics of all US cities and census-designated places with a population greater or equal to 65,000 from the US Census Bureau's 2015 American Community Survey. You can read more about it [here](https://public.opendatasoft.com/explore/dataset/us-cities-demographics/export/). 

### Step 2: Explore and Assess the Data
#### Explore the Data 
Identify data quality issues, like missing values, duplicate data, etc.

- #### I94 Immigration Data
i94mode, i94bir, dtadfile, visapost, occup, entdepa, entdepd, entdepu, matflag, biryear, dtaddto, gender, insnum, airline, fltno have missing data. We will drop all these columns. We keep i94addr and depdate because we are interested in those data.

Columns we will keep:
- cicid, i94yr, i94mon, i94cit, i94res, i94port, arrdate, i94addr, depdate, i94visa, count, admnum, visatype

- #### U.S. City Demographic Data
Male Population, Female Population, Number of Veterans, Foreign-born, Average Household Size in U.S. City Demographic Data have missing values. We only interested in Total Population of the states.

#### Cleaning Steps
Document steps necessary to clean the data

- #### I94 Immigration Data
We select the relevant columns and remove the missing values.

- #### U.S. City Demographic Data
We select the relevant columns and drop the duplicates.

### Step 3: Define the Data Model
#### 3.1 Conceptual Data Model
Map out the conceptual data model and explain why you chose that model

We chose star schema and select immigration data as fact while time and state are dimension.
Using this model, we can easily aggregate our immigration data based on month or year and also by different states.

**Fact Table**

`immigration` 
- **cicid***, i94yr, i94mon, i94cit, i94res, i94port, arrdate, i94addr, depdate, i94visa, count, admnum, visatype

**Dimension Tables**

`time` - arrival and departure date in immigration broken down into specific units 
- **sas_date***, date, day, month, year, weekday

`state` - total population of the states
- **state_code***, state, total_population

#### 3.2 Mapping Out Data Pipelines
List the steps necessary to pipeline the data into the chosen data model

### Step 4: Run Pipelines to Model the Data 
#### 4.1 Create the data model
Build the data pipelines to create the data model.

#### 4.2 Data Quality Checks
Explain the data quality checks you'll perform to ensure the pipeline ran as expected. These could include:
 * Integrity constraints on the relational database (e.g., unique key, data type, etc.)
 * Unit tests for the scripts to ensure they are doing the right thing
 * Source/Count checks to ensure completeness
 
Run Quality Checks

#### 4.3 Data dictionary 
Create a data dictionary for your data model. For each field, provide a brief description of what the data is and where it came from. You can include the data dictionary in the notebook or in a separate file.

##### Data Dictionary
#### Immigration
Column Name|Description
---|---
CICID*|ID that uniquely identify one record in the dataset
I94YR|4 digit year
I94MON|Numeric month
I94CIT|3 digit code of source city for immigration (Born country)
I94RES|3 digit code of source country for immigration (Residence country)
I94PORT|Port addmitted through
ARRDATE|Arrival date in the USA
I94MODE|Mode of transportation (1 = Air; 2 = Sea; 3 = Land; 9 = Not reported)
I94ADDR|State of arrival
DEPDATE|Departure date
I94BIR|Age of Respondent in Years
I94VISA|Visa codes collapsed into three categories: (1 = Business; 2 = Pleasure; 3 = Student)
COUNT|Used for summary statistics
DTADFILE|Character Date Field
VISAPOST|Department of State where where Visa was issued
OCCUP|Occupation that will be performed in U.S.
ENTDEPA|Arrival Flag. Whether admitted or paroled into the US
ENTDEPD|Departure Flag. Whether departed, lost visa, or deceased
ENTDEPU|Update Flag. Update of visa, either apprehended, overstayed, or updated to PR
MATFLAG|Match flag
BIRYEAR|4 digit year of birth
DTADDTO|Character date field to when admitted in the US
GENDER|Gender
INSNUM|INS number
AIRLINE|Airline used to arrive in U.S.
ADMNUM|Admission number, should be unique and not nullable
FLTNO|Flight number of Airline used to arrive in U.S.
VISATYPE|Class of admission legally admitting the non-immigrant to temporarily stay in U.S.

#### Step 5: Complete Project Write Up
* Clearly state the rationale for the choice of tools and technologies for the project.

 We use a library called [pandas-redshift](https://github.com/agawronski/pandas_redshift), which is designed to make it easier to get data from redshift into a pandas DataFrame and vice versa. It transfers the data frame to S3 and then to Redshift.

* Propose how often the data should be updated and why.
 
 For I94 Immigration Data, it depends how often the immigration authorities update the data. 
 
 For U.S. City Demographic Data, the data will be updated when there is another survey held by the US Census Bureau.
* Write a description of how you would approach the problem differently under the following scenarios:
 * The data was increased by 100x.
 
 If the data was increased by 100x, pure pandas cannot handle it. We will need Spark to handle it.
 * The data populates a dashboard that must be updated on a daily basis by 7am every day.
 
 We can use Airflow to schedule a pipeline that run every day before 7am.
 * The database needed to be accessed by 100+ people.
 
 Redshift has the ability to be scalable, our current technology stack can support that.
