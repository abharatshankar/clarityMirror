package com.example.clarity_mirror.Adapters;

import static org.btbp.btbplibrary.Utilities.StaticVars.isResultUpdated;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ProgressBar;
import android.widget.TextView;

import androidx.annotation.NonNull;

import com.example.btbp_projects.Models.SkinConcern;
import com.example.clarity_mirror.R;

import org.btbp.btbplibrary.Utilities.StaticVars;
import org.btbp.btbplibrary.Utilities.Utils;

import java.util.List;
import java.util.Objects;
public class ResultListAdapter extends ArrayAdapter<SkinConcern> {
    private final Context context;
    private List<SkinConcern> skinConcernList;
    public int selectedIndex = -1;
    private final int resourceId;

    public ResultListAdapter(@NonNull Context context, int resource, @NonNull List<SkinConcern> skinConcernList) {
        super(context, resource, skinConcernList);
        this.context = context;
        this.skinConcernList = skinConcernList;
        this.resourceId = resource;
    }

    @Override
    public boolean isEnabled(int position) {
        return isResultUpdated && skinConcernList.get(position).getConcernImage() != null;
    }

    @Override
    public int getCount() {
        return skinConcernList.size();
    }

    @Override
    public SkinConcern getItem(int position) {
        return skinConcernList.get(position);
    }

    @Override
    public long getItemId(int position) {
        return 0;
    }

    @Override
    public View getView(final int position, View convertView, final ViewGroup parent) {
        ViewHolder holder;
        if (convertView == null) {
            LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
            convertView = inflater.inflate(resourceId, parent, false);

            holder = new ViewHolder();
            holder.txtName = convertView.findViewById(R.id.feature_skin_names);
            holder.txtSeverity = convertView.findViewById(R.id.skin_feture_resultText);
            holder.pbSeverity = convertView.findViewById(R.id.pb_severity);
            holder.pbLoader = convertView.findViewById(R.id.pb_loading);
            Utils.updateProgressBarColor(context, holder.pbLoader);
            convertView.setTag(holder);
        } else {
            holder = (ViewHolder) convertView.getTag();
        }

        SkinConcern skinConcern = skinConcernList.get(position);
        holder.txtName.setText(skinConcern.getName());
        if (Objects.equals(skinConcern.getSeverity(), "0")) {
            holder.txtSeverity.setText("");
            holder.pbSeverity.setProgress(0);
            holder.pbLoader.setVisibility(View.VISIBLE);
        } else {
            holder.pbLoader.setVisibility(View.GONE);
            holder.txtSeverity.setText(skinConcern.getSeverity());
            holder.pbSeverity.setProgress(tryParseInt(skinConcern.getSeverity(), 0));
        }

        if (position == selectedIndex) {
            setSelectedFeature(convertView);
        } else {
            setDeselectedFeature(convertView);
        }
        return convertView;
    }
    public int tryParseInt(String value, int defaultVal) {
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            return defaultVal;
        }
    }

    public void setSelectedFeature(View view) {
        view.setBackgroundResource(R.drawable.skin_feature_selected_border);
    }

    public void setDeselectedFeature(View view) {
        view.setBackgroundResource(R.drawable.skin_feature_deselected_border);
    }

    public void setDeSelect(List<SkinConcern> skinConcernList) {
        this.skinConcernList = skinConcernList;
        isResultUpdated = false;
        StaticVars.isResetClicked = false;
        this.selectedIndex = -1;
        notifyDataSetChanged();
    }

    public void updateSkinTagResults(List<SkinConcern> skinConcernList) {
        this.skinConcernList = skinConcernList;
        //selectedIndex = -1;
        StaticVars.isResultUpdated = true;
        notifyDataSetChanged();
    }

    static class ViewHolder {
        private TextView txtName;
        private TextView txtSeverity;
        private ProgressBar pbSeverity;
        private ProgressBar pbLoader;
    }

    public void notifyChange() {
        notifyDataSetChanged();
    }
}
