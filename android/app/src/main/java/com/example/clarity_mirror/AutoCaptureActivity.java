package com.example.clarity_mirror;

import android.app.Activity;
import android.app.FragmentManager;
import android.content.Context;
import android.util.AttributeSet;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import android.widget.RelativeLayout;
import org.btbp.btbplibrary.AutoCaptureFragment;

public class AutoCaptureActivity extends RelativeLayout implements SurfaceHolder.Callback {
    private SurfaceHolder holder;
    private SurfaceView surfaceView;
    private static AutoCaptureFragment autoCaptureFragment;

    public AutoCaptureActivity(Context context) {
        super(context);
        init(context);
    }

    public AutoCaptureActivity(Context context, AttributeSet attrs) {
        super(context, attrs);
        init(context);
    }

    private void init(Context context) {
        // Inflate the XML layout
        LayoutInflater.from(context).inflate(R.layout.activity_auto_capture, this, true);

        // Find the SurfaceView and other UI elements
        surfaceView = findViewById(R.id.surface_view);
        holder = surfaceView.getHolder();
        holder.addCallback(this);

        // Initialize the AutoCaptureFragment and other components
        if (context instanceof android.app.Activity) {
            FragmentManager autoCapFragmentManager = ((Activity) context).getFragmentManager();
            autoCaptureFragment = new AutoCaptureFragment();
            autoCapFragmentManager.beginTransaction()
                    .replace(R.id.auto_capture_fragment, autoCaptureFragment)
                    .commit();
        }
    }

    @Override
    public void surfaceCreated(SurfaceHolder holder) {
        // Initialize and start the camera capture here
        Log.d("AutoCaptureView", "Surface created");
    }

    @Override
    public void surfaceChanged(SurfaceHolder holder, int format, int width, int height) {
        // Handle surface changes if needed
    }

    @Override
    public void surfaceDestroyed(SurfaceHolder holder) {
        // Release camera resources here
        if (autoCaptureFragment != null) {
            autoCaptureFragment.releaseCamera();
        }
    }

    public static void loadAutoCapture() {
        if(autoCaptureFragment != null){
            autoCaptureFragment.onAutoCaptureClicked(null);
        }
    }

    public static void releaseCamera() {
        if(autoCaptureFragment != null){
            autoCaptureFragment.releaseCamera();
        }
    }
}
