package com.example.okra_widget.models.payments

data class CustomerAccount(
    val _id: String?,
    val balance: String?,
    val bank: String?,
    val name: String?,
    val nuban: String?,
    var hashedNuban: String?,
    val hashedNubanFallback: String?
)