package com.example.btbp_projects.Models;

public class SkinConcern {
    private String name;
    private String severity;
    private String concernImage;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSeverity() {
        return severity;
    }

    public void setSeverity(String severity) {
        this.severity = severity;
    }

    public String getConcernImage() {
        return concernImage;
    }

    public void setConcernImage(String concernImage) {
        this.concernImage = concernImage;
    }
}