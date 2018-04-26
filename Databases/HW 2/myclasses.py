"""
Remy Lagrois
MSDS 7330 Section 402
HW 2
"""

#My current classes
myClasses = {'MSDS7330':'Databases', 'MSDS6371':'Experimental Statistics 1'}

#adds classes to myClasses
def add_course(num, name):
    myClasses[num] = name
    print myClasses
    
