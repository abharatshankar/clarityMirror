package com.example.clarity_mirror;

import android.app.Activity;
import android.app.FragmentManager;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.util.AttributeSet;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.MenuItem;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.RelativeLayout;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.FragmentActivity;
import androidx.multidex.MultiDex;

import com.google.android.material.bottomnavigation.BottomNavigationView;
import com.google.android.material.navigation.NavigationView;

import org.btbp.btbplibrary.AppConfig;
import org.btbp.btbplibrary.AutoCaptureFragment;
import org.btbp.btbplibrary.BTBP;
import org.btbp.btbplibrary.BTBPCaptureResult;
import org.btbp.btbplibrary.BTBPConfig;
import org.btbp.btbplibrary.Utilities.StaticVars;

import java.io.IOException;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.github.inflationx.calligraphy3.CalligraphyConfig;
import io.github.inflationx.calligraphy3.CalligraphyInterceptor;
import io.github.inflationx.viewpump.ViewPump;
import io.github.inflationx.viewpump.ViewPumpContextWrapper;

public class AutoCaptureActivity extends RelativeLayout implements SurfaceHolder.Callback {
    private Context context;
    private SurfaceView surfaceView;
    private AutoCaptureFragment autoCaptureFragment;
    private ResultFragment resultFragment;
    private SurfaceHolder holder;

    private BTBP.MirrorCallback mirrorCallback = new BTBP.MirrorCallback() {
        @Override
        public void onSuccess(BTBPCaptureResult btbpCaptureResult, String iqcStatusMessage) {

        }

        @Override
        public void onError(int errorCode) {
            // Handle error
        }

        @Override
        public void onIQCRejected(String IQCMessage) {
            // Handle rejection
        }
    };

    public AutoCaptureActivity(Context context) {
        super(context);
        init(context);
    }

    public AutoCaptureActivity(Context context, AttributeSet attrs) {
        super(context, attrs);
        init(context);
    }

    private void init(Context context) {
        this.context = context;

        // Inflate the XML layout
        LayoutInflater.from(context).inflate(R.layout.activity_auto_capture, this, true);

        // Find the SurfaceView and other UI elements
        surfaceView = findViewById(R.id.surface_view);
        holder = surfaceView.getHolder();
        holder.addCallback(this);


        // Initialize the AutoCaptureFragment and other components
        if (context instanceof android.app.Activity) {
            FragmentManager fragmentManager = ((Activity) context).getFragmentManager();
            autoCaptureFragment = new AutoCaptureFragment();
            fragmentManager.beginTransaction()
                    .replace(R.id.auto_capture_fragment, autoCaptureFragment)
                    .commit();
        }

        StaticVars.appConfig = new AppConfig();
        BTBP.mirrorCallbacks = mirrorCallback;
    }

    @Override
    public void surfaceCreated(SurfaceHolder holder) {
        // Initialize and start the camera capture here
        Log.d("AutoCaptureView", "Surface created");
        autoCaptureFragment.onAutoCaptureClicked(null); // Example of interaction
    }

    @Override
    public void surfaceChanged(SurfaceHolder holder, int format, int width, int height) {
        // Handle surface changes if needed
    }

    @Override
    public void surfaceDestroyed(SurfaceHolder holder) {
        // Release camera resources here
    }
}
