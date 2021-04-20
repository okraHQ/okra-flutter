package com.example.okra_widget.interfaces;


import com.example.okra_widget.models.HoverStrategy;

public interface BankServices {
    int getActionCount();
    int getIndex();
    int setIndex(int index);
    HoverStrategy getNextAction() throws Exception;
    boolean hasNext();
    HoverStrategy getActionByIndex(int index) throws Exception;
    HoverStrategy getBvn() throws Exception;
    HoverStrategy getAccounts() throws Exception;
    HoverStrategy getAccountBalance();
    HoverStrategy getTransactions() throws Exception;
    HoverStrategy confirmPayment() throws Exception;
    HoverStrategy makePayment(Boolean isInternal, Boolean hasMultipleAccounts) throws Exception;
}
