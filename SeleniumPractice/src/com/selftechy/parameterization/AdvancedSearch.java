package com.selftechy.parameterization;

import com.thoughtworks.selenium.*;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class AdvancedSearch extends SeleneseTestCase {
	@Before
	public void setUp() throws Exception {
		selenium = new DefaultSelenium("localhost", 4444, "*chrome", "http://www.google.co.in/");
		selenium.start();
	}

	@Test
	public void testAdvancedSearch() throws Exception {
		selenium.open("http://www.google.com/");
		selenium.click("link=Advanced search");
		selenium.waitForPageToLoad("80000");
		selenium.type("as_q", "selftechy, selenium, eclipse");
		selenium.select("num", "label=20 results");
		selenium.click("//input[@value='Advanced Search']");
		selenium.waitForPageToLoad("30000");
	}

	@After
	public void tearDown() throws Exception {
		selenium.stop();
	}
}