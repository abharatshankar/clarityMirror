package com.example.clarity_mirror;

import android.app.Activity;
import android.app.Fragment;
import android.app.FragmentManager;
import android.content.Context;
import android.os.Bundle;
import android.util.AttributeSet;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import android.view.View;
import android.view.ViewGroup;
import android.widget.RelativeLayout;

import org.btbp.btbplibrary.AutoCaptureFragment;

public class AutoCaptureActivity extends Fragment implements SurfaceHolder.Callback {
    View root;
    private SurfaceHolder holder;
    private SurfaceView surfaceView;
    AutoCaptureFragment autoCaptureFragment;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        root = inflater.inflate(R.layout.activity_auto_capture, container, false);

        // Find the SurfaceView and other UI elements
        surfaceView = root.findViewById(R.id.surface_view);
        holder = surfaceView.getHolder();
        holder.addCallback(this);

        // Initialize the AutoCaptureFragment and other components
        FragmentManager fragmentManager = getActivity().getFragmentManager();
        autoCaptureFragment = (AutoCaptureFragment) fragmentManager.findFragmentById(R.id.auto_capture_fragment);

        return root;
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

    public void loadAutoCapture() {
        if (autoCaptureFragment != null) {
            autoCaptureFragment.onAutoCaptureClicked(root);
        }
    }

    public void releaseCamera() {
        if (autoCaptureFragment != null) {
            autoCaptureFragment.releaseCamera();
        }
    }
}
