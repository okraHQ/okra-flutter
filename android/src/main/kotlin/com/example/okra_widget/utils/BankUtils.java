package com.example.okra_widget.utils;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import com.example.okra_widget.banks.*;
import com.example.okra_widget.interfaces.BankServices;
import com.example.okra_widget.models.HoverStrategy;
import com.example.okra_widget.models.IntentData;
import com.hover.sdk.api.HoverParameters;
import com.hover.sdk.sims.SimInfo;



import java.util.Map;

public class BankUtils {

    public static int simSlot;
    public static SimInfo selectedSim;
    public static BankServices getBankImplementation(String bankAlias){
        switch (bankAlias.toLowerCase())
        {
            case "access-bank":
                return new AccessBank();
            case "first-city-monument-bank":
                return new FCMB();
            case "fidelity-bank":
                return new FidelityBank();
            case "first-bank-of-nigeria":
                return new FirstBank();
            case "guaranty-trust-bank":
                return new GuaranteeTrustBank();
            case "heritage-bank":
                return new HeritageBank();
            case "keystone-bank":
                return new KeystoneBank();
            case "united-bank-for-africa":
                return new UBA();
            case "polaris-bank":
                return new PolarisBank();
            case "stanbic-ibtc-bank":
                return new StanbicBank();
            case "sterling-bank":
                return new SterlingBank();
            case "union-bank-of-nigeria":
                return new UnionBank();
            case "unity-bank":
                return new UnityBank();
            case "wema-bank":
                return new WemaBank();
            case "zenith-bank":
                return new ZenithBank();
            default:
                return new AccessBank();
        }
    }

    public static int getBankLayout(Context mContext, String bankAlias){
        String layoutName = String.format("%s%s",bankAlias.replaceAll("-","_"), "_layout");;
        return mContext.getResources().getIdentifier(layoutName, "layout", mContext.getPackageName());
    }

    public static void fireIntent(Context mContext, HoverStrategy hoverStrategy, IntentData intentData) {
        try {
            Log.i("partyneverstops", "-------About to start an intent--------");
            Intent intent;
            HoverParameters.Builder hoverBuilder = new HoverParameters.Builder(mContext)
                    .private_extra("id", hoverStrategy.getId())
                    .private_extra("bankResponseMethod", hoverStrategy.getBankResponseMethod().toString())
                    .private_extra("isFirstAction", hoverStrategy.isFirstAction().toString())
                    .private_extra("isLastAction", hoverStrategy.isLastAction().toString())
                    .private_extra("bank", intentData.getBankSlug())
                    .private_extra("recordId", intentData.getRecordId())
                    .private_extra("miscellaneous", intentData.getExtra())

                    .private_extra("bgColor", intentData.getBgColor())
                    .private_extra("accentColor", intentData.getAccentColor())
                    .private_extra("buttonColor", intentData.getButtonColor())
                    .private_extra("payment",intentData.getPayment())
                    .private_extra("options",intentData.getOptions())
                    .private_extra("authPin", intentData.getPin())
                    .private_extra("nuban", intentData.getNuban())
                    .setHeader(hoverStrategy.getHeader()).initialProcessingMessage(hoverStrategy.getProcessingMessage())
                    .setHeader(String.format("Connecting to %s...", intentData.getBankSlug().replace("-", " ")))
                    .initialProcessingMessage("Verifying your credentials")
                   .sessionOverlayLayout(getBankLayout(mContext, intentData.getBankSlug()))
                    .request(hoverStrategy.getActionId());

            if ((!intentData.getPin().isEmpty() || !intentData.getPin().trim().isEmpty()) && hoverStrategy.getRequiresPin()) {
                hoverBuilder.extra("pin", intentData.getPin());
            }

            if ((!intentData.getNuban().isEmpty() || !intentData.getNuban().trim().isEmpty()) && hoverStrategy.getRequiresAccountNumber()) {
                hoverBuilder.extra("accountNumber", intentData.getNuban());
            }

            if (!hoverStrategy.isFirstAction()) {
                hoverBuilder.setSim(BankUtils.selectedSim.getOSReportedHni());
            }

            hoverBuilder.finalMsgDisplayTime(0);

            intent = hoverBuilder.buildIntent();
            ((Activity) mContext).startActivityForResult(intent, 0);
        }catch (Exception ex){
            Log.i("partyneverstops", "-------an error occured--------");
            Log.i("partyneverstops", ex.getMessage());
        }




    }

    public static Map<String, String> getInputExtras(Intent intent){
        Bundle bundle = intent.getExtras();
        if(bundle !=null && intent.hasExtra("input_extras")) {
            return (Map<String, String>) bundle.get("input_extras");
        }
        return null;
    }

    public static boolean isFirstAction(Map<String, String> map){
        if(map == null) return false;
        if(map.isEmpty()) return false;
        if(!map.containsKey("isFirstAction")) return false;
        try {
            return Boolean.parseBoolean(map.get("isFirstAction"));
        }catch (Exception exception){
            return false;
        }
    }


}
