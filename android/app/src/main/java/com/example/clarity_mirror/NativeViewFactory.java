package com.example.clarity_mirror;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import java.util.Map;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;
import io.flutter.view.FlutterView;

class NativeViewFactory extends PlatformViewFactory {
//    private final Activity activity;
 /*   private final SplashScreenActivity splashScreenActivity;
    NativeViewFactory(SplashScreenActivity splashScreenActivity) {
        super(StandardMessageCodec.INSTANCE);
        this.splashScreenActivity = splashScreenActivity;
    }
*/
    NativeViewFactory() {
        super(StandardMessageCodec.INSTANCE);
    }

    @Override
    public PlatformView create(@NonNull Context context, int id, @Nullable Object args) {
//        return new MainActivityPlatformView(splashScreenActivity);
        return new ExistingActivityView(context);

    }
}

