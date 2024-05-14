package com.example.clarity_mirror;

import android.Manifest;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;
import androidx.multidex.MultiDex;

import org.btbp.btbplibrary.AppConfig;
import org.btbp.btbplibrary.BTBP;
import org.btbp.btbplibrary.LicenseError;
import org.btbp.btbplibrary.Utilities.AppConfigKeys;
import org.btbp.btbplibrary.Utilities.SharedPreferenceKeys;
import org.btbp.btbplibrary.Utilities.SharedPreferenceUtils;
import org.btbp.btbplibrary.Utilities.Utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import License.LicenseInfo;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.github.inflationx.calligraphy3.CalligraphyConfig;
import io.github.inflationx.calligraphy3.CalligraphyInterceptor;
import io.github.inflationx.viewpump.ViewPump;
import io.github.inflationx.viewpump.ViewPumpContextWrapper;

public class MainActivity extends FlutterActivity {
    Context context;
    private static final String CHANNEL = "camera_ai_channel";
    private final String clientId = "BTBP";
    private final String key = "PORP-UDGU-KVMG-6TLM";
    private final AppConfig appConfig = new AppConfig();
    public static final int REQUEST_ID_MULTIPLE_PERMISSIONS = 7;
    private final HashMap<String, String> hashMap = new HashMap<>();
    private static final int REQUEST_CODE = 120;

    private final String[][] btbpTags = {
            //Display Name, Score tag, image tag
            {"Acne", "ACNE_SEVERITY_SCORE_FAST", "ACNE_IMAGE_FAST"},
            {"Wrinkles", "WRINKLES_SEVERITY_SCORE_FAST", "WRINKLES_IMAGE_FAST"},
            {"Redness", "REDNESS_SEVERITY_SCORE_FAST", "REDNESS_IMAGE_FAST"},
            {"DarkCircles", "DARK_CIRCLES_SEVERITY_SCORE_FAST", "DARK_CIRCLES_IMAGE_FAST"},
            {"Spots", "SPOTS_SEVERITY_SCORE_FAST", "SPOTS_IMAGE_FAST"},
            {"UnevenSkinTone", "UNEVEN_SKINTONE_SEVERITY_SCORE_FAST", "UNEVEN_SKINTONE_IMAGE_FAST"},
            {"Dehydration", "DEHYDRATION_SEVERITY_SCORE_FAST", "DEHYDRATION_CONTOURS_COLORIZED_IMAGE_FAST"},
            {"Oiliness", "SHININESS_SEVERITY_SCORE_FAST", "SHININESS_IMAGE_FAST"},
            {"Pores", "PORES_SEVERITY_SCORE_FAST", "PORES_IMAGE_FAST", "FACIALHAIRTYPE", "HAIRLOSSLEVEL", "HAIRTYPE"}
    };

    private final List<String> selectedTags = new ArrayList<>();
    private final String[] flexibleOptions = {"Show Instructions", "isAutoCapture", "Show Gallery", "Show Toggle Camera", "Show ResultPanel Shift Control", "Show ResetButton", "Show Results", "Show AutoCaptureControl", "Show Camera Button", "Show Image ok Button", "show Retake Button", "Show Analysis Loader", "Enable Async Service Call"};

    BTBP.LicenseStatusCallback licenseStatusCallback = new BTBP.LicenseStatusCallback() {
        @Override
        public void onError(int errorCode) {
            if (errorCode != BTBP.ERROR_BACK_BUTTON_PRESSED) {
                String msg = getMessage(errorCode);
                Utils.showAlert(context, msg);
                Log.d("", "onError: " + msg);
            }
        }

        @Override
        public void onLicenseError(LicenseError licenseError) {
            showLicenseFailedMessage(licenseError);
        }

        @Override
        public void onLicenseAvailable(LicenseInfo licenseInfo) {
            openMainActivity();
        }

        @Override
        public void onLicenseWarning(LicenseInfo licenseInfo) {
            try {
                String msg = "Your License will expire within " + licenseInfo.getAppLicense().getNumberOfDays() + " days";
                Toast.makeText(context, msg, Toast.LENGTH_LONG).show();
                openMainActivity();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        private void showLicenseFailedMessage(LicenseError licenseError) {
            String message = licenseError.getErrorCode() + "\n " + licenseError.getErrorMessage();
            Utils.showAlert(context, message);
        }
    };

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("openAICamera") || call.method.equals("startNewActivity")) {
                                Log.d("Native method", "Native method invoked from flutter code");
                                try {
                                    BTBP.checkLicense(context, key, clientId, licenseStatusCallback);
                                    result.success(null);
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            checkAndRequestPermissions();
        }

        ViewPump.init(ViewPump.builder()
                .addInterceptor(new CalligraphyInterceptor(
                        new CalligraphyConfig.Builder()
                                .setDefaultFontPath("font/roboto_regular.ttf")
                                .setFontAttrId(R.attr.fontPath)
                                .build()))
                .build());

        init();
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == REQUEST_CODE) {
            if (resultCode == RESULT_OK) {
                Log.d("", "Initialized");
            }
        }
    }

