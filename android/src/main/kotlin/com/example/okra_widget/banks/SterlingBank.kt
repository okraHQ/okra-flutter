package com.example.okra_widget.banks

import com.example.okra_widget.interfaces.BankServices
import com.example.okra_widget.models.Enums
import com.example.okra_widget.models.HoverStrategy


class SterlingBank : BaseBank(), BankServices {
    override fun getActionCount(): Int {
        return 3
    }

    override fun getIndex(): Int {
        return index
    }

    override fun setIndex(index: Int): Int {
        Companion.index = index
        return Companion.index
    }


    override fun getActionByIndex(index: Int): HoverStrategy {
        return when (index) {
            1 -> accounts
            2 -> accountBalance
            3 -> bvn
            else -> accounts
        }
    }


    override fun getNextAction(): HoverStrategy {
        if (index >= actionCount) {
            index = 0
        }
        return getActionByIndex(index + 1)
    }

    override fun hasNext(): Boolean {
        return index < actionCount
    }


    override fun getBvn(): HoverStrategy {
        return this.getBvn("Sterling Bank")
    }

    override fun getAccounts(): HoverStrategy {
        val hoverStrategy = HoverStrategy(
                "b46ceac3",
                "Sterling Bank",
                "Fetching Accounts",
                0
        )
        hoverStrategy.id = "accounts"
        hoverStrategy.bankResponseMethod = Enums.BankResponseMethod.ussd
        hoverStrategy.isFirstAction = true
        return hoverStrategy
    }

    override fun getAccountBalance(): HoverStrategy {
        val hoverStrategy = HoverStrategy(
                "79a457c7",
                "Sterling Bank",
                "Fetching Account balance",
                0
        )
        hoverStrategy.id = "balance"
        hoverStrategy.bankResponseMethod = Enums.BankResponseMethod.ussd
        return hoverStrategy
    }


    override fun getTransactions(): HoverStrategy {
        throw Exception("Not implemented")
    }


    override fun confirmPayment(): HoverStrategy {
        val hoverStrategy = HoverStrategy(
                "79a457c7",
                "Sterling Bank",
                "Verify Payment",
                0
        )
        hoverStrategy.id = "verify-payment"
        hoverStrategy.bankResponseMethod = Enums.BankResponseMethod.ussd
        return hoverStrategy
    }


    override fun makePayment(isInternal: Boolean, hasMultipleAccounts: Boolean): HoverStrategy? {
        val actionid = if(hasMultipleAccounts) "52885640" else "9c658ade"
        val hoverStrategy = HoverStrategy(
                actionid,
                "Sterling Bank",
                "Processing Payment",
                0
        )
        hoverStrategy.id = "payment"
        hoverStrategy.bankResponseMethod = Enums.BankResponseMethod.ussd
        return hoverStrategy
    }

    companion object {
        private var index = 1
    }
}