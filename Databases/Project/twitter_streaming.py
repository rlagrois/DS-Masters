#Import the necessary methods from tweepy library
from tweepy.streaming import StreamListener
from tweepy import OAuthHandler
from tweepy import Stream
import json
import csv

#Variables that contains the user credentials to access Twitter API 
access_token = "3908160914-fwXTnPSMms7FV7qPMZH7OkdotCSSNutY8l7Lsmj"
access_token_secret = "ibGqqopcC8qWHx20ANqpSGmnKWmye2fkq9TH9lpJfCMF7"
consumer_key = "sIiFNJ2R6aY4vkz7T5i7YGOVy"
consumer_secret = "ZPIq5NvMnx9xI17nL44C9AG3F7GmFfmz3cJVysuZXYI78hDcDW"


#This is a basic listener 
class StdOutListener(StreamListener):  
    
    def on_data(self, data):        
        
        all_data = json.loads(data)        
        tweet = all_data["text"]        
        username = all_data["user"]["screen_name"]
        t_date = all_data["created_at"]
                
        row = (
            all_data['id'],                    # tweet_id
            all_data['created_at'],            # tweet_time
            all_data['user']['screen_name'],   # tweet_author
            all_data['user']['id_str'],        # tweet_authod_id
            all_data['lang'],                  # tweet_language         
            all_data['text']                   # tweet_text
        )
        values = [(value.encode('utf8') if hasattr(value, 'encode') else value) for value in row]
        c.writerow(values)  
  
    
        print((username,t_date,tweet)) 
        return True

    def on_error(self, status):
        print status

if __name__ == '__main__':

    #This handles Twitter authetification and the connection to Twitter Streaming API
    l = StdOutListener()
    auth = OAuthHandler(consumer_key, consumer_secret)
    auth.set_access_token(access_token, access_token_secret)
    stream = Stream(auth, l)
    
    c = csv.writer(open("Twitter_Forex_Data.csv", "wb"))    

    #This line filter Twitter Streams to capture data by the keywords: 'python', 'javascript', 'ruby'
    stream.filter(track=['EUR/USD'])

