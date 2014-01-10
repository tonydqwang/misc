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
			//nvps.add(new BasicNameValuePair("authenticity_token","CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8="));
			nvps.add(new BasicNameValuePair("key","CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8="));
			nvps.add(new BasicNameValuePair("cmd","signin"));
			nvps.add(new BasicNameValuePair("session[email]","user1@49x.com"));
			nvps.add(new BasicNameValuePair("session[password]","face2book@"));*/
			
			//create user NOT YET WORKING
			/*HttpPost post = new HttpPost("http://localhost:3000/droid/user");
			nvps.add(new BasicNameValuePair("key","CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8="));
			nvps.add(new BasicNameValuePair("cmd","create"));
			nvps.add(new BasicNameValuePair("name","NEWDUDE"));
			nvps.add(new BasicNameValuePair("email","NEWDUDE@49x.com"));
			nvps.add(new BasicNameValuePair("password","face2book@")); */
			
			//read schedule
			/*HttpPost post = new HttpPost("http://localhost:3000/droid/schedule");
			nvps.add(new BasicNameValuePair("key","CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8="));
			nvps.add(new BasicNameValuePair("cmd","read"));
			nvps.add(new BasicNameValuePair("userid","3"));
			nvps.add(new BasicNameValuePair("start","2013-12-01"));
			nvps.add(new BasicNameValuePair("end","2014-12-31"));*/
			
			//read restrictions
			/*HttpPost post = new HttpPost("http://localhost:3000/droid/restriction");
			nvps.add(new BasicNameValuePair("key","CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8="));
			nvps.add(new BasicNameValuePair("cmd","read"));
			nvps.add(new BasicNameValuePair("userid","2"));	
			nvps.add(new BasicNameValuePair("start","2013-12-01"));
			nvps.add(new BasicNameValuePair("end","2014-01-01")); */
			
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
			nvps.add(new BasicNameValuePair("id","1"));
			nvps.add(new BasicNameValuePair("user_id","NO_CHANGE"));	
			nvps.add(new BasicNameValuePair("start","2013-12-01"));
			nvps.add(new BasicNameValuePair("end","NO_CHANGE"));
			nvps.add(new BasicNameValuePair("reason","NO_CHANGE"));
			nvps.add(new BasicNameValuePair("approve","NO_CHANGE"));*/
			
			//read department
			/*HttpPost post = new HttpPost("http://localhost:3000/droid/department");
			nvps.add(new BasicNameValuePair("key","CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8="));
			nvps.add(new BasicNameValuePair("cmd","read"));*/
			
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
			
			
			post.setEntity(new UrlEncodedFormEntity(nvps, Consts.UTF_8));
			
			HttpClient client = new DefaultHttpClient();
			((AbstractHttpClient) client).setRedirectStrategy(new LaxRedirectStrategy());
			HttpResponse response = client.execute(post);
			ResponseHandler<String> handler = new BasicResponseHandler();
			String body = handler.handleResponse(response);
			System.out.println(body);	
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}