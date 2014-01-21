package tony.apps.helloworld;

import java.util.ArrayList;
import java.util.List;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.AbstractHttpClient;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.support.v4.app.NavUtils;
import android.view.MenuItem;
import android.view.View;
import android.widget.TextView;

public class DisplayMessageActivity extends Activity {

	@SuppressLint("NewApi")
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_display_message);
		
		// Show the Up button in the action bar.
		setupActionBar();
		Intent intent = getIntent();
		String message = "Hello World! I'm alive! \nTony, Zia, Olivia, and Brian"; 
		
		//TextView textView = new TextView(this);
		TextView textView = (TextView) findViewById(R.id.DispMsgLabel);
		textView.setTextSize(45);
		textView.setText(message);
		
		TextView actionLabel = (TextView) findViewById(R.id.label2);
		actionLabel.setText(intent.getStringExtra(MainActivity.EXRTA_MESSAGE));
		
		//setContentView(textView);	
	}

	/**
	 * Set up the {@link android.app.ActionBar}.
	 */
	private void setupActionBar() {
		// Make sure we're running on Honeycomb or higher to use ActionBar APIs
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
        	getActionBar().setDisplayHomeAsUpEnabled(true);
        	
        }
	}

	/* not needed for this app
	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.display_message, menu);
		return true;
	}*/

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		switch (item.getItemId()) {
		case android.R.id.home:
			// This ID represents the Home or Up button. In the case of this
			// activity, the Up button is shown. Use NavUtils to allow users
			// to navigate up one level in the application structure. For
			// more details, see the Navigation pattern on Android Design:
			//
			// http://developer.android.com/design/patterns/navigation.html#up-vs-back
			//
			NavUtils.navigateUpFromSameTask(this);
			return true;
		}
		return super.onOptionsItemSelected(item);
	}

	public void segue(View view) {
    	Intent intent = new Intent(this, ThrowAwayActivity.class);
    	TextView tView = (TextView) findViewById(R.id.label2);
    	String message = tView.getText().toString();
    	
    	List<NameValuePair> nvps = new ArrayList<NameValuePair>();

        //sign in
        /*HttpPost post = new HttpPost("http://ELEC49x.cloudapp.net/droid/user");
        nvps.add(new BasicNameValuePair("key","CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8="));
        nvps.add(new BasicNameValuePair("cmd","signin"));
        nvps.add(new BasicNameValuePair("session[email]","user1@49x.com"));
        nvps.add(new BasicNameValuePair("session[password]","face2book@"));
    	
        try {
        	post.setEntity(new UrlEncodedFormEntity(nvps, org.apache.http.protocol.HTTP.UTF_8));
        
        	HttpClient client = new DefaultHttpClient();
        	//((AbstractHttpClient) client).setRedirectStrategy(new LaxRedirectStrategy());
        	HttpResponse response = client.execute(post);
        	ResponseHandler<String> handler = new BasicResponseHandler();
        	String body = handler.handleResponse(response);
        	message = body;       
        } catch (Exception e) {
        	e.printStackTrace();
        }*/
        
    	intent.putExtra("user_id", message);
    	startActivity(intent);
    }
	
	public void segueToUsers(View view) {
    	Intent intent = new Intent(this, UserInfoActivity.class);
    	TextView tView = (TextView) findViewById(R.id.label2);
    	String message = tView.getText().toString();
    	intent.putExtra("userid", message);
    	startActivity(intent);
	}
}
