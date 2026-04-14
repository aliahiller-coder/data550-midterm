#render the final html report
rsv_report.html: code/04_render_report.R rsv_report.Rmd output/00_load_data.rds \
  output/01_table1.rds output/02_scatterplot1.png output/03_scatterplot2.png
	Rscript code/04_render_report.R

#make the clean data file for analysis. the Rscript will clean the raw data file \
from canvas#
output/00_load_data.rds: code/00_load_data.R data/rsv_ga_data.csv
	Rscript code/00_load_data.R

#make table 1 for descriptive analysis of RSV data
output/01_table1.rds: code/01_table1.R output/00_load_data.rds
	Rscript code/01_table1.R

#make scatterplot 1
output/02_scatterplot1.png: code/02_scatterplot1.R output/00_load_data.rds
	Rscript code/02_scatterplot1.R

#make scatterplot 2
output/03_scatterplot2.png: code/03_scatterplot2.R output/00_load_data.rds
	Rscript code/03_scatterplot2.R

.PHONY: clean
clean:
	rm output/*