package com.example.okra_widget.models.payments

data class PaymentModel(
        val account: String?,
        val account_to_credit: String?,
        val account_to_debit: String?,
        val action: String?,
        val amount: Double?,
        val availableBalance: Double?,
        val canAfford: Boolean?,
        val charge: Charge?,
        val clientAccount: ClientAccount?,
        val clientBank: ClientBank?,
        val clientBankCode: String?,
        val creditBankName: String?,
        val currency: String?,
        val customerAccount: CustomerAccount?,
        val customerBank: CustomerBank?,
        val env: String?,
        var multipleAccounts: Boolean?,
        val ref: String?,
        val sameBank: Boolean?,
        val send_ref: String?,
        val utils: Utils?
)