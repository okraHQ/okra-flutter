package com.example.okra_widget.banks

import com.example.okra_widget.interfaces.BankServices
import com.example.okra_widget.models.Enums
import com.example.okra_widget.models.HoverStrategy


class GuaranteeTrustBank : BankServices {
    override fun getActionCount(): Int {
        return 1
    }

    override fun getIndex(): Int {
        return Companion.index
    }

    override fun setIndex(index: Int): Int {
        Companion.index = index
        return Companion.index
    }

    override fun getActionByIndex(index: Int): HoverStrategy {
        return when (index) {
            1 -> accountBalance
            else -> accountBalance
        }
    }

    override fun confirmPayment(): HoverStrategy {
        val hoverStrategy = HoverStrategy(
                "ad6c3e9c",
                "balance",
                "Guarantee Trust Bank",
                "Fetching account balance",
                10000
        )
        hoverStrategy.id = "verify-payment"
        hoverStrategy.bankResponseMethod = Enums.BankResponseMethod.ussd
        hoverStrategy.requiresPin = true
        return hoverStrategy
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
        throw Exception("Not implemented")
    }


    override fun getAccounts(): HoverStrategy {
        throw Exception("Not implemented")
    }

    override fun getAccountBalance(): HoverStrategy {
        val hoverStrategy = HoverStrategy(
                "ad6c3e9c",
                "balance",
                "Guarantee Trust Bank",
                "Fetching account balance",
                10000
        )
        hoverStrategy.id = "balance"
        hoverStrategy.bankResponseMethod = Enums.BankResponseMethod.ussd
        hoverStrategy.isFirstAction = true
        hoverStrategy.isLastAction = true
        hoverStrategy.requiresPin = true
        return hoverStrategy
    }


    override fun getTransactions(): HoverStrategy {
        throw Exception("Not implemented")
    }


    override fun makePayment(isInternal: Boolean, hasMultipleAccounts: Boolean): HoverStrategy {
       // val actionid = if(isInternal) "d5f503e2" else "b85c8f85"
        val actionid = if(hasMultipleAccounts) "025320d9" else "b85c8f85"
        val hoverStrategy = HoverStrategy(
                actionid,
                "Guarantee Trust Bank",
                "Processing Payment",
                0
        )
        hoverStrategy.id = "payment"
        hoverStrategy.requiresPin = true
        hoverStrategy.bankResponseMethod = Enums.BankResponseMethod.ussd
        hoverStrategy.differentActionForInternal = true
        return hoverStrategy
    }

    companion object {
       private var index = 1
    }
}