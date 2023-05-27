trigger CountContact on Contact (After insert, After update) {
    
    try
    {    
    
    list<account> acclst = new list<account>();
    Set<Id> accId = new Set<Id>();
    for(Contact con : Trigger.new){
        accId.add(con.AccountId);
    }
    
    list<Account> acc = [Select id, Name, Total_Contact__c, (Select Id from contacts) from account where id=:accId];
    for(Account acct:acc)
    {
        account acc1 = new account();
        acc1.id = acct.id;
        acc1.Total_Contact__c = acct.Contacts.size();
        acclst.add(acc1);
        
    }
        update acclst;
        
    }catch(Exception ex){
        String Error;
        Error = ex.getMessage() + '' + ex.getLineNumber();
        system.debug('Error---'+ Error);
    }
    
}