package com.example.clarity_mirror;
import android.content.Context;
import android.view.View;

import io.flutter.plugin.platform.PlatformView;

public class NativePlatformView implements PlatformView {
    private final AutoCaptureActivity myNativeView;

    public NativePlatformView(Context context) {
        myNativeView = new AutoCaptureActivity(context);
    }

    @Override
    public View getView() {
        return myNativeView;
    }

    @Override
    public void dispose() {}
}
