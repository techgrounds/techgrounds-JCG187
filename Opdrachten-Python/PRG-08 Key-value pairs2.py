
"""
#import csv module
import csv

#data rows for dictionary
my_dict=[{"first name": "" "last name": , "job title": , "company":  }]

#field names
fields = "first name", "last name", "job title", "company"

#name of csv file
filename = "work_records.scv"

#get input for dictionary
first_name=input("What is your first name?: ")
last_name=input("What is your last name?: ")
job_title=input("What is your job title?: ")
company=input("Where do you work?: ")


work_dictionary = {
    "first name":   first_name,
    "last name":    last_name,
    "job title":    job_title,
    "company":      company
}

print(work_dictionary)

"""

#import csv module
import csv

#data rows for dictionary
work_dictionary={"first-name": ["Jennifer", "Jorn", "Joyce", "Jonathan"],
                 "last_name": ["Govaart", "Graaf", "Gemert", "Goosens"],
                 "job_title": ["network engineer", "bakker", "teacher", "trein machinist"],
                 "company": ["ThisisIT", "bakker Bart", "Groenhorst college", "NS"]}
                                 

#field names
fields = "first-name", "last-name", "job-title", "company"

#name of csv file
filename = "werk.csv"

#writing to scv file
with open("werk.csv","a", "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerow(work_dictionary.keys())
    for iteration in range(len(work_dictionary.keys())):
       writer.writerow ([val[iteration] for val in work_dictionary.values()]) 


#get input for work_dictionary
first_name=input("What is your first name?: ")
last_name=input("What is your last name?: ")
job_title=input("What is your job title?: ")
company=input("Where do you work?: ")


work_dictionary = {
    "first name":   first_name,
    "last name":    last_name,
    "job title":    job_title,
    "company":      company
}
