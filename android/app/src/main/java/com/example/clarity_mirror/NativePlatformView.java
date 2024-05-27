package com.example.clarity_mirror;

import android.app.Activity;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.fragment.app.FragmentActivity;
import android.app.FragmentManager;
import android.app.FragmentTransaction;

import org.btbp.btbplibrary.AutoCaptureFragment;

import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

public class NativePlatformView implements PlatformView, MethodChannel.MethodCallHandler {
    private final View root;
    private final MethodChannel methodChannel;
    private AutoCaptureFragment autoCaptureFragment;
    private static final String TAG_FLUTTER_FRAGMENT = "auto_capture_activity_fragment";

    public NativePlatformView(@NonNull Activity context) {
        if (!(context instanceof FragmentActivity)) {
            throw new IllegalArgumentException("Activity must be a FragmentActivity");
        }

        FragmentActivity fragmentActivity = (FragmentActivity) context;
        FragmentManager fragmentManager = fragmentActivity.getFragmentManager();

        // Inflate the layout without attaching to root
        root = LayoutInflater.from(context).inflate(R.layout.activty_main, null, false);

        // Check if the fragment already exists
        autoCaptureFragment = (AutoCaptureFragment) fragmentManager.findFragmentByTag(TAG_FLUTTER_FRAGMENT);
        if (autoCaptureFragment == null) {
            // Fragment doesn't exist, so create and add it
            autoCaptureFragment = new AutoCaptureFragment();
            FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
            fragmentTransaction.add(R.id.fragment_container, autoCaptureFragment, TAG_FLUTTER_FRAGMENT);
            fragmentTransaction.commit();
            Log.d("NativePlatformView", "AutoCaptureFragment added to the container.");
        } else {
            // Reattach the existing fragment
            FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
            fragmentTransaction.attach(autoCaptureFragment);
            fragmentTransaction.commit();
            Log.d("NativePlatformView", "AutoCaptureFragment already exists, reattached.");
        }

        methodChannel = new MethodChannel(FlutterEngineCache.getInstance().get("mirror_channel_engine").getDartExecutor(), "com.example.clarity_mirror/mirror_channel");
        methodChannel.setMethodCallHandler(this);
    }

    @Override
    public void onFlutterViewAttached(@NonNull View flutterView) {
        Log.d("NativePlatformView", "Flutter view attached");
    }

    @Override
    public View getView() {
        // Ensure root has no parent before returning
        return root;
    }

    @Override
    public void dispose() {
        // Clean up if necessary
        if (autoCaptureFragment != null) {
            FragmentActivity fragmentActivity = (FragmentActivity) root.getContext();
            FragmentManager fragmentManager = fragmentActivity.getFragmentManager();
            FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
            fragmentTransaction.remove(autoCaptureFragment);
            fragmentTransaction.commit();
        }
    }

    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        if (call.method.equals("dispose")) {
            dispose();
            result.success(null);
        } else {
            result.notImplemented();
        }
    }
}
