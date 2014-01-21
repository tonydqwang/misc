package tony.apps.helloworld;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

public class MainActivity extends Activity {
	
	public final static String EXRTA_MESSAGE = "tony.apps.helloworld.MESSAGE";
	public final static String SAVED_TEXT = "TEXT";
	private EditText tField;
	
	public TextView getTField() {
		if (tField == null) {
			tField = (EditText) findViewById(R.id.edit_message);
		}
		return this.tField;
	}
	
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        
        //getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        
    }
    public void onRestoreInstanceState(Bundle savedInstanceState) {
	    super.onRestoreInstanceState(savedInstanceState);
	    this.getTField().setText(savedInstanceState.getString(SAVED_TEXT));
	}
    
    @Override
	public void onSaveInstanceState(Bundle savedInstanceState) {
	    savedInstanceState.putString(SAVED_TEXT, this.getTField().getText().toString());
	    super.onSaveInstanceState(savedInstanceState);
	}

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        // getMenuInflater().inflate(R.menu.main, menu);
    	
    	MenuInflater inflater = getMenuInflater();
    	inflater.inflate(R.menu.main_activity_actions, menu);
    	
        //return true;
    	return super.onCreateOptionsMenu(menu);
    }
    
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
    	// Handle presses on the action bar items
    	switch (item.getItemId()) {
    		case R.id.action_search:
    			this.openSearch();
    			return true;
    		case R.id.action_settings:
    			openSettings();
    			return true;
    		default:
    			return super.onOptionsItemSelected(item);
    	}
    }
    
    private void openSettings() {
		// TODO Auto-generated method stub
    	TextView textView = (TextView) findViewById(R.id.label1);
		textView.setText("opened settings");
	}


	private void openSearch() {
		// TODO Auto-generated method stub
		TextView textView = (TextView) findViewById(R.id.label1);
		textView.setText("opened search");
	}


	public void sendMessage(View view) {
    	Intent intent = new Intent(this, DisplayMessageActivity.class);
    	EditText editText = (EditText) findViewById(R.id.edit_message);
    	String message = editText.getText().toString();
    	intent.putExtra(EXRTA_MESSAGE, message);
    	startActivity(intent);
    }
}
