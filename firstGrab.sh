#!/bin/bash

#repetitive start of sfdx script, passed in as variable to shorten code
start=$"sfdx force:data:soql:query -q"

#-----Queries
queryOrg=$"SELECT CreatedDate,Id,InstanceName,IsSandbox,Name,OrganizationType FROM Organization"  #query for orgs
queryUser=$"SELECT Id,Name,UserType FROM User"  #query for users
queryAccount=$"SELECT Id, Account.Name FROM Account"  #query for acounts
queryPricebook=$"SELECT Id,Name FROM Pricebook2"  #query for pricebooks
queryProduct=$"SELECT Id,Name FROM Product2"  #query for products
queryEntry=$"SELECT Id,Pricebook2Id,Product2Id FROM PricebookEntry"  #query for product pricebook entries
queryOpp=$"SELECT AccountId,CloseDate,CreatedDate,Id,Name,OwnerId FROM Opportunity WHERE StageName = 'Closed Won'"  #query for all closed won opps
queryLineItem=$"SELECT Id,ListPrice,OpportunityId,PricebookEntryId,Quantity,TotalPrice,UnitPrice FROM OpportunityLineItem"  #query for all closed won opps

#repetitive end of sfdx script, passed in as variable to shorten code
end=$"-u CLICourseDevHub -r csv"

#check directory for output files
if [ -d "dataGrabbed" ]; then
    echo "Using directory dataGrabbed for .csv outputs"
else
    echo "Error: directory dataGrabbed does not exist, creating directory..."
    # Make output directory
    mkdir dataGrabbed
fi

#----Run all queries and create CSV files of the result in the dataGrabbed folder
$start "$queryOrg" $end > dataGrabbed/1_orgs.csv  # Get all orgs in the instance
$start "$queryUser" $end > dataGrabbed/2_users.csv  # Get all users in the instance
$start "$queryAccount" $end > dataGrabbed/3_accounts.csv  # Get all accounts
$start "$queryPricebook" $end > dataGrabbed/4_pricebooks.csv  # Get all pricebooks
$start "$queryProduct" $end > dataGrabbed/5_products.csv  # Get all products
$start "$queryEntry" $end > dataGrabbed/6_pricebookEntries.csv  # Tie the pricebooks with the products via pricebook entry
$start "$queryOpp" $end > dataGrabbed/7_opps.csv  # Get all closed won opps
$start "$queryLineItem" $end > dataGrabbed/8_lineItems.csv  # Tie Line item product with the pricebook to the opp Ids

#Echo how long the script ran
echo "Script complete, check dataGrabbed folder for your new .csv's"