    private void checkAndRequestPermissions() {
        int camera = ContextCompat.checkSelfPermission(this, Manifest.permission.CAMERA);
        int write = ContextCompat.checkSelfPermission(this, Manifest.permission.WRITE_EXTERNAL_STORAGE);
        int read = ContextCompat.checkSelfPermission(this, Manifest.permission.READ_EXTERNAL_STORAGE);
        int location = ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION);
        List<String> listPermissionsNeeded = new ArrayList<>();

        if (write != PackageManager.PERMISSION_GRANTED) {
            listPermissionsNeeded.add(Manifest.permission.WRITE_EXTERNAL_STORAGE);
        }
        if (camera != PackageManager.PERMISSION_GRANTED) {
            listPermissionsNeeded.add(Manifest.permission.CAMERA);
        }
        if (read != PackageManager.PERMISSION_GRANTED) {
            listPermissionsNeeded.add(Manifest.permission.READ_EXTERNAL_STORAGE);
        }
        if (location != PackageManager.PERMISSION_GRANTED) {
            listPermissionsNeeded.add(Manifest.permission.ACCESS_FINE_LOCATION);
        }
        if (!listPermissionsNeeded.isEmpty()) {
            ActivityCompat.requestPermissions(this,
                    listPermissionsNeeded.toArray(new String[0]), REQUEST_ID_MULTIPLE_PERMISSIONS);
        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode,
                                           @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        Log.d("in fragment on request", "Permission callback called-------");
        if (requestCode == REQUEST_ID_MULTIPLE_PERMISSIONS) {
            Map<String, Integer> perms = new HashMap<>();

            // Initialize the map with both permissions
            perms.put(Manifest.permission.READ_PHONE_STATE, PackageManager.PERMISSION_GRANTED);
            perms.put(Manifest.permission.CAMERA, PackageManager.PERMISSION_GRANTED);
            perms.put(Manifest.permission.READ_EXTERNAL_STORAGE, PackageManager.PERMISSION_GRANTED);
            perms.put(Manifest.permission.ACCESS_FINE_LOCATION, PackageManager.PERMISSION_GRANTED);

            // Fill with actual results from user
            if (grantResults.length > 0) {
                for (int i = 0; i < permissions.length; i++)
                    perms.put(permissions[i], grantResults[i]);

                // Check for both permissions
                if (perms.get(Manifest.permission.READ_PHONE_STATE) == PackageManager.PERMISSION_GRANTED
                        && perms.get(Manifest.permission.CAMERA) == PackageManager.PERMISSION_GRANTED
                        && perms.get(Manifest.permission.CAMERA) == PackageManager.PERMISSION_GRANTED
                        && perms.get(Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED) {
                    Log.d("in fragment on request", "CAMERA & WRITE_EXTERNAL_STORAGE READ_EXTERNAL_STORAGE permission granted");
                } else {
                    Log.d("in fragment on request", "Some permissions are not granted ask again ");
                    if (ActivityCompat.shouldShowRequestPermissionRationale(this,
                            Manifest.permission.READ_PHONE_STATE) || ActivityCompat.shouldShowRequestPermissionRationale(this,
                            Manifest.permission.ACCESS_FINE_LOCATION) || ActivityCompat.shouldShowRequestPermissionRationale(this,
                            Manifest.permission.CAMERA) || ActivityCompat.shouldShowRequestPermissionRationale(this,
                            Manifest.permission.READ_EXTERNAL_STORAGE)) {
                        showDialogOK(
                                (dialog, which) -> {
                                    switch (which) {
                                        case DialogInterface.BUTTON_POSITIVE:
                                            checkAndRequestPermissions();
                                            break;
                                        case DialogInterface.BUTTON_NEGATIVE:
                                            break;
                                    }
                                });
                    }
                    //permission is denied (and never ask again is  checked)
                    //shouldShowRequestPermissionRationale will return false
                    else {
                        Toast.makeText(this, "Go to settings and enable permissions", Toast.LENGTH_LONG)
                                .show();
                    }
                }
            }
        }
    }

    private void showDialogOK(DialogInterface.OnClickListener okListener) {
        new AlertDialog.Builder(this)
                .setMessage("Camera and Storage Permission required for this app")
                .setPositiveButton("OK", okListener)
                .setNegativeButton("Cancel", okListener)
                .create()
                .show();
    }

    @Override
    protected void attachBaseContext(Context newBase) {
        super.attachBaseContext(ViewPumpContextWrapper.wrap(newBase));
        MultiDex.install(this);
    }

    private void init() {
        context = this;

        setYourOwnMessageStrings();
        setYourOwnDrawables();
        addBTBPFastTags();
    }

    private void openMainActivity() {
        if (Utils.isOnline(context)) {
            BTBP.hashMapString = hashMap;
            BTBP.licenseStatusCallback = licenseStatusCallback;
            SharedPreferenceUtils.setSharedPreferenceValue(context, SharedPreferenceKeys.KEY, key);

            Intent intent = new Intent(this, AutoCaptureActivity.class);
            intent.putExtra("BTBPTags", (ArrayList<String>) selectedTags);
            intent.putExtra(AppConfigKeys.LANG_CODE, "en-US");
            intent.putExtra("AllBTBPTags", btbpTags);
            intent.putExtra("appConfig", appConfig);
            startActivity(intent);
        } else {
            String msg = "Please check your internet connection and try again";
            DialogInterface.OnClickListener okListener = (dialogInterface, i) -> {

            };
            DialogInterface.OnClickListener tryAgainListener = (dialogInterface, i) -> {
                try {
                    openMainActivity();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            };
            Utils.showAlert(context, msg, "Ok", okListener, "Retry", tryAgainListener);
        }
    }

    private void addBTBPFastTags() {
        for (int i = 0; i < btbpTags.length; i++) {
            selectedTags.add(btbpTags[i][1]);

            if (btbpTags[i].length == 3) {
                selectedTags.add(btbpTags[i][2]);
            }
        }
    }

    private String getMessage(int errorCode) {
        String msg = "UnKnown";
        switch (errorCode) {
            case BTBP.IMAGE_REJECTED:
                msg = "Image has been rejected please try again";
                break;
            case BTBP.IMAGE_REJECTED_FROM_SERVER:
                msg = "Image has been rejected please try again";
                break;
            case BTBP.IMAGE_ANALYSIS_FAILED:
                msg = "Image analysis has failed, Please ensure good internet connection and try again";
                break;
            case BTBP.ERROR_LOW_BATTERY:
                msg = "Low Battery, can't open camera.";
                break;
            case BTBP.MirrorCallback.ERROR_CAMERA_NOT_AVAILABLE:
                msg = "Camera not available or busy.";
                break;
            case BTBP.MirrorCallback.ERROR_CAMERA_ACCESS_DENIED:
                msg = "Camera access denied.";
                break;
            case BTBP.MirrorCallback.ERROR_STORAGE_ACCESS_DENIED:
                msg = "Write External Storage permission denied";
                break;
            case BTBP.MirrorCallback.ERROR_IMAGE_DISPLAY:
                msg = "unable to display image.";
                break;
            case BTBP.ERROR_BAD_REQUEST:
                msg = "Bad Request to server";
                break;
            case BTBP.ERROR_ACCESS_DENIED:
                msg = "Access denied.";
                break;
            case BTBP.ERROR_INTERNAL:
                msg = "Internal error occurred.";
                break;
            case BTBP.ERROR_INSUFFICIENT_STORAGE:
                msg = "Insufficient storage";
                break;
            case BTBP.ERROR_BACK_BUTTON_PRESSED:
                msg = "On back button pressed";
                break;
        }
        return msg;
    }

    private void setYourOwnMessageStrings() {
        hashMap.put(BTBP.Strings.HOW_TO_PREPARE_FOR_YOUR_PHOTO, "How to prepare for your photo");
        hashMap.put(BTBP.Strings.RESET_ALERT, "Are you sure you want to reset ?");
        hashMap.put(BTBP.Strings.NO, "No");
        hashMap.put(BTBP.Strings.YES, "Yes");
        hashMap.put(BTBP.Strings.INSTRUCTIONS_TITLE, "Instructions");
        hashMap.put(BTBP.Strings.INSTRUCTION1, "Remove Makeup & glasses");
        hashMap.put(BTBP.Strings.INSTRUCTION2, "Pull your hair back");
        hashMap.put(BTBP.Strings.INSTRUCTION3, "Ensure even lighting on face");
        hashMap.put(BTBP.Strings.INSTRUCTION4, "Align face correctly");
        hashMap.put(BTBP.Strings.AUTO_CAPTURE_MODE, "Auto Capture Mode");
        hashMap.put(BTBP.Strings.MANUAL_CAPTURE_MODE, "Manual Capture Mode");
        hashMap.put(BTBP.Strings.ON, "ON");
        hashMap.put(BTBP.Strings.OK, "Ok");
        hashMap.put(BTBP.Strings.RETAKE, "Retake");
        hashMap.put(BTBP.Strings.FACE_NOT_DETECTED_TITLE, "We could not detect your face.");
        hashMap.put(BTBP.Strings.FACE_NOT_DETECTED_REASON, "Please align yourself with the camera preview");
        hashMap.put(BTBP.Strings.FACE_IS_TOO_FAR_TITLE, "Your face is too far away.");
        hashMap.put(BTBP.Strings.FACE_IS_TOO_FAR_REASON, "Please move closer to the camera");
        hashMap.put(BTBP.Strings.FACE_IS_TOO_CLOSE_TITLE, "Your face is too close to the camera.");
        hashMap.put(BTBP.Strings.FACE_IS_TOO_CLOSE_REASON, "Please move further away from the camera");
        hashMap.put(BTBP.Strings.YOUR_MOUTH_IS_OPEN_TITLE, "Your mouth is open.");
        hashMap.put(BTBP.Strings.YOUR_MOUTH_IS_OPEN_REASON, "Please keep a neutral expression");
        hashMap.put(BTBP.Strings.FACE_IS_TOO_DARK_TITLE, "The photo is too dark.");
        hashMap.put(BTBP.Strings.FACE_IS_TOO_DARK_REASON, "Please use a brighter environment.");
        hashMap.put(BTBP.Strings.FACE_NOT_CENTER_ALIGNED_TITLE, "Your face is not centrally aligned.");
        hashMap.put(BTBP.Strings.FACE_NOT_CENTER_ALIGNED_REASON, "Please adjust position of your face");
        hashMap.put(BTBP.Strings.HEAD_TILT_LEFT_TITLE, "Your face is rotated toward the left.");
        hashMap.put(BTBP.Strings.HEAD_TILT_LEFT_REASON, "Please straighten and center it");
        hashMap.put(BTBP.Strings.HEAD_TILT_RIGHT_TITLE, "Your face is rotated toward the right.");
        hashMap.put(BTBP.Strings.HEAD_TILT_RIGHT_REASON, "Please straighten and center it");
        hashMap.put(BTBP.Strings.UNEVENLY_LIT_OR_BLURRY_TITLE, "The photo is unevenly lit or blurry.");
        hashMap.put(BTBP.Strings.UNEVENLY_LIT_OR_BLURRY_REASON, "Please use an even lighting environment and stay still.");
        hashMap.put(BTBP.Strings.HEAD_TILTED_UPWARD_TITLE, "Your face is tilted upward.");
        hashMap.put(BTBP.Strings.HEAD_TILTED_UPWARD_REASON, "Please face the camera directly");
        hashMap.put(BTBP.Strings.HEAD_TILTED_DOWNWARD_TITLE, "Your face is tilted downward.");
        hashMap.put(BTBP.Strings.HEAD_TILTED_DOWNWARD_REASON, "Please face the camera directly");
        hashMap.put(BTBP.Strings.ROTATED_TOWARD_LEFT_TITLE, "Your face is rotated toward the left.");
        hashMap.put(BTBP.Strings.ROTATED_TOWARD_LEFT_REASON, "Please face the camera directly");
        hashMap.put(BTBP.Strings.ROTATED_TOWARD_RIGHT_TITLE, "Your face is rotated toward the right.");
        hashMap.put(BTBP.Strings.ROTATED_TOWARD_RIGHT_REASON, "Please face the camera directly");
        hashMap.put(BTBP.Strings.UNEVENLY_LIT_ON_THE_FOREHEAD_TITLE, "Your face is unevenly lit on the forehead.");
        hashMap.put(BTBP.Strings.UNEVENLY_LIT_ON_THE_FOREHEAD_REASON, "Please ensure an even lighting environment");
        hashMap.put(BTBP.Strings.FACE_HAS_LEFT_TO_RIGHT_GRADIENT_TITLE, "Your face is unevenly lit left to right.");
        hashMap.put(BTBP.Strings.FACE_HAS_LEFT_TO_RIGHT_GRADIENT_REASON, "Please ensure an even lighting environment");
        hashMap.put(BTBP.Strings.FACE_HAS_TOP_TO_BOTTOM_GRADIENT_TITLE, "Your face is unevenly lit top to bottom.");
        hashMap.put(BTBP.Strings.FACE_HAS_TOP_TO_BOTTOM_GRADIENT_REASON, "Please ensure an even lighting environment");
        hashMap.put(BTBP.Strings.FACE_IS_TOO_BRIGHT_TITLE, "Your photo is too bright and may be over saturated.");
        hashMap.put(BTBP.Strings.FACE_IS_TOO_BRIGHT_REASON, "Please ensure an even lighting environment");
        hashMap.put(BTBP.Strings.LEFT_SIDE, "Left Side");
        hashMap.put(BTBP.Strings.RIGHT_SIDE, "Right Side");
        hashMap.put(BTBP.Strings.ANALYZING, "Analyzing...");
        hashMap.put(BTBP.Strings.IMAGE_HAS_BEEN_REJECTED_PLEASE_TRY_AGAIN, "Image has been rejected, Please try again");
        hashMap.put(BTBP.Strings.ALERT_PLEASE_WAIT, "Please Wait...");
        hashMap.put(BTBP.Strings.CAMERA_GUIDELINE, "For the best results frame your face within the red box");
        hashMap.put(BTBP.Strings.CAMERA_SETTINGS, "For the best results frame your face within the red box");
        hashMap.put(BTBP.Strings.INITIALIZATION, "Initializing...");
        hashMap.put(BTBP.Strings.ALERT_CHECK_INTERNET_CONNECTION, "Please check your internet connection or try again later");
        hashMap.put(BTBP.Strings.ALERT_INTERNET_CONNECTION_LOST, "Please check your internet connection");
        hashMap.put(BTBP.Strings.CAN_NOT_RUN_APPLICATION_CAMERA_PERMISSION_DENIED, "Can not run the application because camera service permission not granted!");
        hashMap.put(BTBP.Strings.CAN_NOT_RUN_APPLICATION_EXTERNAL_STORAGE_PERMISSION_DENIED, "Can not run the application because write external storage service permission not granted!");

        hashMap.put(BTBP.Strings.DARK_CIRCLES, "DARK CIRCLES");
        hashMap.put(BTBP.Strings.WRINKLES, "WRINKLES");
        hashMap.put(BTBP.Strings.PORES, "PORES");
        hashMap.put(BTBP.Strings.UNEVEN_SKINTONE, "UNEVEN SKINTONE");
        hashMap.put(BTBP.Strings.OILINESS, "OILINESS");
        hashMap.put(BTBP.Strings.ACNE, "ACNE");
        hashMap.put(BTBP.Strings.REDNESS, "REDNESS");
        hashMap.put(BTBP.Strings.DEHYDRATION, "DEHYDRATION");
        hashMap.put(BTBP.Strings.LIP_ROUGHNESS, "LIP ROUGHNESS");
        hashMap.put(BTBP.Strings.LIP_HEALTH, "LIP HEALTH");
        hashMap.put(BTBP.Strings.SPOTS, "SPOTS");
    }

    private void setYourOwnDrawables() {
        BTBP.drawable.toggle_camera = R.drawable.toggle_camera;
        BTBP.drawable.instruction1 = R.drawable.instruction1;
        BTBP.drawable.instruction2 = R.drawable.instruction2;
        BTBP.drawable.instruction3 = R.drawable.instruction3;
        BTBP.drawable.instruction4 = R.drawable.instruction4;
        BTBP.drawable.close_instructions_btn = R.drawable.close_instructions_btn;
        BTBP.drawable.gallery_icon_skincare = R.drawable.gallery_icon_skincare;
        BTBP.drawable.capture_icon_skincare = R.drawable.capture_icon_skincare;
        BTBP.drawable.switch_cam_skincare = R.drawable.switch_cam_skincare;
        BTBP.drawable.instruction_border_for_toggle = R.drawable.instruction_border_for_toggle;
        BTBP.drawable.customswitchselector = R.drawable.customswitchselector;
        BTBP.drawable.custom_track = R.drawable.custom_track;
        BTBP.drawable.auto_feedback_text_gb = R.drawable.auto_feedback_text_gb;
        BTBP.drawable.outline_red = R.drawable.outline_red;
        BTBP.drawable.gallery = R.drawable.gallery;
        BTBP.drawable.camera_click = R.drawable.camera_click;
        BTBP.drawable.outline_orange = R.drawable.outline_orange;
        BTBP.drawable.outline_green = R.drawable.outline_green;
    }
}
