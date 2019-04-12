package com.clk.cms;

import java.io.File;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

public class CmsUtilities {

    public String toCapitalize(String sentence) {
        String capitalized = "";

        try{
            //Capitalize first character
            capitalized = sentence.substring(0,1).toUpperCase() + sentence.substring(1);
        }catch (Exception e){
            e.printStackTrace();
        }

        return capitalized;
    }

    public String replaceChars(String word, String oldWord, String newWord) {
        String replaced = "";

        try{
            replaced = word.replace(oldWord, newWord);
        }catch (Exception e){
            /**e.printStackTrace();*/
        }

        return replaced;
    }

    public String dateFormat(String dateString) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        String date_string = "";
        try{
            Date simple_date = sdf.parse(dateString);
            date_string = df.format(simple_date);
        }catch (Exception e) {
            e.printStackTrace();
        }
        return date_string;
    }

    public String textColors(String choices){
        String text_color = "";

        try {
            Float choice = Float.parseFloat(choices);
            if (choice <= 20) {
                text_color = "danger";
            } else if (choice <= 50) {
                text_color = "warning";
            } else if (choice <= 80) {
                text_color = "info";
            } else {
                text_color = "success";
            }
        }catch (Exception e) {
            /**e.printStackTrace();*/
        }

        return text_color;
    }

    public boolean deleteFile(String file_name, String file_type, String file_folder){
        boolean resp = false;
        try{
            File the_file = new File( file_folder + file_name + "." + file_type);
            if (!the_file.exists()){
                resp = true;
            }else {
                if (the_file.delete()) {
                    resp = true;
                }
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return resp;
    }

    public String amountFormat(String amount) {
        try {
            double amt = Double.parseDouble(amount);
            DecimalFormat formatter = new DecimalFormat("#,###.00");
            amount = formatter.format(amt);
        }catch (Exception e) {
            e.printStackTrace();
        }
        return amount;
    }

    public String timeDifference(String GivenTime) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        sdf.setTimeZone(TimeZone.getTimeZone("Africa/Dar_es_Salaam"));
        String Differences = "";
        try {
            Date GivenTimes = sdf.parse(GivenTime);
            long Today = System.currentTimeMillis();
            long PostedDate = GivenTimes.getTime();
            long Difference = (Today - PostedDate);
            //System.out.println("Received Time is " + GivenTime + " Converted Time is " + GivenTimes);
            /*if (Difference >= 2419200000) {
                long Interval = Difference / (1000 * 60 * 60 * 24 * 28);
                if (Interval > 1) {
                    Differences = Interval + " Months Ago";
                } else {
                    Differences = Interval + " Month Ago";
                }
            } else */if (Difference >= 604800000) {
                long Interval = Difference / (1000 * 60 * 60 * 24 * 7);
                if (Interval > 1) {
                    Differences = Interval + " Weeks Ago";
                } else {
                    Differences = Interval + " Week Ago";
                }
            } else if (Difference >= 86400000) {
                long Interval = Difference / (1000 * 60 * 60 * 24);
                if (Interval > 1) {
                    Differences = Interval + " Days Ago";
                } else {
                    Differences = Interval + " Day Ago";
                }
            } else if (Difference >= 3600000) {
                long Interval = Difference / (1000 * 60 * 60);
                if (Interval > 1) {
                    Differences = Interval + " Hours Ago";
                } else {
                    Differences = Interval + " Hour Ago";

                }
            } else {
                long Interval = Difference / (1000 * 60);
                if (Interval > 1) {
                    Differences = Interval + " Minutes Ago";
                } else {
                    Differences = Interval + " Minute Ago";

                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return Differences;
    }
}
