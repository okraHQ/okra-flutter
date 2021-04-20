package com.example.okra_widget.banks

import com.example.okra_widget.interfaces.BankServices
import com.example.okra_widget.models.Enums
import com.example.okra_widget.models.HoverStrategy


class UnionBank : BaseBank(), BankServices {
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
            1 -> accountBalance
            2 -> transactions
            3 -> bvn
            else -> accountBalance
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
        return this.getBvn("Union Bank")
    }


    override fun getAccounts(): HoverStrategy {
        throw Exception("Not implemented")
    }

    override fun getAccountBalance(): HoverStrategy {
        val hoverStrategy = HoverStrategy(
                "7c76635a",
                "Union Bank",
                "Fetching account balance",
                0
        )
        hoverStrategy.id = "balance"
        hoverStrategy.bankResponseMethod = Enums.BankResponseMethod.ussd
        hoverStrategy.isFirstAction = true
        hoverStrategy.requiresPin = true
        return hoverStrategy
    }


    override fun getTransactions(): HoverStrategy {
        val hoverStrategy = HoverStrategy(
                "f470d46c",
                "Union Bank",
                "Fetching transaction(s)",
                0
        )
        hoverStrategy.id = "transactions"
        hoverStrategy.bankResponseMethod = Enums.BankResponseMethod.sms
        hoverStrategy.requiresPin = true
        return hoverStrategy
    }


    override fun confirmPayment(): HoverStrategy? {
        val hoverStrategy = HoverStrategy(
                "7c76635a",
                "Union Bank",
                "Fetching account balance",
                0
        )
        hoverStrategy.id = "verify-payment"
        hoverStrategy.bankResponseMethod = Enums.BankResponseMethod.ussd
        hoverStrategy.requiresPin = true
        return hoverStrategy
    }


    override fun makePayment(isInternal: Boolean, hasMultipleAccounts: Boolean): HoverStrategy? {
        val actionid = if(hasMultipleAccounts) "80b83ea2" else "14462794"
        val hoverStrategy = HoverStrategy(
                actionid,
                "Union Bank",
                "Processing Payment",
                0
        )
        hoverStrategy.id = "payment"
        hoverStrategy.requiresPin = true
        hoverStrategy.bankResponseMethod = Enums.BankResponseMethod.sms
        return hoverStrategy
    }

    companion object {
        private var index = 1
    }
}