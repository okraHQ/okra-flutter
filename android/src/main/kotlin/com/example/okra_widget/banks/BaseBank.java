package com.example.okra_widget.banks;

import android.graphics.Color;

import com.example.okra_widget.models.Enums;
import com.example.okra_widget.models.HoverStrategy;


public class BaseBank {

    private int primaryColor = Color.parseColor("#D81B60");

    public HoverStrategy getBvn(String bankAlias) {
        HoverStrategy hoverStrategy =  new HoverStrategy(
                "8ac6e2d8",
                "bvn",
                bankAlias,
                "Fetching BVN",
                0
        );
        hoverStrategy.setId("bvn");
        hoverStrategy.setBankResponseMethod(Enums.BankResponseMethod.ussd);
        hoverStrategy.setLastAction(true);
        return hoverStrategy;
    }
}
