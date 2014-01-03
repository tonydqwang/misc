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
		HttpPost post = new HttpPost("http://elec49x.cloudapp.net/sessions");
		//StringEntity msgEntity;
		try {
			//msgEntity = new StringEntity("test string, plz survive");
			//post.setEntity(msgEntity);
			
			List<NameValuePair> nvps = new ArrayList<NameValuePair>();
			nvps.add(new BasicNameValuePair("authenticity_token","CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8="));
			nvps.add(new BasicNameValuePair("session[email]","user1@49x.com"));
			nvps.add(new BasicNameValuePair("session[password]","face2book@"));
			nvps.add(new BasicNameValuePair("commit","Sign In"));
			//nvps.add(new BasicNameValuePair("session[password]","face2book@"));
			//nvps.add(new BasicNameValuePair("email","user1@49x.com"));
			//nvps.add(new BasicNameValuePair("password","face2book@"));
			post.setEntity(new UrlEncodedFormEntity(nvps, Consts.UTF_8));
			
			/* test passed 2013-09-10
			BufferedReader roundabout = new BufferedReader(
					new InputStreamReader(post.getEntity().getContent()));
			while (roundabout.ready()) {
				System.out.println(roundabout.readLine());
			}*/
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		try {
			HttpClient client = new DefaultHttpClient();
			((AbstractHttpClient) client).setRedirectStrategy(new LaxRedirectStrategy());
			HttpResponse response = client.execute(post);
			ResponseHandler<String> handler = new BasicResponseHandler();
			String body = handler.handleResponse(response);
			System.out.println(body);	
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
