"""
NOTE: You must have Python Twitter Toolbox (https://github.com/sixohsix/twitter)
installed on the machine running this script. You can install it using
setuptools/easy_install (https://pypi.python.org/pypi/setuptools)

Run this on the command line:

	  			easy_install twitter
"""

import tweepy
import csv, json
import time
import ast
# Twitter OAuth Credentials
# Get these be creating a new Twitter app on https://apps.twitter.com/app/new, and look
# under "Keys and Access Tokens" (https://apps.twitter.com/app/[you-twitter-app-id]/keys)


#ENTER YOUR own credentials here!
consumer_key = "LLN3ZfSD2fAgygzqTI6jcdDG2" #Consumer Key (API Key)
consumer_secret = "aDnfh9QHSuyxDGPHk3VG1GamgkP4LW0NcwXOgigNYajQmn27hl" #Consumer Secret (API Secret)
access_token = "4063510511-bcOvGavZlXeq2LeyjfwCUzezV2onrTXwprDjwxV" #Access Token
access_secret = "ukAdn2L60VJKfgu3ivZ3i5TNyrLH5FIoBm7nliZZ90zut" #Access Token Secret
#

auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_secret)
api = tweepy.API(auth)

# EDIT - Make YOUR filename containing Tweet IDS
inputpath = "manuja.csv"


# Function
def extract(i,tweetspath):
    with open(inputpath, 'rb') as inputfile:
        j = 1
        counter = 0
        for line in inputfile:
            if j<=i:
                j = j + 1
                continue
            if counter==150:
                print "150 lines reached"
                break
            try:
                data = api.statuses_lookup(id_=line.split(","),include_entities=True)
                j = j+1
                counter = counter +1
                for status in data:
                    with open(tweetspath, 'a') as f:
                        f.write(json.dumps(status._json))
                        f.write("\n")
            except:  # Should something not work (blank line, only deleted tweets in line)
                print "error in line " + str(j)
                break


# Actual Loop execution to create batches of files
loop = 1
i = 1
filenum = 1
path = "outputmanuja"
while loop<=10:
    try:
        tweetspath = path+str(filenum)+".json"
        filenum = filenum+1

        print "before extraction, loop:" + str(loop)
        loop = loop + 1
        print "i = "+str(i)
        print "path = " + tweetspath
        extract(i,tweetspath)
        print "after extraction, loop:" + str(loop)
        time.sleep(60*62)
        i = i+150

    except tweepy.TweepError:
        time.sleep(60 * 15)
        continue
