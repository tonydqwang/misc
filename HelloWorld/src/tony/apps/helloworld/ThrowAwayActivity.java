package tony.apps.helloworld;

import android.app.Activity;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.view.Menu;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

public class ThrowAwayActivity extends Activity {
	
	static final String STATE_TEXT = "Text Value";
	private TextView tLabel;
	private TextView tLabel2;
	
	public TextView getTLabel() {
		if (tLabel == null) {
			tLabel = (TextView) findViewById(R.id.throwAwayLabel);
		}
		return this.tLabel;
	}
	
	public TextView getTLabel2() {
		if (tLabel == null) {
			tLabel = (TextView) findViewById(R.id.throwAwayLabel2);
		}
		return this.tLabel2;
	}
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_throw_away);	
		setupActionBar();
		Intent intent = getIntent();
		this.getTLabel().setText(intent.getStringExtra("user_id"));	
	}
	
	public void onRestoreInstanceState(Bundle savedInstanceState) {
	    super.onRestoreInstanceState(savedInstanceState);

	    this.getTLabel2().setText(savedInstanceState.getString(STATE_TEXT));
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
	
	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.throw_away, menu);
		return true;
	}
	
	//keep it light, only IO done should be auto-save related work 
	@Override
	public void onPause() {
		super.onPause();
	}
	
	@Override
	public void onResume() {
		super.onResume();
		TextView tLabel = this.getTLabel();
		tLabel.setText(tLabel.getText() 
				+ "\nresumed on " + System.currentTimeMillis() + " ms");
	}

	@Override
	public void onSaveInstanceState(Bundle savedInstanceState) {
	    savedInstanceState.putString(STATE_TEXT, this.getTLabel2().getText().toString());
	    super.onSaveInstanceState(savedInstanceState);
	}
	
	public void displayText(View view) {
		EditText tField = (EditText) findViewById(R.id.throwAwayField);
		TextView tLabel = (TextView) findViewById(R.id.throwAwayLabel2);
		tLabel.setText(tField.getText());
	}
}
