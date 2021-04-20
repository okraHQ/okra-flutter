package com.example.okra_widget.models.payments

data class Charge(
    val account: String?,
    val amount: Double?,
    val currency: String?,
    val currency_symbol: String?,
    val fee: Double?,
    val method: String?,
    val note: String?,
    val payment_id: Any?,
    val ref: String?,
    val type: String?
)