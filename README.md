# Campaign
Kickstarter alternative implementation with blockchain(Ethereum)


## Campaign Contract

### Variables
Name | Type | Description 
------------ | ------------- | -------------
inventor | address | Address of the person who is managing the campaign / inventor of the idea
minContribution | uint | Minimum donation required to be considered a contributor or 'approver'
approvers | address[] | List of addresses for every person who has donated money
requests | [Request[]](#link01) | List of request that inventor has created


### Function
Name | Description 
------------ | -------------
constructor | Constructor function that sets the minimunm contribution and the owner/inventor
contribute | Called when someone wants to donate money to the campaign and become an 'approver'
createRequest | Called by the manager to create a new 'spending request'
approveRequest | Called by each contributor to approve a spending request
finalizeRequest | After a request has gotten enough approvals, the manager can call this to get money sent to the vendor


### <a name="link01"> Request struct </a>
Name | Type | Purpose 
------------ | ------------- | ------------- 
description | string | Describes why the request is being created.
value | uint | Amount of money that the manager wants to send to the vendor
recipient | address | Address that the money will be sent to.
complete | bool | True if the request has already been processed (money sent)