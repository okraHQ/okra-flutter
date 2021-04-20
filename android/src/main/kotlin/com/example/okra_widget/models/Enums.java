package com.example.okra_widget.models;

public class Enums {

    public enum Environment {
        dev ("dev"),
        sandbox ("sandbox"),
        staging ("staging"),
        production ("production"),
        production_sandbox ("production-sandbox");

        private final String name;

        private Environment(String s) {
            name = s;
        }
        public boolean equalsName(String otherName) {
            // (otherName == null) check is not needed because name.equals(null) returns false
            return name.equals(otherName);
        }
        public String toString() {
            return this.name;
        }
    }

    public enum Product { auth, transactions, balance, identity, income}

    public enum BankResponseMethod { ussd, sms}

    public enum IndustryType {
        all ("all");

        private final String name;

        private IndustryType(String s) {
            name = s;
        }
        public boolean equalsName(String otherName) {
            // (otherName == null) check is not needed because name.equals(null) returns false
            return name.equals(otherName);
        }
        public String toString() {
            return this.name;
        }
    }

    public enum Banks {
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
        AccessBank ("access-bank");

        private final String name;

        private Banks(String s) {
            name = s;
        }
        public boolean equalsName(String otherName) {
            // (otherName == null) check is not needed because name.equals(null) returns false
            return name.equals(otherName);
        }
        public String toString() {
            return this.name;
        }
    }
}
