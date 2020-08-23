# Plots data obtained from Stats code

import pandas as pd
import matplotlib.pylab as plt

stats_df = pd.read_csv("investorstats_08Jul2020,1215.csv") # FILE CREATED FROM STATS CODE
projectsjoined_List_inv = stats_df.iloc[1:,9].tolist()
projectsjoined_List_inv = [x for x in projectsjoined_List_inv if str(x) != "nan"]	# remove nan of float type which were blank cells
projectsjoined_List_inv = ", ".join(projectsjoined_List_inv)		# convert series to string
projectsjoined_List_inv = projectsjoined_List_inv.split(", ")	# convert string to list of individual projects

# define dictionary of countries, each country = 0
countries_dict = {"BD":0, "HK":0, "ID":0, "IN":0, "JP":0, "MM":0, "MX":0, "MY":0, "PH":0, "SG":0, "VN":0, "UA":0, "Rest of World":0}

for project in projectsjoined_List_inv:
	projectdetails = project.split("-")
	wrong_countries_count = 0	# track if project is not from any specific country, then classify as Rest of World
	
	for country in countries_dict:
		wrong_countries_count += 1

		if projectdetails[0] == country:
			countries_dict[country] += 1
			wrong_countries_count = 0

		elif wrong_countries_count == len(countries_dict):	# since project does not belong to specific countries, classify Rest of World
			countries_dict["Rest of World"] += 1
			wrong_countries_count = 0
		
print(countries_dict)
#plot_df = pd.DataFrame.from_dict(countries_dict, orient="index", columns=["projectsjoined_inv"])
#plt.plot(plot_df)

keys = countries_dict.keys()
values = countries_dict.values()
plt.bar(keys, values)
plt.show()

#---------REFERENCES----------

# Create Dataframe from Dictionary - https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.from_dict.html
# Plot bar chart using dictionary - https://kite.com/python/answers/how-to-plot-a-bar-chart-using-a-dictionary-in-matplotlib-in-python
