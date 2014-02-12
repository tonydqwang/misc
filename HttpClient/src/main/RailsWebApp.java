package main;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.http.Consts;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.AbstractHttpClient;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.LaxRedirectStrategy;
import org.apache.http.message.BasicNameValuePair;

public class RailsWebApp {

	public static void main(String[] args) {
		
		//HttpPost post = new HttpPost("http://localhost:8080/AlgorithmServer/AlgorithmServlet");
		//HttpPost post = new HttpPost("http://elec49x.cloudapp.net/sessions");
		//HttpPost post = new HttpPost("http://localhost:3000/sessions");
		//StringEntity msgEntity;
		try {
			//msgEntity = new StringEntity("test string, plz survive");
			//post.setEntity(msgEntity);
			
			List<NameValuePair> nvps = new ArrayList<NameValuePair>();

			//sign in
			/*HttpPost post = new HttpPost("http://localhost:3000/droid/user");
			nvps.add(new BasicNameValuePair("authenticity_token","CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8="));
			nvps.add(new BasicNameValuePair("key","CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8="));
			nvps.add(new BasicNameValuePair("cmd","signin"));
			nvps.add(new BasicNameValuePair("session[email]","user4@49x.com"));
			nvps.add(new BasicNameValuePair("session[password]","face2book@"));*/
			
			//create user NOT YET DESIGNED OR IMPLEMENTED
			/*HttpPost post = new HttpPost("http://localhost:3000/droid/user");
			nvps.add(new BasicNameValuePair("key","CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8="));
			nvps.add(new BasicNameValuePair("cmd","create"));
			nvps.add(new BasicNameValuePair("name","NEWDUDE"));
			nvps.add(new BasicNameValuePair("email","NEWDUDE@49x.com"));
			nvps.add(new BasicNameValuePair("password","face2book@")); */
			
			// update user - name phone(to be added)
			/*HttpPost post = new HttpPost("http://localhost:3000/droid/user");
			nvps.add(new BasicNameValuePair("key","CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8="));
			nvps.add(new BasicNameValuePair("cmd","update"));
			nvps.add(new BasicNameValuePair("user_id","2"));
			nvps.add(new BasicNameValuePair("name","user1 Dudess"));
			nvps.add(new BasicNameValuePair("email","user1@49x.com"));
			nvps.add(new BasicNameValuePair("password","face2book@"));
			nvps.add(new BasicNameValuePair("password_confirmation","face2book@"));*/
			
			//read schedule
			/*HttpPost post = new HttpPost("http://localhost:3000/droid/schedule");
			nvps.add(new BasicNameValuePair("key","CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8="));
			nvps.add(new BasicNameValuePair("cmd","read"));
			nvps.add(new BasicNameValuePair("user_id","3"));
			nvps.add(new BasicNameValuePair("start","2013-12-01"));
			nvps.add(new BasicNameValuePair("end","2014-12-31"));*/
			
			//create Swap
			/*HttpPost post = new HttpPost("http://localhost:3000/droid/schedule");
			nvps.add(new BasicNameValuePair("key","CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8="));
			nvps.add(new BasicNameValuePair("cmd","post_swap_requests"));
			nvps.add(new BasicNameValuePair("user_id","28"));
			nvps.add(new BasicNameValuePair("event_id","16"));*/
	
			//delete Swap
			/*HttpPost post = new HttpPost("http://localhost:3000/droid/schedule");
			nvps.add(new BasicNameValuePair("key","CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8="));
			nvps.add(new BasicNameValuePair("cmd","delete_swap"));
			nvps.add(new BasicNameValuePair("swap_id","37"));*/
			
			//get Swap requests
			/*HttpPost post = new HttpPost("http://localhost:3000/droid/schedule");
			nvps.add(new BasicNameValuePair("key","CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8="));
			nvps.add(new BasicNameValuePair("cmd","read_my_swap_requests"));
			nvps.add(new BasicNameValuePair("user_id","16"));*/
			
			//get Swap offers
			/*HttpPost post = new HttpPost("http://localhost:3000/droid/schedule");
			nvps.add(new BasicNameValuePair("key","CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8="));
			nvps.add(new BasicNameValuePair("cmd","read_swap_offers"));
			nvps.add(new BasicNameValuePair("user_id","16"));*/
			
			//delete Swap offers
			/*HttpPost post = new HttpPost("http://localhost:3000/droid/schedule");
			nvps.add(new BasicNameValuePair("key","CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8="));
			nvps.add(new BasicNameValuePair("cmd","delete_offer"));
			nvps.add(new BasicNameValuePair("is_own","0"));
			nvps.add(new BasicNameValuePair("user_id","50"));
			nvps.add(new BasicNameValuePair("event_id","2"));
			nvps.add(new BasicNameValuePair("offer_event_id","3"));*/
			
			//delete Swap requests
			/*HttpPost post = new HttpPost("http://localhost:3000/droid/schedule");
			nvps.add(new BasicNameValuePair("key","CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8="));
			nvps.add(new BasicNameValuePair("cmd","delete_request"));
			nvps.add(new BasicNameValuePair("user_id","50"));
			nvps.add(new BasicNameValuePair("event_id","3"));*/
	
			//create Swap offer
			/*HttpPost post = new HttpPost("http://localhost:3000/droid/schedule");
			nvps.add(new BasicNameValuePair("key","CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8="));
			nvps.add(new BasicNameValuePair("cmd","post_swap_offers"));
			nvps.add(new BasicNameValuePair("user_id","7"));
			nvps.add(new BasicNameValuePair("event_id","3"));
			nvps.add(new BasicNameValuePair("offer_event_id","11"));*/
		
			//swap shifts
			/*HttpPost post = new HttpPost("http://elec49x.cloudapp.net/droid/schedule");
			nvps.add(new BasicNameValuePair("key","CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8="));
			nvps.add(new BasicNameValuePair("cmd","accept_offer"));
			nvps.add(new BasicNameValuePair("user_id","28"));
			nvps.add(new BasicNameValuePair("event_id","3"));
			nvps.add(new BasicNameValuePair("swap_event_id","16"));*/
			
	
			//read restrictions
			/*HttpPost post = new HttpPost("http://elec49x.cloudapp.net/droid/restriction");
			nvps.add(new BasicNameValuePair("key","CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8="));
			nvps.add(new BasicNameValuePair("cmd","read"));
			nvps.add(new BasicNameValuePair("user_id","5"));	
			nvps.add(new BasicNameValuePair("start","2006-12-01"));
			nvps.add(new BasicNameValuePair("end","2020-03-01"));*/
			
			//create restriction
			/*HttpPost post = new HttpPost("http://localhost:3000/droid/restriction");
			nvps.add(new BasicNameValuePair("key","CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8="));
			nvps.add(new BasicNameValuePair("cmd","create"));
			nvps.add(new BasicNameValuePair("user_id","3"));	
			nvps.add(new BasicNameValuePair("start","2013-12-01"));
			nvps.add(new BasicNameValuePair("end","2014-01-01"));
			nvps.add(new BasicNameValuePair("reason","V"));
			nvps.add(new BasicNameValuePair("approve","true"));*/
			//if failed, return message will not be empty
			
			//delete restriction
			/*HttpPost post = new HttpPost("http://localhost:3000/droid/restriction");
			nvps.add(new BasicNameValuePair("key","CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8="));
			nvps.add(new BasicNameValuePair("cmd","delete"));
			nvps.add(new BasicNameValuePair("id","32")); */	
			//if failed, return message will not be empty
			
			//update restriction
			/*HttpPost post = new HttpPost("http://localhost:3000/droid/restriction");
			nvps.add(new BasicNameValuePair("key","CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8="));
			nvps.add(new BasicNameValuePair("cmd","update"));
			nvps.add(new BasicNameValuePair("id","76"));
			nvps.add(new BasicNameValuePair("user_id","NO_CHANGE"));	
			nvps.add(new BasicNameValuePair("start","2013-11-01"));
			nvps.add(new BasicNameValuePair("end","NO_CHANGE"));
			nvps.add(new BasicNameValuePair("reason","NO_CHANGE"));
			nvps.add(new BasicNameValuePair("approve","NO_CHANGE"));*/
			
			//read department
			/*HttpPost post = new HttpPost("http://localhost:3000/droid/department");
			nvps.add(new BasicNameValuePair("key","CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8="));
			nvps.add(new BasicNameValuePair("cmd","read"));*/
			
			//read department by user_id
			HttpPost post = new HttpPost("http://localhost:3000/droid/department");
			nvps.add(new BasicNameValuePair("key","CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8="));
			nvps.add(new BasicNameValuePair("cmd","read_by_user_id"));
			nvps.add(new BasicNameValuePair("user_id","6"));
			
			//join department, contract not automatically created for obvious reasons
			/*HttpPost post = new HttpPost("http://localhost:3000/droid/department");
			nvps.add(new BasicNameValuePair("key","CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8="));
			nvps.add(new BasicNameValuePair("cmd","join"));
			nvps.add(new BasicNameValuePair("department_id","1"));
			nvps.add(new BasicNameValuePair("user_id","42")); */
			
			//leave department
			/*HttpPost post = new HttpPost("http://localhost:3000/droid/department");
			nvps.add(new BasicNameValuePair("key","CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8="));
			nvps.add(new BasicNameValuePair("cmd","leave"));
			nvps.add(new BasicNameValuePair("department_id","1"));
			nvps.add(new BasicNameValuePair("user_id","42")); */
			
			//read pool
			/*HttpPost post = new HttpPost("http://localhost:3000/droid/pool");
			nvps.add(new BasicNameValuePair("key","CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8="));
			nvps.add(new BasicNameValuePair("cmd","read"));*/
			
			//join pool, contract not automatically created for obvious reasons
			/*HttpPost post = new HttpPost("http://localhost:3000/droid/pool");
			nvps.add(new BasicNameValuePair("key","CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8="));
			nvps.add(new BasicNameValuePair("cmd","join"));
			nvps.add(new BasicNameValuePair("pool_id","1"));
			nvps.add(new BasicNameValuePair("user_id","42")); */
			
			//leave pool
			/*HttpPost post = new HttpPost("http://localhost:3000/droid/pool");
			nvps.add(new BasicNameValuePair("key","CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8="));
			nvps.add(new BasicNameValuePair("cmd","leave"));
			nvps.add(new BasicNameValuePair("pool_id","1"));
			nvps.add(new BasicNameValuePair("user_id","42"));*/
			
			//get team directory
			/*HttpPost post = new HttpPost("http://localhost:3000/droid/department");
			nvps.add(new BasicNameValuePair("key","CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8="));
			nvps.add(new BasicNameValuePair("cmd","team_directory"));
			nvps.add(new BasicNameValuePair("department_ids","1 2 "));*/
			
			//create messages
			/*HttpPost post = new HttpPost("http://elec49x.cloudapp.net/droid/message");
			nvps.add(new BasicNameValuePair("key","CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8="));
			nvps.add(new BasicNameValuePair("cmd","create"));
			nvps.add(new BasicNameValuePair("department_id","1"));
			nvps.add(new BasicNameValuePair("user_id","12"));
			nvps.add(new BasicNameValuePair("content","I hope I am using this correctly..."));*/
			
			//view messages
			/*HttpPost post = new HttpPost("http://elec49x.cloudapp.net//droid/message");
			nvps.add(new BasicNameValuePair("key","CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8="));
			nvps.add(new BasicNameValuePair("cmd","getall"));
			nvps.add(new BasicNameValuePair("department_id","1"));*/
			
			post.setEntity(new UrlEncodedFormEntity(nvps, Consts.UTF_8));
			
			HttpClient client = new DefaultHttpClient();
			((AbstractHttpClient) client).setRedirectStrategy(new LaxRedirectStrategy());
			HttpResponse response = client.execute(post);
			ResponseHandler<String> handler = new BasicResponseHandler();
			String body = handler.handleResponse(response);
			body = body.replaceAll("\\{", "\n");
			System.out.println(body);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}