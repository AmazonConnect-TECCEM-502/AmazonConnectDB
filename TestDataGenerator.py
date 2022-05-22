#!/usr/bin/env python
# coding: utf-8

# In[1]:


import uuid
import random
import string
import datetime


# In[4]:


#User
delimiter = ";"
N = 50

def randEmail(): 
    x = ''.join(random.choice(string.ascii_letters) for _ in range(7))
    return x + '@aws.com'
    
def generateUsers():
    tableName = 'User'
    colnames = ['user_id','fname','lname','email','user_type','manager_id','cognito_uuid']
    id_max = 50
    mid_max = 5
    fnames = ['Eric','Joan','Vol','Ferro','Javier','Omar','Renata','Fernanda','Roberto','Emilio']
    lnames = ['Cruz','Guerrero','Sanchez','Ferro','Sorchini','Moreno','Valdez','Barragan','Luna','Rivers']
    user_type = ['agent','admin']
    
    with open('users.csv', 'w') as f:
        f.write(delimiter.join(colnames)+"\n")
        for i in range(mid_max):
            entry = str(i) + delimiter
            entry += random.choice(fnames) + delimiter
            entry += random.choice(lnames) + delimiter
            entry += randEmail() + delimiter
            entry += 'manager' + delimiter
            entry += str(i) + delimiter
            entry += str(uuid.uuid4()) + "\n"
            f.write(entry)
        
        for i in range(mid_max, N):
            entry = str(i) + delimiter
            entry += random.choice(fnames) + delimiter
            entry += random.choice(lnames) + delimiter
            entry += randEmail() + delimiter
            entry += random.choice(user_type) + delimiter
            entry += str(random.randint(0, mid_max)) + delimiter
            entry += str(uuid.uuid4()) + "\n"
            f.write(entry)

    
generateUsers()


# In[3]:


#Call
delimiter = ","
N = 50

def randUrl():
    x = ''.join(random.choice(string.ascii_letters) for _ in range(20))
    return 'https://' + x + '.com'
    
def generateCalls():
    tableName = 'Call'
    colnames = ['call_id','agent_id','client_id','created','duration','video_url','transcription_url','rating']
    aid_max = 50
    cid_max = 50
    max_duration = 1800 #in seconds
    min_rating = 0
    max_rating = 5
    
    with open('calls.csv', 'w') as f:
        f.write(delimiter.join(colnames)+"\n")
        for i in range(N):
            entry = str(i) + delimiter
            entry += str(random.randint(0,aid_max-1)) + delimiter
            entry += str(random.randint(0,cid_max-1)) + delimiter
            entry += str(datetime.datetime.now()) + delimiter
            entry += str(random.randint(1,max_duration*100) / 100) + delimiter
            entry += randUrl() + delimiter
            entry += randUrl() + delimiter
            entry += str(random.randint(0,5)) + "\n"
            f.write(entry)
            
generateCalls()


# In[4]:


#Problem
N = 50
delimiter = ','

def randProblem():
    x = ''.join(random.choice(string.ascii_letters) for _ in range(7))
    return 'No sirve el ' + x

def generateProblems():
    tablename = 'Problem'
    colnames = ['problem_id','problem_description','submitted_by','created']
    uid_max = 50
    with open('problems.csv','w') as f:
        f.write(delimiter.join(colnames)+"\n")
        for i in range(N):
            entry = str(i) + delimiter
            entry += randProblem() + delimiter
            entry += str(random.randint(0,uid_max-1)) + delimiter
            entry += str(datetime.datetime.now()) + '\n'
            f.write(entry)
            
generateProblems()


# In[5]:


#Problem category
N = 7
delimiter = ','

def randProblemCategory():
    return ''.join(random.choice(string.ascii_letters) for _ in range(50))

def generateProblemCategories():
    tablename = 'problem_category'
    colnames = ['category_id','category_name','category_description']
    category_name = ['Internet infrastructure','Telephone infrastructure','Entertainment services','Internet services','Telephone services','Internet connectivity','Security services']
    with open('problem_categories.csv','w') as f:
        f.write(delimiter.join(colnames)+"\n")
        for i in range(N):
            entry = str(i) + delimiter
            entry += category_name[i] + delimiter
            entry += randProblemCategory() + '\n'
            f.write(entry)
        
generateProblemCategories()


# In[1]:


#Solution
delimiter = ","
N = 50
    
def generateSolutions():
    tableName = 'User'
    colnames = ['solution_id','solution_description','submitted_id','problem_id','approved_by','approved','approved_date','created']
    uid_max = 50
    pid_max = 50
    mid_max = 5
    
    with open('solutions.csv', 'w') as f:
        f.write(delimiter.join(colnames)+"\n")
        for i in range(N):
            entry = str(i) + delimiter
            entry += 'Solution ' + str(i) + delimiter
            entry += str(random.randint(0,uid_max)) + delimiter
            entry += str(random.randint(0,pid_max)) + delimiter
            entry += str(random.randint(0,mid_max)) + delimiter
            entry += str(random.choice([0,1])) + delimiter
            entry += str(datetime.datetime.now()) + delimiter
            entry += str(datetime.datetime.now()) + '\n'
            f.write(entry)

    
generateSolutions()


# In[6]:


#call-problem
delimiter = ","
N = 50
    
def generateSolutions():
    tableName = 'call-problem'
    colnames = ['call_problem','call_id','problem_id']
    uid_max = 50
    cid_max = 50
    pid_max = 50
    
    with open('call_problem.csv', 'w') as f:
        f.write(delimiter.join(colnames)+"\n")
        for i in range(N):
            entry = str(i) + delimiter
            entry += str(random.randint(0,cid_max)) + delimiter
            entry += str(random.randint(0,pid_max)) + '\n'
            f.write(entry)
            
generateSolutions()


# In[7]:


delimiter = ","
N = 50
#category_problem
def generateSolutions():
    tableName = 'call-problem'
    colnames = ['category_problem','category_id','problem_id']
    uid_max = 50
    cid_max = 7
    pid_max = 50
    
    with open('category_problem.csv', 'w') as f:
        f.write(delimiter.join(colnames)+"\n")
        for i in range(N):
            entry = str(i) + delimiter
            entry += str(random.randint(1,cid_max)) + delimiter
            entry += str(random.randint(0,pid_max)) + '\n'
            f.write(entry)
            
            
generateSolutions()

