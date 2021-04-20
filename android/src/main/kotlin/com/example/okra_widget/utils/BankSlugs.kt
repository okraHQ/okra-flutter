package com.example.okra_widget.utils

enum class BankSlugs(val bankName:String){
    EcoBank ("ecobank-nigeria"),
    FidelityBank ("fidelity-bank"),
    FirstBankOfNigeria ("first-bank-of-nigeria"),
    FirstCityMonumentBank ("first-city-monument-bank"),
    GTB ("guaranty-trust-bank"),
    PolarisBank ("polaris-bank"),
    StanbicIBTC ("stanbic-ibtc-bank"),
    StandardCharteredBank ("standard-chartered-bank"),
    SterlingBank ("sterling-bank"),
    UnionBank ("union-bank-of-nigeria"),
    UBA ("united-bank-for-africa"),
    WemaBank ("wema-bank"),
    UnityBank ("unity-bank"),
    Alat ("alat"),
    AccessBank ("access-bank")
}

fun String.toBankSlug(): BankSlugs?{
    return when(this){
        BankSlugs.EcoBank.bankName -> BankSlugs.EcoBank
        BankSlugs.FidelityBank.bankName -> BankSlugs.FidelityBank
        BankSlugs.FirstBankOfNigeria.bankName -> BankSlugs.FirstBankOfNigeria
        BankSlugs.FirstCityMonumentBank.bankName -> BankSlugs.FirstCityMonumentBank
        BankSlugs.GTB.bankName -> BankSlugs.GTB
        BankSlugs.PolarisBank.bankName -> BankSlugs.PolarisBank
        BankSlugs.StanbicIBTC.bankName -> BankSlugs.StanbicIBTC
        BankSlugs.StandardCharteredBank.bankName -> BankSlugs.StandardCharteredBank
        BankSlugs.SterlingBank.bankName -> BankSlugs.SterlingBank
        BankSlugs.UnionBank.bankName -> BankSlugs.UnionBank
        BankSlugs.UBA.bankName -> BankSlugs.UBA
        BankSlugs.WemaBank.bankName -> BankSlugs.WemaBank
        BankSlugs.UnityBank.bankName -> BankSlugs.UnityBank
        BankSlugs.Alat.bankName -> BankSlugs.Alat
        BankSlugs.AccessBank.bankName -> BankSlugs.AccessBank
        else -> null
    }
}