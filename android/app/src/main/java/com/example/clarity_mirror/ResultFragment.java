package com.example.clarity_mirror;

import static android.view.View.GONE;

import android.app.Fragment;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.os.Handler;
import android.util.Base64;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AbsListView;
import android.widget.AdapterView;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.ProgressBar;
import android.widget.RelativeLayout;
import android.widget.Switch;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.Nullable;

import com.example.clarity_mirror.Adapters.ResultListAdapter;
import com.example.clarity_mirror.Models.SkinConcern;

import org.btbp.btbplibrary.AppConfig;
import org.btbp.btbplibrary.Models.ServiceResponse;
import org.btbp.btbplibrary.ServiceManager;
import org.btbp.btbplibrary.TouchImageView;
import org.btbp.btbplibrary.Utilities.BitmapUtils;
import org.btbp.btbplibrary.Utilities.StaticVars;
import org.btbp.btbplibrary.Utilities.Utils;
import org.json.JSONArray;
import org.json.JSONObject;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class ResultFragment extends Fragment implements ServiceManager.ServiceCallBacks {
    private static final String TAG = "Result Fragment";
    private ViewGroup rootView;
    private RelativeLayout rejectionRl, previewButtonRL;
    private LinearLayout previewButtonLL, analyzingLL; //
    private TextView rejTitleTxt, rejDescriptionTxt;
    private ImageView previewImage, okBtnImage, retakeImgBtn;
    private final BitmapUtils bitmapUtils = new BitmapUtils();

    //Results view variables
    Context context;
    private TouchImageView concernImageLayout;
    private LinearLayout corcernImageParentLL;
    public LinearLayout skinFeatureParentLL;
    private ResultListAdapter adapter;
    private ListView skinFeatureListView;
    List<SkinConcern> skinConcernList = new ArrayList<>();
    private List<String> requestedTags = new ArrayList<>();
    private String[][] allBTBPTags;
    private AppConfig appConfig;
    private boolean isShowResults = true;
    boolean serviceStarted = true;
    private boolean isAysncServiceCall = true;
    boolean isSkinAnalysisCompleted = false;
    private boolean isResultPanelControl = true;
    private RelativeLayout analysisLayout, resultDisplayRL, panelShiftLayout;
    private ImageView resultPanelshiftBtn, resultResetBTn, panelShiftBtn;

    //upload and process variables
    private ProgressDialog pd;
    ProgressBar analysisPb;
    Switch panelPositionControlSW;
    private String imagePath = "";
    String imageId = "";
    private Utils utils;
    ServiceManager serviceManager;

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        context = getActivity();
    }

    @Override
    public void onActivityCreated(@Nullable Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        getActivity().setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
        initialize();
        initResultView();
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, Bundle savedInstanceState) {
        rootView = (ViewGroup) inflater.inflate(R.layout.result_fragment, container, false);
        return rootView;
    }

    private void initialize() {
        utils = new Utils(context);
        Intent requestIntent = getActivity().getIntent();
        requestedTags = (ArrayList<String>) requestIntent.getSerializableExtra("BTBPTags");
        allBTBPTags = (String[][]) requestIntent.getSerializableExtra("AllBTBPTags");
        appConfig = (AppConfig) requestIntent.getSerializableExtra("appConfig");
        if (appConfig == null) {
            appConfig = new AppConfig();
        }
        previewButtonRL = rootView.findViewById(R.id.preivew_buttons1);
        rejectionRl = rootView.findViewById(R.id.rejction_layout);
        previewButtonLL = rootView.findViewById(R.id.preview_buttonLL);
        analyzingLL = rootView.findViewById(R.id.analyzing_txt_LL);
        previewImage = rootView.findViewById(R.id.preview_image_view);
        rejTitleTxt = rootView.findViewById(R.id.rej_title);
        rejDescriptionTxt = rootView.findViewById(R.id.rej_des);
        okBtnImage = rootView.findViewById(R.id.accept_btn);
        retakeImgBtn = rootView.findViewById(R.id.retakeImage_btn);

        concernImageLayout = rootView.findViewById(R.id.analysisResultImage);
        corcernImageParentLL = rootView.findViewById(R.id.concern_image_LL);
        skinFeatureParentLL = rootView.findViewById(R.id.skin_feature_LL);
        panelShiftLayout = rootView.findViewById(R.id.panel_shift_layoutRL);
        panelShiftBtn = rootView.findViewById(R.id.panel_shift_control);
        resultDisplayRL = rootView.findViewById(R.id.resultSettings);
        resultPanelshiftBtn = rootView.findViewById(R.id.result_panel_control);
        resultResetBTn = rootView.findViewById(R.id.resetButton_btn);
        skinFeatureListView = rootView.findViewById(R.id.skinFeaturesLV);
        analysisLayout = (RelativeLayout) rootView.findViewById(R.id.analysis_linear_layout);
        analysisPb = (ProgressBar) rootView.findViewById(R.id.analysing_pb);
        panelPositionControlSW = (Switch) rootView.findViewById(R.id.panel_shift_sw);

        isResultPanelControl = appConfig.isResultPanelControl();
        isShowResults = appConfig.isShowResults();
        isAysncServiceCall = appConfig.isEnableAsyncServiceCall();
        boolean isResetButton = appConfig.isResetButton();


        okBtnImage.setOnClickListener(view -> okButtonClicked());
        retakeImgBtn.setOnClickListener(view -> retakeImage());

        if (isResetButton) {
            resultResetBTn.setVisibility(View.VISIBLE);
        } else {
            resultResetBTn.setVisibility(GONE);
        }

        if (resultPanelshiftBtn != null) {
            if (isResultPanelControl && isShowResults) {
                resultPanelshiftBtn.setVisibility(View.VISIBLE);
            } else {
                resultPanelshiftBtn.setVisibility(View.GONE);
            }
        }
    }

    private void okButtonClicked() {
        okBtnImage.setEnabled(false);
        retakeImgBtn.setEnabled(false);
        previewButtonLL.setVisibility(View.INVISIBLE);
        okBtnImage.setVisibility(View.INVISIBLE);
        retakeImgBtn.setVisibility(View.INVISIBLE);

        Handler handler = new Handler();
        handler.postDelayed(() -> {
            okBtnImage.setEnabled(true);
            retakeImgBtn.setEnabled(true);
        }, 200);

        //asynch change 1
        if (isAysncServiceCall) {
            skinFeatureParentLL.setVisibility(View.VISIBLE);
        }

        if (appConfig.isAnalysisLoaderDisplayed()) {
            analyzingLL.setVisibility(View.VISIBLE);
        }
        onUploadImage();
    }

    private void retakeImage() {
        StaticVars.isAnalysisFailed = false;
        isSkinAnalysisCompleted = false;

        okBtnImage.setEnabled(false);
        retakeImgBtn.setEnabled(false);

        Handler handler = new Handler();
        handler.postDelayed(() -> {
            okBtnImage.setEnabled(true);
            retakeImgBtn.setEnabled(true);
        }, 200);

        skinConcernList = getSkinConcernList();

        resetCamera();
        showAutoCaptureFragment();
        openCamera();

    }

    public void showImage(String ImagePath, int width, int height, int cameraId, String instantIQCFeedBack, boolean isFromGallery) {

        imagePath = ImagePath;
        Bitmap previewBitmapIm = bitmapUtils.getResizedBitmap(ImagePath, width, height, cameraId, isFromGallery);
        String rejectTitle = getResources().getString(R.string.face_not_detected_msg);
        String rejectMsg = getResources().getString(R.string.face_not_detected_reason);
        if (instantIQCFeedBack != null && instantIQCFeedBack.length() > 0) {
            String[] str = instantIQCFeedBack.split("\n");
            if (str.length > 1) {
                rejectMsg = str[1];
                rejectTitle = str[0];
                rejectionRl.setVisibility(View.VISIBLE);
                rejDescriptionTxt.setVisibility(View.VISIBLE);
                rejTitleTxt.setVisibility(View.VISIBLE);
            }
            rejDescriptionTxt.setText(rejectMsg);
            rejTitleTxt.setText(rejectTitle);
            okBtnImage.setVisibility(GONE);
        } else {
            rejectionRl.setVisibility(GONE);
            okBtnImage.setVisibility(View.VISIBLE);
        }

        //okBtnImage.setVisibility(View.VISIBLE);
        okBtnImage.setEnabled(true);
        retakeImgBtn.setEnabled(true);

        previewImage.setImageBitmap(previewBitmapIm);
        previewButtonRL.setVisibility(View.VISIBLE);
        previewButtonLL.setVisibility(View.VISIBLE);
        analyzingLL.setVisibility(View.GONE);
        //if (appConfig.isRetakeButtonDisplayed()) {
        retakeImgBtn.setVisibility(View.VISIBLE);
        releaseCamera();
        //}
    }

    //result display methods
    private void initResultView() {


        skinFeatureParentLL.setVisibility(GONE);
        analysisLayout.bringToFront();

        Utils.updateAnalysisProgressBarColor(context, analysisPb);

        //result setting
        //panel shift and auto capture mode shift elements


        panelShiftBtn.setOnClickListener(view -> {
            panelShiftBtn.setVisibility(View.INVISIBLE);
            panelShiftLayout.setVisibility(GONE);
            if (isResultPanelControl) {
                resultPanelshiftBtn.setVisibility(View.VISIBLE);
            }
        });


        resultPanelshiftBtn.setOnClickListener(view -> {
            panelShiftLayout.setVisibility(View.VISIBLE);
            panelShiftBtn.setVisibility(View.VISIBLE);
            resultPanelshiftBtn.setVisibility(View.INVISIBLE);
        });

        resultResetBTn.setOnClickListener(view -> {
            String msg = getResources().getString(R.string.are_you_sure_do_you_want_to_reset_results);
            DialogInterface.OnClickListener okListener = (dialogInterface, i) -> resetClicked();
            DialogInterface.OnClickListener tryAgainListener = (dialogInterface, i) -> {
            };
            Utils.showAlert(context, msg, getResources().getString(R.string.yes), okListener, getResources().getString(R.string.no), tryAgainListener);
        });

        panelPositionControlSW.setOnCheckedChangeListener((buttonView, isChecked) -> {
            try {
                RelativeLayout.LayoutParams layoutParams = (RelativeLayout.LayoutParams) skinFeatureParentLL.getLayoutParams();
                if (isChecked) {
                    layoutParams.addRule(RelativeLayout.ALIGN_PARENT_LEFT, 0);
                    layoutParams.addRule(RelativeLayout.ALIGN_PARENT_RIGHT, 1);
                    skinFeatureParentLL.setLayoutParams(layoutParams);
                    skinFeatureListView.setBackground(getResources().getDrawable(R.drawable.linear_layout_border_skin_feature_right_side));
                    skinFeatureListView.setVerticalScrollbarPosition(1);
                } else {
                    layoutParams.addRule(RelativeLayout.ALIGN_PARENT_RIGHT, 0);
                    layoutParams.addRule(RelativeLayout.ALIGN_PARENT_LEFT, 1);
                    skinFeatureParentLL.setLayoutParams(layoutParams);
                    skinFeatureListView.setBackground(getResources().getDrawable(R.drawable.linear_layout_border_skin_feature));
                    skinFeatureListView.setVerticalScrollbarPosition(0);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        });

        StaticVars.isResultUpdated = false;
        adapter = new ResultListAdapter(context, R.layout.skin_list_view, getSkinConcernList());
        skinFeatureListView.setAdapter(adapter);
        skinFeatureListView.setStackFromBottom(false);
        //skinFeatureListView.setTranscriptMode(ListView.TRANSCRIPT_MODE_NORMAL);
        skinFeatureListView.setChoiceMode(AbsListView.CHOICE_MODE_SINGLE);
        skinFeatureListView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int position, long l) {
                if (StaticVars.isResultUpdated) {
                    SkinConcern skinConcern = skinConcernList.get(position);
                    if (StaticVars.isResultUpdated) {
                        if (skinConcern.getConcernImage() != null && skinConcern.getConcernImage().length() > 0) {
                            byte[] data = Base64.decode(skinConcern.getConcernImage(), Base64.DEFAULT);
                            bitmapUtils.getResizedBitmap(data, StaticVars.width, StaticVars.height, concernImageLayout);
                            concernImageLayout.setVisibility(View.VISIBLE);
                            corcernImageParentLL.setVisibility(View.VISIBLE);
                        } else {
                            Toast.makeText(context, "Image is not available", Toast.LENGTH_SHORT).show();
                        }
                    }
                    adapter.selectedIndex = position;
                    adapter.notifyChange();
                }
            }
        });
    }


    private List<SkinConcern> getSkinConcernList() {
        skinConcernList.clear();
        if (requestedTags != null) {
            List<String> skinConcerns = new ArrayList<>();
            for (int i = 0; i < requestedTags.size(); i++) {
                String feature = getFeatureNameFromTag(requestedTags.get(i));
                if (!skinConcerns.contains(feature)) {
                    SkinConcern skinConcern = new SkinConcern();
                    skinConcern.setName(feature);
                    skinConcern.setSeverity("0");
                    skinConcern.setConcernImage(null);
                    skinConcernList.add(skinConcern);
                    skinConcerns.add(feature);
                }
            }
        }
        return skinConcernList;
    }

    private String isScoreTag(String tagName) {
        for (String[] allBTBPTag : allBTBPTags) {
            if (allBTBPTag[1].equalsIgnoreCase(tagName)) {
                return allBTBPTag[0];
            }
        }
        return "";
    }

    private String getFeatureNameFromTag(String tagName) {
        for (String[] allBTBPTag : allBTBPTags) {
            if (allBTBPTag[1].equalsIgnoreCase(tagName)
                    || (allBTBPTag.length == 3 && allBTBPTag[2].equalsIgnoreCase(tagName))) {
                return allBTBPTag[0];
            }
        }
        return "";
    }

    private String getMatchedScoreTag_FAST(String analyzedImageTagName, String scoreTagName) {
        for (int i = 0; i < allBTBPTags.length; i++) {
            if (allBTBPTags[i].length == 3) {
                String rs = allBTBPTags[i][2];
                if (rs.equalsIgnoreCase(analyzedImageTagName) == true) {
                    return allBTBPTags[i][1];
                }
            }
        }
        return "";
    }

    private void UpdateSkinListView() {
        if (!StaticVars.isResetClicked) {
            panelShiftLayout.setVisibility(GONE);
            resultDisplayRL.setVisibility(View.VISIBLE);
            skinFeatureParentLL.setVisibility(View.VISIBLE);
            if (isResultPanelControl && isShowResults) {
                resultPanelshiftBtn.setVisibility(View.VISIBLE);
            }
            panelShiftBtn.setVisibility(GONE);
            if (skinConcernList != null && skinConcernList.size() > 0) {
                if (isShowResults) {
                    adapter.updateSkinTagResults(skinConcernList);
                    //Log.d(TAG, "UpdateSkinListView: list view has been updated");
                    if (serviceStarted) {
                        selectAdapterItemByPosition();
                        serviceStarted = false;
                    }
                } else {
                    resetClicked();
                }
            }
        }
    }

    private void selectAdapterItemByPosition() {
        SkinConcern skinConcern = new SkinConcern();
        int selecPos = 0;
        for (int i = 0; i < skinConcernList.size(); i++) {
            if (skinConcernList.get(i).getConcernImage() != null) {
                skinConcern = skinConcernList.get(i);
                selecPos = i;
                break;
            } else {
                selecPos = 0;
            }
        }
        if (StaticVars.isResultUpdated) {
            if (skinConcern.getConcernImage() != null && skinConcern.getConcernImage().length() > 0) {
                byte[] data = Base64.decode(skinConcern.getConcernImage(), Base64.DEFAULT);
                bitmapUtils.getResizedBitmap(data, StaticVars.width, StaticVars.height, concernImageLayout);
                concernImageLayout.setVisibility(View.VISIBLE);
                corcernImageParentLL.setVisibility(View.VISIBLE);
            }
        }
        adapter.selectedIndex = selecPos;
        adapter.notifyChange();
        skinFeatureListView.setVerticalScrollbarPosition(selecPos);
        skinFeatureListView.smoothScrollToPosition(selecPos);
        serviceStarted = false;
    }

    private void onUploadImage() {
        if (utils.isOnline()) {
            serviceManager = new ServiceManager(this);
            Timestamp timestamp = new Timestamp(System.currentTimeMillis());
            Log.d(TAG, "onUploadImage: Time start service: " + timestamp);
            StaticVars.requestCodeTimeStamp = timestamp.getTime();
            boolean isImageRequiredForAnalysis = true;
            serviceManager.getBTBPTagsAsync(imagePath, timestamp.getTime(), requestedTags, isImageRequiredForAnalysis);
            //releaseCamera();
        } else {
            String msg = getResources().getString(R.string.alert_check_internet_connection);
            DialogInterface.OnClickListener tryAgainListener = (dialogInterface, i) -> onUploadImage();
            Utils.showAlert(context, msg, "Retry", tryAgainListener);
        }
    }

    public void hideAnalysisLoader() {
        analysisLayout.setVisibility(GONE);
    }

    private void onAnalysisFailed() {
        skinConcernList = getSkinConcernList();
        resultDisplayRL.setVisibility(View.VISIBLE);
        resetClicked();
        hideAnalysisLoader();
    }

    private void onImageRejected() {
        resultDisplayRL.setVisibility(View.VISIBLE);
        panelShiftLayout.setVisibility(GONE);
        panelShiftBtn.setVisibility(GONE);
        resultPanelshiftBtn.setVisibility(View.VISIBLE);
        resetClicked();
        hideAnalysisLoader();
        String msg = getResources().getString(R.string.image_has_been_rejected_Please_try_again);
        //MirrorCallback.onError(BTBP.IMAGE_REJECTED);
    }

    public void onImageRejectedInServer(String rejectionImage) {
        rejDescriptionTxt.setText(rejectionImage);
        rejTitleTxt.setVisibility(GONE);
        rejectionRl.setVisibility(View.VISIBLE);
        rejDescriptionTxt.setVisibility(View.VISIBLE);
        analyzingLL.setVisibility(View.GONE);
        okBtnImage.setVisibility(View.GONE);
        retakeImgBtn.setVisibility(View.VISIBLE);
        previewButtonRL.setVisibility(View.VISIBLE);
        previewButtonLL.setVisibility(View.VISIBLE);
        //MirrorCallback.onError(BTBP.IMAGE_REJECTED_FROM_SERVER);
        Log.d(TAG, "onImageRejectedInServer: is called");
        panelShiftLayout.setVisibility(GONE);
        resultDisplayRL.setVisibility(View.GONE);
        skinFeatureParentLL.setVisibility(View.GONE);
        resultPanelshiftBtn.setVisibility(View.GONE);
        panelShiftBtn.setVisibility(GONE);
    }

    private void setResults(ServiceResponse serviceResponse) {
        try {
            String serverRejectionMsg = "";
            JSONObject object = new JSONObject(serviceResponse.response);
            JSONArray tagsArray = object.getJSONArray("Tags");
            JSONObject tagsInfo;
            JSONArray scoresInfoArray;
            JSONObject scoresInfo;
            JSONObject imageInfo;
            String tagName;
            String analyzedImageTagName;
            boolean anasisImageTagStatus;
            JSONArray analysisImageInfo;
            String replacedImageTagName;
            boolean tagStatus;
            String toBePrint = "";
            for (int i = 0; i < tagsArray.length(); i++) {
                tagsInfo = tagsArray.getJSONObject(i);
                tagName = tagsInfo.getString("TagName");
                tagStatus = tagsInfo.getBoolean("Status");
                scoresInfoArray = tagsInfo.getJSONArray("TagValues");

                if (tagStatus == true) {
                    scoresInfo = scoresInfoArray.getJSONObject(0);
                    toBePrint += tagName + " : " + scoresInfo.getString("Value") + "\n";

                    SkinConcern skinConcern = new SkinConcern();
                    for (SkinConcern item : skinConcernList) {
                        if (item.getName().equalsIgnoreCase(isScoreTag(tagName))) {
                            skinConcern = item;
//                            Log.d(TAG, "setResults: " + tagName + "is matched");
                        }
                    }
                    for (int j = 0; j < tagsArray.length(); j++) {
                        tagsInfo = tagsArray.getJSONObject(j);
                        analyzedImageTagName = tagsInfo.getString("TagName");
                        anasisImageTagStatus = tagsInfo.getBoolean("Status");
                        if (analyzedImageTagName.contains("_IMAGE")) {
                            if (anasisImageTagStatus == true) {
                                analysisImageInfo = tagsInfo.getJSONArray("TagValues");
                                imageInfo = analysisImageInfo.getJSONObject(0);
                                replacedImageTagName = getMatchedScoreTag_FAST(analyzedImageTagName, tagName);
                                if (replacedImageTagName.equalsIgnoreCase(tagName)) {
                                    skinConcern.setConcernImage(imageInfo.getString("Value"));
                                    break;
                                }
                            }
                        } else {
                            skinConcern.setSeverity(scoresInfo.getString("Value"));
                        }
                    }

                } else {
                    serverRejectionMsg = tagsInfo.getString("Message");
                    onImageRejectedInServer(serverRejectionMsg);
                    StaticVars.isAnalysisFailed = true;
                    return;
                }
            }
//            Log.d(TAG, "setResults: " + toBePrint);
        } catch (Exception e) {
            e.printStackTrace();
            onImageRejected();
        }
    }

    private void callAsyncService() {
        Handler handler = new Handler();

        if (!StaticVars.isResetClicked) {
            if (utils.isOnline()) {
                handler.postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        serviceManager.getProcessedAsyncTags(120, imageId);
                        Log.d(TAG, "run: async service has been called");
                    }
                }, 2000);
            } else {
                String msg = getResources().getString(R.string.alert_check_internet_connection);
                DialogInterface.OnClickListener tryAgainListener = new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        callAsyncService();
                    }
                };
                Utils.showAlert(context, msg, "Retry", tryAgainListener);
            }
        }
    }

    public void resetClicked() {
        StaticVars.isResetClicked = true;
        StaticVars.isAnalysisFailed = false;
        isSkinAnalysisCompleted = false;
        serviceStarted = true;
        resetCamera();
        openCamera();
        //setToggleCamera();
        //autoCaptureBtn.setVisibility(View.VISIBLE);
        pd = new ProgressDialog(context);
        pd.setMessage(getResources().getString(R.string.please_wait));
        pd.setCancelable(false);
        pd.show();
        Utils.updateProgressDialogColor(context, pd);
        Handler handler = new Handler();
        handler.postDelayed(() -> {
            resetSkinTagResults();
           /* if (isDeviceCapableOfAutoCapture()) {
                if (isAutoCaptureControl) {
                    settingBtn.setVisibility(View.VISIBLE);
                }
            }
            captureScreenSettingRL.setVisibility(View.VISIBLE);
            autoCaptureBtn.setEnabled(true); */
            panelShiftBtn.setVisibility(GONE);
            panelShiftLayout.setVisibility(GONE);
            if (resultPanelshiftBtn != null) {
                if (isResultPanelControl && isShowResults) {
                    resultPanelshiftBtn.setVisibility(View.VISIBLE);
                }
            }
            skinFeatureParentLL.setVisibility(View.GONE);
            resultDisplayRL.setVisibility(View.GONE);
            corcernImageParentLL.setVisibility(GONE);
            concernImageLayout.setVisibility(GONE);
            concernImageLayout.resetZoom();
            pd.dismiss();
            skinConcernList = getSkinConcernList();
            showAutoCaptureFragment();
        }, 1000);
    }

    public void resetSkinTagResults() {
        adapter.setDeSelect(getSkinConcernList());
    }

    private void openCamera() {
        AutoCaptureActivity autoCaptureActivity = (AutoCaptureActivity) getActivity();
        if (autoCaptureActivity != null) {
            autoCaptureActivity.autoCaptureFragment.reOpenCamera();
        }
    }

    private void resetCamera() {
        AutoCaptureActivity autoCaptureActivity = (AutoCaptureActivity) getActivity();
        if (autoCaptureActivity != null) {
            autoCaptureActivity.autoCaptureFragment.resetCamera();
        }
    }

    private void releaseCamera() {
        AutoCaptureActivity autoCaptureActivity = (AutoCaptureActivity) getActivity();
        if (autoCaptureActivity != null) {
            autoCaptureActivity.autoCaptureFragment.releaseCamera();
        }
    }

    private void showAutoCaptureFragment() {
        AutoCaptureActivity autoCaptureActivity = (AutoCaptureActivity) getActivity();
        if (autoCaptureActivity != null) {
            autoCaptureActivity.showAutoCaptureFragment();
        }
    }

    //service call back methods impelmentation
    @Override
    public void onServiceCallSuccess(ServiceResponse serviceResponse, long requestCode) {
        try {
            if (requestCode == StaticVars.requestCodeTimeStamp) {
                Timestamp timestamp = new Timestamp(System.currentTimeMillis());
                Log.d(TAG, "onUploadImage: service respone image uploaded: " + timestamp);
                if (serviceResponse != null && serviceResponse.status && serviceResponse.response.length() > 0) {
                    try {
                        Log.d(TAG, "AsyncCall : onServiceCallSuccess: " + serviceResponse.response);
                        JSONObject object = new JSONObject(serviceResponse.response);

                        if (object.has("ErrorCode")) {
                            if (object.getInt("ErrorCode") == 401) {
                                DialogInterface.OnClickListener okListener = (dialogInterface, i) -> onAnalysisFailed();
                                Utils.showAlert(context, "Authentication has failed, please check your device license", "Ok", okListener);
                            } else {
                                imageId = object.getString("ImageId");
                                serviceManager.getProcessedAsyncTags(120, imageId);
                            }
                        } else {
                            imageId = object.getString("ImageId");
                            serviceManager.getProcessedAsyncTags(120, imageId);
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    Log.d(TAG, "onServiceCallSuccess: " + serviceResponse.response);
                } else {
                    DialogInterface.OnClickListener okListener = (dialogInterface, i) -> onAnalysisFailed();
                    Utils.showAlert(context, "Analysis Failed, Please try again", "Ok", okListener);
                }
            }

            if (requestCode == 120) {
                Timestamp timestamp = new Timestamp(System.currentTimeMillis());
                if (serviceResponse != null) {
                    if (serviceResponse.status && serviceResponse.response != null) {
                        try {
                            JSONObject jsonObject = new JSONObject(serviceResponse.response);
                            int processedTag = jsonObject.getInt("ProcessedTagCount");
                            int pendingTags = jsonObject.getInt("PendingTagCount");
                            //MirrorCallback.onAnalysisResultAsync(serviceResponse, BTBP.MirrorCallback.ANALYSIS_RESULT, pendingTags, processedTag, skinConcernList);
                            Log.d(TAG, "asyncCall: pendingTags" + pendingTags + " ProcessedTags " + processedTag + " serviceResponse " + serviceResponse.response);
                            setResults(serviceResponse);
                            if (processedTag != 0) {
                                if (isAysncServiceCall && !StaticVars.isAnalysisFailed && !StaticVars.isResetClicked) {
                                    UpdateSkinListView();
                                }
                            }
                            if (processedTag == requestedTags.size() && !StaticVars.isAnalysisFailed) {
                                isSkinAnalysisCompleted = true;
                                //MirrorCallback.onAnalysisResult(serviceResponse, BTBP.MirrorCallback.ANALYSIS_RESULT, skinConcernList);
                                if (!StaticVars.isResetClicked) {
                                    UpdateSkinListView();
                                }
                            }
                            if (!StaticVars.isAnalysisFailed && !isSkinAnalysisCompleted) {
                                Log.d(TAG, "onServiceCallSuccess: isAnalysisFailed" + StaticVars.isAnalysisFailed);
                                //MirrorCallback.onAnalysisResultAsync(serviceResponse, BTBP.MirrorCallback.ANALYSIS_RESULT, pendingTags, processedTag, skinConcernList);
                                callAsyncService();
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    } else {
                        Log.d(TAG, "onServiceCallSuccess: service response is null");
                        callAsyncService();
                    }
                } else {
                    Log.d(TAG, "onServiceCallSuccess: service response is null");
                    callAsyncService();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void onServiceCallSuccess(ServiceResponse serviceResponse, int requestCode) {

    }

}
