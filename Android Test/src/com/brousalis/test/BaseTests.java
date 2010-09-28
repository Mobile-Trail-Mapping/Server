package com.brousalis.test;

import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.content.res.Configuration;
import android.test.ActivityInstrumentationTestCase2;
import android.test.TouchUtils;
import android.util.Log;


import com.brousalis.MobileTrailsApp;
import com.brousalis.ShowMap;
import com.google.android.maps.GeoPoint;
import com.google.android.maps.MapView;

public class BaseTests extends ActivityInstrumentationTestCase2<ShowMap> {
	public static final int GOOD_ZOOM_LEVEL = 17;
	
	private ShowMap mActivity;
	private MapView mView;
	private int initialZoomLevel;
	private Configuration config;
	private GeoPoint initialPosition;
	
	public BaseTests() {
		super("com.brousalis", ShowMap.class);
	}
	
	@Override
	protected void setUp() throws Exception {
		super.setUp();
		config = new Configuration();
		config.setToDefaults();
		
		mActivity = this.getActivity();
		mView = (MapView) mActivity.findViewById(com.brousalis.R.id.mapView);
		initialZoomLevel = mView.getZoomLevel();
		initialPosition = mView.getMapCenter();
	}
	
	/**
	 * Ensure that everything in setUp went correctly
	 */
	public void testPreconditions() {
		assertNotNull(mView);
	}
	
	/**
	 * Open the Activity and verify that it has opened
	 */
	private void openActivity() {
		Intent testIntent = new Intent(mActivity, ShowMap.class);
		mActivity.startActivity(testIntent);
		TouchUtils.longClickView(this, mView);
	}

	/**
	 * Close the Activity (The process has gracefully exited) and 
	 * verify that it is closed
	 */
	private void closeActivity() {
		// A Bit Hacky... Fix this sometime
		mActivity.finish();
		try {
	        TouchUtils.longClickView(this, mView);
	    } catch (Exception e) {}
	    assertFalse(MobileTrailsApp.ActivityRunning);
	}
	
	/**
	 * Request that the the view is rotated to Landscape and ensure the view has rotated
	 */
	private void rotateToLandscape() {
		mActivity.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE);
		TouchUtils.longClickView(this, mView);
		assertEquals(ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE,mActivity.getRequestedOrientation());
	}
	
	/**
	 * Request that the view is rotated to Portrait and ensure that the view has rotated
	 */
	private void rotateToPortrait() {
		mActivity.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
		TouchUtils.longClickView(this, mView);
		assertEquals(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT,mActivity.getRequestedOrientation());
	}
	
	public void testLandscapeRotation() {
		rotateToPortrait();
		assertEquals(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT,mActivity.getRequestedOrientation());
		
		rotateToLandscape();
		assertEquals(ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE,mActivity.getRequestedOrientation());
		
		rotateToLandscape();
		assertEquals(ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE,mActivity.getRequestedOrientation());
	}
	
	public void testPortraitRotation() {
		rotateToLandscape();
		
		rotateToPortrait();
		
		assertEquals(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT,mActivity.getRequestedOrientation());
	}
	
	public void testMoveMapPositionAfterRotating() {
		rotateToPortrait();
		assertEquals(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT,mActivity.getRequestedOrientation());
		TouchUtils.dragQuarterScreenDown(this, getActivity());
		GeoPoint p = mView.getMapCenter();
		Log.w("MTM", "MTM: Center B = " + p);
		
		rotateToLandscape();
		assertEquals(ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE,mActivity.getRequestedOrientation());
		assertEquals(p, mView.getMapCenter());
		Log.w("MTM", "MTM: Center A = " + mView.getMapCenter());
	}
	
	public void testMoveMapThenCloseAndReOpen() {
		rotateToPortrait();
		GeoPoint p1 = mView.getMapCenter();

		TouchUtils.dragQuarterScreenDown(this, mActivity);

		GeoPoint p2 = mView.getMapCenter();
		
		closeActivity();
		openActivity();
		
		GeoPoint p3 = mView.getMapCenter();
		
		assertEquals("P1 is Off Center",p1, initialPosition);
		assertFalse("P2 is On Center",p2.equals(initialPosition));
		assertEquals("P3 did not resume in the same location as P2 Center",p3, p2);
		
	}

	public void testZoomLevel() {
		assertEquals(initialZoomLevel,mView.getZoomLevel());
	}
	
	public void testNullRecentLocation() {
		fail("Still not quite sure if this can happen or what to do about it...");
	}
	
	public void testNoServerResponse() {
		fail();
	}
	
	public void testSuccessfulServerResponse() {
		fail();
	}
}