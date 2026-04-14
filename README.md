# RSV Wastewater Surveillance in Georgia
DATA550 Midterm Project

Group Members: Imani Allen, Linda Bueno Cinto, Alia Hiller, McKenzie Reese

## Context

Respiratory syncytial virus (RSV) is a common respiratory virus. It does not 
usually cause severe illness in healthy adults and children. However, some people
with RSV infection, especially infants younger than 6 months of age and adults who
are older or have certain risk factors, can become very sick and may need to be hospitalized.^1^
Wastewater monitoring can detect viruses spreading from one person to another
within a community earlier than clinical testing and before people who are sick
go to their doctor or hospital. It can also detect infections without symptoms.^2^
If you see increased wastewater viral activity levels, it might indicate that there is a higher risk of infection,
which can inform local public health response.

**Sources**

1. https://www.cdc.gov/nwss/rv/RSV-national-data.html
2. https://www.cdc.gov/rsv/about/index.html


## Analysis Description

Data from this analysis is RSV wastewater surveillance from CDC subsetted to the state of Georgia.
This analysis aims to:

1. Provide descriptive analysis of county wastewater data 
2. Examine how RSV concentration in wastewater changes over time
3. Analyze the relationship between a facility’s flow rate and the population served

The final product is a fully reproducible html report that can be built from the command line using `make`.

## Repository Contents

* `data/` - Contains the csv file for analysis
* `code/` - Scripts to clean data, create table 1, scatterplot 1, and scatterplot 2
* `output/` - Generated .Rds and .png files
* `config.yml` - Customizes report based on configuration
* `Makefile` - Automates building the final report and manages outputs
* `rsv_report.Rmd` - Final report 

## Instructions to Locally Build the Report
To locally build the report from the command line:

1. Navigate to the project's directory (`midterm/`)
2. Run the `make` command. Under the hood, `make` is:
    * Loading and cleaning the data (`code/00_load_data.R` --> `output/00_load_data.rds`)
    * Identifying report configuration (`config.yml`)
      * county: Changes the county of interest for table 1 and scatterplot 1
      * time: Changes the date/time period of interest for scatterplot 1
      * facility: Changes the wastewater surveillance facility of interest for scatterplot 2
    * Generating table 1 (`code/01_table1.R` --> `output/01_table1.rds`)
    * Generating scatterplot 1 (`code/02_scatterplot1.R` --> `output/02_scatterplot1.png`)
    * Generating scatterplot 2 (`code/03_scatterplot2.R` --> `output/03_scatterplot2.png`)
    * Rendering the final report (`code/04_render_report.R` --> `rsv_report.Rmd`)
3. The final .html report will generate!

**Note**: To remove contents of the `output/` directory, run `make clean` from the command line.
