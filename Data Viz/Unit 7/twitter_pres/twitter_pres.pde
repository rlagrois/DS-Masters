import twitter4j.*;
import twitter4j.api.*;
import twitter4j.auth.*;
import twitter4j.conf.*;
import twitter4j.json.*;
import twitter4j.management.*;
import twitter4j.util.*;
import twitter4j.util.function.*;

ConfigurationBuilder cb = new ConfigurationBuilder();
cb.setOAuthConsumerKey("SZX2j0NVRUvq9WvC7IftnR6s6");
cb.setOAuthConsumerSecret("5mlqaVmVieGhbsehkqpsXkCluG5QoShP3PZ213zaugupyT2uf3");
cb.setOAuthAccessToken("392356259-a8h8JbQyDqcWUIutM39TcqOhjwy6ZfZQxYPcJJoE");
cb.setOAuthAccessTokenSecret("p0Z8qGSP5uygUSiLpGGYioZsjru7si1o0kM0Ddi8ujZjE");

Twitter twitter = new TwitterFactory(cb.build()).getInstance();
Query query = new Query("#OWS");
query.setRpp(100);
 
try {
  QueryResult result = twitter.search(query);
  ArrayList tweets = (ArrayList) result.getTweets();
 
  for (int i = 0; i < tweets.size(); i++) {
    Tweet t = (Tweet) tweets.get(i);
    String user = t.getFromUser();
    String msg = t.getText();
    Date d = t.getCreatedAt();
    println("Tweet by " + user + " at " + d + ": " + msg);
  };
}
catch (TwitterException te) {
  println("Couldn't connect: " + te);
};