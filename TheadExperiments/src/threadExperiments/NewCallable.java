package threadExperiments;

import java.util.concurrent.Callable;

public class NewCallable implements Callable{

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

	@Override
	public Object call() throws Exception {
		long time = System.currentTimeMillis();
		return time;
	}

}
