trigger OpportunityTrigger on Opportunity (before insert, before update) {

    Id hardCodedRecordTypeId = '012000000000123AAA';

    for (Opportunity opp : Trigger.new) {
     
        System.debug('Processing opportunity: ' + opp.Name);

      
        if (opp.StageName == 'Closed Won') {
            opp.Description = 'This was set in trigger.';
        }

        // SOQL inside loop (bad practice)
        List<Contact> contacts = [SELECT Id, Email FROM Contact WHERE AccountId = :opp.AccountId];

        for (Contact c : contacts) {
            // DML inside inner loop (bad practice)
            c.Description = 'Updated from trigger';
            update c;
        }

        // Empty catch block (bad)
        try {
            Integer calc = 10 / 0; // Will throw error
        } catch (Exception e) {
            // Do nothing 
        }
    }
}