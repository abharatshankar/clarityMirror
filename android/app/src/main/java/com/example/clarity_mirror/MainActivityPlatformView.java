package com.example.clarity_mirror;

import android.view.View;

import io.flutter.plugin.platform.PlatformView;

public class MainActivityPlatformView implements PlatformView {
    private final SplashScreenActivity splashScreenActivity;

    public MainActivityPlatformView(SplashScreenActivity activity) {
        this.splashScreenActivity = activity;
    }

    @Override
    public View getView() {
        // Return the root view of the MainActivity
        return splashScreenActivity.getWindow().getDecorView().getRootView();
    }

    @Override
    public void dispose() {
        // Dispose any resources when needed
    }
}