package com.example.okra_widget.models.payments

data class Payments(
        val corp: Corp?,
        val ind: Ind?,
        val mobile: Mobile?,
        val ussd: Ussd?
)