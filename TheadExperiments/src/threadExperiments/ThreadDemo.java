package threadExperiments;

import org.joda.time.DateTime;

public class ThreadDemo {
	public static void main(String args[]) {
		new NewThread(); // create a new thread
		try {
			for (int i = 5; i > 0; i--) {
				System.out.println("Main Thread: " + i);
				Thread.sleep(100);
			}
			DateTime a = new DateTime("2013-09-29T06:00-05:00");
			
			System.out.println(a);
			
		} catch (InterruptedException e) {
			System.out.println("Main thread interrupted.");
		}
		System.out.println("Main thread exiting.");
	}
}