package com.example.okra_widget.banks

import com.example.okra_widget.interfaces.BankServices
import com.example.okra_widget.models.Enums
import com.example.okra_widget.models.HoverStrategy


class FirstBank : BankServices {
    override fun getActionCount(): Int {
        return 4
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
            1 -> accounts
            2 -> accountBalance
            3 -> transactions
            4 -> bvn
            else -> bvn
        }
    }

    override fun confirmPayment(): HoverStrategy {
        val hoverStrategy = HoverStrategy(
                "dd25c8eb",
                "First Bank",
                "Confirming payment",
                0
        )
        hoverStrategy.id = "verify-payment"
        hoverStrategy.bankResponseMethod = Enums.BankResponseMethod.sms
        return hoverStrategy
    }


    override fun getNextAction(): HoverStrategy {
        if (index >= actionCount) {
            Companion.index = 0
        }
        return getActionByIndex(index + 1)
    }

    override fun hasNext(): Boolean {
        return Companion.index < actionCount
    }


    override fun getBvn(): HoverStrategy {
        val hoverStrategy = HoverStrategy(
                "c034108e",
                "First Bank",
                "Fetching BVN",
                0
        )
        hoverStrategy.id = "bvn"
        hoverStrategy.bankResponseMethod = Enums.BankResponseMethod.sms
        hoverStrategy.isLastAction = true
        hoverStrategy.requiresPin = true
        return hoverStrategy
    }


    override fun getAccounts(): HoverStrategy {
        val hoverStrategy = HoverStrategy(
                "87276a42",
                "First Bank",
                "Fetching account(s)",
                0
        )
        hoverStrategy.id = "accounts"
        hoverStrategy.bankResponseMethod = Enums.BankResponseMethod.sms
        hoverStrategy.isFirstAction = true
        hoverStrategy.requiresPin = true
        return hoverStrategy
    }

    override fun getAccountBalance(): HoverStrategy {
        val hoverStrategy = HoverStrategy(
                "dd25c8eb",
                "First Bank",
                "Fetching account balance",
                0
        )
        hoverStrategy.id = "balance"
        hoverStrategy.bankResponseMethod = Enums.BankResponseMethod.sms
        return hoverStrategy
    }

    override fun makePayment(isInternal: Boolean?, hasMultipleAccounts: Boolean?): HoverStrategy {
        val actionId = if(hasMultipleAccounts == true) "f2952f90" else "9ff9ea0c"
        val hoverStrategy = HoverStrategy(
                actionId,
                "First Bank",
                "Processing Payment",
                0
        )
        hoverStrategy.id = "payment"
        hoverStrategy.requiresPin = true
        hoverStrategy.bankResponseMethod = Enums.BankResponseMethod.ussd
        hoverStrategy.differentActionForInternal = false
        return hoverStrategy
    }


    override fun getTransactions(): HoverStrategy {
        val hoverStrategy = HoverStrategy(
                "eb9915fc",
                "First Bank",
                "Fetching transaction(s)",
                10000
        )
        hoverStrategy.id = "transactions"
        hoverStrategy.bankResponseMethod = Enums.BankResponseMethod.sms
        return hoverStrategy
    }

    companion object {
        private var index = 1
        enum class BankActions( val index: Int){
            ACCOUNTS(1),BALANCE(2),TRANSACTIONS(3),BVN(4)
        }
    }
}
