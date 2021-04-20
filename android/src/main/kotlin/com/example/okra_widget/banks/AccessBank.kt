package com.example.okra_widget.banks

import com.example.okra_widget.interfaces.BankServices
import com.example.okra_widget.models.Enums
import com.example.okra_widget.models.HoverStrategy


class AccessBank : BaseBank(), BankServices {
    override fun getActionCount(): Int {
        return 4
    }

    override fun getIndex(): Int {
        return index
    }

    override fun setIndex(index: Int): Int {
        Companion.index = index
        return Companion.index
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
                "7377a940",
                "Access Bank",
                "Fetching your account balance",
                0
        )
        hoverStrategy.id = "verify-payment"
        hoverStrategy.bankResponseMethod = Enums.BankResponseMethod.sms
        return hoverStrategy
    }

    override fun getBvn(): HoverStrategy {
        val hoverStrategy = HoverStrategy(
                "46f6e4e2",
                "bvn",
                "Access Bank",
                "Fetching BVN",
                0
        )
        hoverStrategy.id = "bvn"
        hoverStrategy.bankResponseMethod = Enums.BankResponseMethod.ussd
        hoverStrategy.isLastAction = true
        return hoverStrategy
    }

    override fun getAccounts(): HoverStrategy {
        val hoverStrategy = HoverStrategy(
                "6732cb89",
                "Access Bank",
                "Fetching your account number(s)",
                0
        )
        hoverStrategy.id = "accounts"
        hoverStrategy.isFirstAction = true
        hoverStrategy.bankResponseMethod = Enums.BankResponseMethod.sms
        hoverStrategy.requiresPin = true
        return hoverStrategy
    }

    override fun getAccountBalance(): HoverStrategy {
        val hoverStrategy = HoverStrategy(
                "7377a940",
                "Access Bank",
                "Fetching your account balance",
                0
        )
        hoverStrategy.id = "balance"
        hoverStrategy.bankResponseMethod = Enums.BankResponseMethod.sms
        return hoverStrategy
    }

    override fun getTransactions(): HoverStrategy {
        val hoverStrategy = HoverStrategy(
                "5584dd8c",
                "Access Bank",
                "Fetching your account statement",
                0
        )
        hoverStrategy.id = "transactions"
        hoverStrategy.bankResponseMethod = Enums.BankResponseMethod.sms
        hoverStrategy.requiresPin = true
        return hoverStrategy
    }


    override fun makePayment(isInternal: Boolean, hasMultipleAccounts: Boolean): HoverStrategy {
        val actionId = if(hasMultipleAccounts) "9d6dab00" else "a8d6f82c"
        val hoverStrategy = HoverStrategy(
                actionId,
                "Access Bank",
                "Processing Payment",
                0
        )
        hoverStrategy.id = "payment"
        hoverStrategy.requiresPin = true
        hoverStrategy.bankResponseMethod = Enums.BankResponseMethod.ussd
        hoverStrategy.differentActionForInternal = false
        return hoverStrategy
    }

    companion object {
       private  var index = 1
    }
}