package com.coimotion.plugin;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.PluginResult;
import org.apache.http.HttpResponse;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.util.Log;

import com.coimotion.csdk.common.COIMCallListener;
import com.coimotion.csdk.common.COIMException;
import com.coimotion.csdk.util.ReqUtil;

public class coimPlugin extends CordovaPlugin{
	private static final String TAG = "coimPlugin";
	private static final String ACTION_SEND = "send";
	private static final String ACTION_LOGIN = "login";
	private static final String ACTION_LOGOUT = "logout";
	private static final String ACTION_REGISTER = "register";
	private static final String ACTION_UPDPASSWD = "updPasswd";
	private static final String ACTION_ATTACH = "attach";
	private static final String ACTION_GET_TOKEN = "getToken";
    private static final String ACTION_CHECK_NETWORK = "checkNetwork";
	
	private CallbackContext mCallbackContext;
	
	@Override
	public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		mCallbackContext = callbackContext;
		if (ACTION_GET_TOKEN.equals(action)) {
			try {
				ReqUtil.initSDK(this.cordova.getActivity().getApplication());
			} catch (Exception e1) {
				JSONObject result = new JSONObject();
				try {
					result.put("type", "fail");
					result.put("result",""+e1.getLocalizedMessage());
				} catch (JSONException e) {}
				PluginResult pluginResult = new PluginResult(PluginResult.Status.OK, result);
				pluginResult.setKeepCallback(true);
				mCallbackContext.sendPluginResult(pluginResult);
			}
        	cordova.getThreadPool().execute(new Runnable() {
	            public void run() {
	            	final JSONObject result = new JSONObject();
					try {
						result.put("type", "token");
						result.put("result", ReqUtil.getToken());
					} catch (JSONException e) {
						e.printStackTrace();
					}
					PluginResult pluginResult = new PluginResult(PluginResult.Status.OK, result);
					pluginResult.setKeepCallback(true);
					mCallbackContext.sendPluginResult(pluginResult);
	            }});
			return true;
        }
        
        if (ACTION_CHECK_NETWORK.equals(action)) {
			try {
				ReqUtil.initSDK(this.cordova.getActivity().getApplication());
			} catch (Exception e1) {
				JSONObject result = new JSONObject();
				try {
					result.put("type", "fail");
					result.put("result",""+e1.getLocalizedMessage());
				} catch (JSONException e) {}
				PluginResult pluginResult = new PluginResult(PluginResult.Status.OK, result);
				pluginResult.setKeepCallback(true);
				mCallbackContext.sendPluginResult(pluginResult);
			}
        	cordova.getThreadPool().execute(new Runnable() {
	            public void run() {
	            	final JSONObject result = new JSONObject();
	            	String network = ReqUtil.checkNetwork()?"true":"false";
					try {
						result.put("type", "checkNetwork");
						result.put("result", network);
					} catch (JSONException e) {
						e.printStackTrace();
					}
					PluginResult pluginResult = new PluginResult(PluginResult.Status.OK, result);
					pluginResult.setKeepCallback(true);
					mCallbackContext.sendPluginResult(pluginResult);
	            }});
			return true;
        }
        
		try {
			ReqUtil.initSDK(this.cordova.getActivity().getApplication());
			final String relativeURL = args.getJSONObject(0).getString("relativeURL");
			final Map<String, Object> mapParam = new HashMap<String, Object>();
			String paramStr = args.getJSONObject(0).getString("param");
			JSONObject JSONParam = new JSONObject(paramStr);
			Iterator<?> keys = JSONParam.keys();
	
	        while( keys.hasNext() ){
	            String key = (String)keys.next();
	            mapParam.put(key, JSONParam.getString(key));
	        }
	        
	        if (ACTION_SEND.equals(action)) {
				cordova.getThreadPool().execute(new Runnable() {
		            public void run() {
		            	ReqUtil.send(relativeURL, mapParam, listener);
		            }});
				return true;
			}
			else if(ACTION_LOGIN.equals(action)) {
				cordova.getThreadPool().execute(new Runnable() {
		            public void run() {
		            	ReqUtil.login(relativeURL, mapParam, listener);
		            }});
				return true;
			}
			else if (ACTION_UPDPASSWD.equals(action)) {
				cordova.getThreadPool().execute(new Runnable() {
		            public void run() {
		            	ReqUtil.updatePasswd(mapParam, listener);
		            }});
				return true;
			}
			else if (ACTION_REGISTER.equals(action)) {
				cordova.getThreadPool().execute(new Runnable() {
		            public void run() {
		            	ReqUtil.registerUser(mapParam, listener);
		            }});
				return true;
			}
			else if (ACTION_LOGOUT.equals(action)) {
				cordova.getThreadPool().execute(new Runnable() {
		            public void run() {
		            	ReqUtil.logout(listener);
		            }});
				return true;
			}
			else if (ACTION_ATTACH.equals(action)) {
				JSONArray fileList = args.getJSONObject(0).getJSONArray("files");
				final String[] files = new String[fileList.length()];
				for(int i =0 ; i < fileList.length(); i++) {
					files[i] = fileList.getString(i);
				}
				cordova.getThreadPool().execute(new Runnable() {
		            public void run() {
		            	ReqUtil.attach(relativeURL, mapParam, files, listener);
		            }});
				return true;
			}
			else 
				return false;
		} catch (final Exception e) {
			cordova.getThreadPool().execute(new Runnable() {
	            public void run() {
	            	JSONObject result = new JSONObject();
					try {
						result.put("type", "fail");
						result.put("result",e.getLocalizedMessage());
					} catch (JSONException e) {}
					PluginResult pluginResult = new PluginResult(PluginResult.Status.OK, result);
					pluginResult.setKeepCallback(true);
					mCallbackContext.sendPluginResult(pluginResult);
	        }});
			return true;
		}
	}
	
	private COIMCallListener listener = new COIMCallListener() {
		
		@Override
		public void onSuccess(JSONObject arg0) {
			final JSONObject result = new JSONObject();
			try {
				result.put("type", "success");
				result.put("result", arg0);
			} catch (JSONException e) {
			}
			PluginResult pluginResult = new PluginResult(PluginResult.Status.OK, result);
			pluginResult.setKeepCallback(true);
			mCallbackContext.sendPluginResult(pluginResult);
		}
		
		@Override
		public void onProgress(Integer progress) {
			final JSONObject result = new JSONObject();
			try {
				result.put("type", "progress");
				result.put("result", progress.intValue());
			} catch (JSONException e) {
			}
	    	PluginResult pluginResult = new PluginResult(PluginResult.Status.OK, result);
	    	pluginResult.setKeepCallback(true);
        	mCallbackContext.sendPluginResult(pluginResult);
		}
		
		@Override
		public void onInvalidToken() {
			final JSONObject result = new JSONObject();
			try {
				result.put("type", "invalid");
				result.put("result", "");
			} catch (JSONException e) {
			}
        	PluginResult pluginResult = new PluginResult(PluginResult.Status.OK, result);
        	pluginResult.setKeepCallback(true);
        	mCallbackContext.sendPluginResult(pluginResult);
		}
		
		@Override
		public void onFail(HttpResponse arg0, Exception arg1) {
			final JSONObject result = new JSONObject();
			try {
				result.put("type", "fail");
				result.put("result", arg1.getLocalizedMessage());
			} catch (JSONException e) {
			}
        	PluginResult pluginResult = new PluginResult(PluginResult.Status.OK, result);
        	pluginResult.setKeepCallback(true);
        	mCallbackContext.sendPluginResult(pluginResult);
		}
	};
}
