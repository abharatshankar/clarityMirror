package com.example.clarity_mirror;

import android.app.Activity;
import android.content.Context;
import android.view.View;

import org.btbp.btbplibrary.AutoCaptureFragment;

import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class NativeViewFactory extends PlatformViewFactory {
    private final Activity activity;

    public NativeViewFactory(Activity activity) {
        super(StandardMessageCodec.INSTANCE);
        this.activity = activity;
    }

    @Override
    public PlatformView create(Context context, int id, Object args) {
        return new NativePlatformView(activity);
    }
}
