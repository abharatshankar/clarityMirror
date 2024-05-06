package com.example.clarity_mirror;
import static org.btbp.btbplibrary.BTBP.licenseStatusCallback;
//import static org.btbp.btbplibrary.
import android.Manifest;
import android.annotation.SuppressLint;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;
import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContracts;
import org.btbp.btbplibrary.AppConfig;
import org.btbp.btbplibrary.BTBP;
import org.btbp.btbplibrary.LicenseError;
import org.btbp.btbplibrary.Utilities.AppConfigKeys;
import org.btbp.btbplibrary.Utilities.SharedPreferenceKeys;
import org.btbp.btbplibrary.Utilities.SharedPreferenceUtils;
import org.btbp.btbplibrary.Utilities.Utils;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import License.LicenseInfo;
import io.flutter.plugin.platform.PlatformView;
import android.hardware.Camera;
public class ExistingActivityView implements PlatformView {
    private final Context context;
    private final View view;
    //    private final SplashScreenActivity activity;
    ViewGroup deepTagLayout;
    Button startBtn;
    private static final int CAMERA_PERMISSION_REQUEST_CODE = 100;
    private ActivityResultLauncher<String> requestPermissionLauncher;

    private Camera mCamera;
    private SurfaceView mSurfaceView;
    private SurfaceHolder mSurfaceHolder;
    private boolean isPreviewing = false;
    @SuppressLint("MissingInflatedId")
    public ExistingActivityView(Context context) {
        this.context = context;
        LayoutInflater inflater = LayoutInflater.from(context);
        View view = inflater.inflate(R.layout.custom, null, false);
        this.view = view;
        mSurfaceView = view.findViewById(R.id.surfaceView);
        mSurfaceHolder = mSurfaceView.getHolder();

//        initData();
        startBtn = view.findViewById(R.id.my_button);
        startBtn.setOnClickListener(v -> {
            /*Intent intent = new Intent(context, SplashScreenActivity.class);
            context.startActivity(intent);*/
            openCamera();
        });

        Button captureButton = view.findViewById(R.id.capture_button);
        captureButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (isPreviewing) {
                    takePicture();
                }
            }
        });
    }

    @Override
    public View getView() {
//        return view;
//        Intent intent = new Intent(context, SplashScreenActivity.class);
//        context.startActivity(intent);
//        return new View(activity);
        return view;
    }

    @Override
    public void dispose() {
        // Clean up resources if needed
    }


    private void openCamera() {
        if (mCamera == null) {
            try {
                mCamera = Camera.open();
                mCamera.setPreviewDisplay(mSurfaceHolder);
                mCamera.startPreview();
                isPreviewing = true;
            } catch (IOException e) {
                Toast.makeText(context, "Error opening the camera", Toast.LENGTH_SHORT).show();
            }
        }
    }

    private void takePicture() {
        if (mCamera != null) {
            mCamera.takePicture(null, null, mPictureCallback);
        }
    }

    private Camera.PictureCallback mPictureCallback = new Camera.PictureCallback() {
        @Override
        public void onPictureTaken(byte[] data, Camera camera) {
            // Save or process the captured image data here
            // For example, you can save it to a file or display it in an ImageView
            // After capturing the image, restart the preview
            camera.startPreview();
        }
    };

}


