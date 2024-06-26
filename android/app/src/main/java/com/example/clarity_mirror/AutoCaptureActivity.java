package com.example.clarity_mirror;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.AttributeSet;
import android.util.DisplayMetrics;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.Button;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.multidex.MultiDex;

import org.btbp.btbplibrary.AppConfig;
import org.btbp.btbplibrary.AutoCaptureFragment;
import org.btbp.btbplibrary.BTBP;
import org.btbp.btbplibrary.BTBPCaptureResult;
import org.btbp.btbplibrary.BTBPConfig;
import org.btbp.btbplibrary.Utilities.StaticVars;

import io.github.inflationx.calligraphy3.CalligraphyConfig;
import io.github.inflationx.calligraphy3.CalligraphyInterceptor;
import io.github.inflationx.viewpump.ViewPump;
import io.github.inflationx.viewpump.ViewPumpContextWrapper;

public class AutoCaptureActivity extends AppCompatActivity {
    Context context;
    AutoCaptureFragment autoCaptureFragment;
    private ResultFragment resultFragment;
    BTBP.MirrorCallback mirrorCallback = new BTBP.MirrorCallback() {
        @Override
        public void onSuccess(BTBPCaptureResult btbpCaptureResult, String iqcStatusMessage) {
            if (resultFragment != null) {
                resultFragment.getView().setVisibility(View.VISIBLE);
                resultFragment.getView().bringToFront();

                DisplayMetrics displaymetrics = new DisplayMetrics();
                getWindowManager().getDefaultDisplay().getMetrics(displaymetrics);
                int displayWidth = displaymetrics.widthPixels;
                int displayHeight = displaymetrics.heightPixels;
                autoCaptureFragment.releaseCamera();
                resultFragment.showImage(btbpCaptureResult.getImagePath(), displayWidth, displayHeight, btbpCaptureResult.getCameraFacing(), iqcStatusMessage, btbpCaptureResult.getIsFromGallery());
            }
        }

        @Override
        public void onError(int errorCode) {

        }

        @Override
        public void onIQCRejected(String IQCMessage) {

        }
    };

    @Nullable
    @Override
    public View onCreateView(@NonNull String name, @NonNull Context context, @NonNull AttributeSet attrs) {
        return super.onCreateView(name, context, attrs);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        context = this;
        Intent requestIntent = getIntent();
        StaticVars.btbpConfig = (BTBPConfig) requestIntent.getSerializableExtra("btbpCameraConfig");
        StaticVars.appConfig = (AppConfig) requestIntent.getSerializableExtra("appConfig");
        BTBP.mirrorCallbacks = mirrorCallback;

        ViewPump.init(ViewPump.builder()
                .addInterceptor(new CalligraphyInterceptor(
                        new CalligraphyConfig.Builder()
                                .setDefaultFontPath("font/roboto_regular.ttf")
                                .setFontAttrId(R.attr.fontPath)
                                .build()))
                .build());
        getWindow().requestFeature(Window.FEATURE_NO_TITLE);
        getWindow().addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN);
        getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_WATCH_OUTSIDE_TOUCH, WindowManager.LayoutParams.FLAG_WATCH_OUTSIDE_TOUCH);
        setContentView(R.layout.activity_auto_capture);
        init();
    }

    private void init() {
        autoCaptureFragment = (AutoCaptureFragment) getFragmentManager().findFragmentById(R.id.auto_capture_fragment);
        resultFragment = (ResultFragment) getFragmentManager().findFragmentById(R.id.result_fragment);
        resultFragment.getView().setVisibility(View.GONE);
        Button sampleToggleBtn = (Button) findViewById(R.id.toggleButton_Sample);
        sampleToggleBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                autoCaptureFragment.onAutoCaptureClicked(v);
            }
        });
    }

    public void showAutoCaptureFragment() {
        resultFragment.getView().setVisibility(View.GONE);
        autoCaptureFragment.retakeImage();
        autoCaptureFragment.getView().setVisibility(View.VISIBLE);
        autoCaptureFragment.getView().bringToFront();
    }

    @Override
    protected void attachBaseContext(Context newBase) {
        super.attachBaseContext(ViewPumpContextWrapper.wrap(newBase));
        MultiDex.install(this);
    }

    @Override
    public void onBackPressed() {
        super.onBackPressed();
        mirrorCallback.onError(BTBP.ERROR_BACK_BUTTON_PRESSED);
    }
}
