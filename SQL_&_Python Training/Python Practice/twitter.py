import json
import csv
import tweepy
import re
import io

# Enter your twitter credentials here
consumer_key ='VAVkKWee0BAqgeFvwRPs4ojSs'
consumer_secret ='pyqoI8SeIHJLzuthzyCddbHdlNDpSCJmGbpnh8BtXFjIie9FGK'
access_token ='315668122-03roWCZxw7N8sapGKYpLg2ikZmBXNrNiw7ytK4CG' 
access_token_secret ='1EPpO0bbDmxh9oLqJaBltiBbyyzItyYQNrqE5kiUZtmzs'

def create_dataset(consumer_key, consumer_secret, access_token, access_token_secret):
    
    # Twitter authentication and the connection to Twitter API
    auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
    auth.set_access_token(access_token, access_token_secret)
    
    # Initializing Tweepy API
    api = tweepy.API(auth, wait_on_rate_limit=True)
    
    # Name of csv file to be created
    
        
    fname = "Kerendia_data"
    
    # Open the spreadsheet
    with open('%s.csv' % (fname), 'w', encoding="utf-8",newline='') as file:
        w = csv.writer(file)
        
        # Write header row (feature column names of your choice)
        w.writerow(['timestamp', 'tweet_text', 'username', 'all_hashtags', 'location', 
                    'followers_count', 'retweet_count', 'favorite_count'])
        
        hashtag_phrase= ["Kerendia","Finerenone","Mineralocorticoid receptor antagonist","Antimineralocorticoid","Aldosterone antagonist","MRA antagonist",
                         "Non-steroidal mineralocorticoid receptor antagonist","Non-steroidal MRA","FIDELIO-DKD",
                         "Fidelio-Dkd","FIGARO-DKD","Figaro-Dkd" ]
        for drug_name in hashtag_phrase:
        # For each tweet matching hashtag, write relevant info to the spreadsheet
            for tweet in tweepy.Cursor(api.search_tweets, q=drug_name+' -filter:retweets', lang="en", tweet_mode='extended').items(100):
                w.writerow([tweet.created_at, 
                            tweet.full_text.replace('\n',' ').encode('utf-8'), 
                            tweet.user.screen_name.encode('utf-8'), 
                            [e['text'] for e in tweet._json['entities']['hashtags']],  
                            tweet.user.location, 
                            tweet.user.followers_count, 
                            tweet.retweet_count, 
                            tweet.favorite_count])

# Enter your hashtag here


if __name__ == '__main__':
    create_dataset(consumer_key, consumer_secret, access_token, access_token_secret)