# TWEET-A-CAUSE

Tweet a cause is a ruby on rails project that turns tweets into donations to charity. Users select a default contribution amount (eg `$0.10`) and a default charity (eg `Doctors without Borders`). At the end of each month the users tweets are tallied and a corresponding donation is made to the selected charity. For example, `1000` tweets in a given month with the above example charity preferences would be a `$100.00` donation to `Doctors without Borders`.

### charity

This project is 100% developed by volunteer do gooders. There will never be fees that are used to pay developers. The only fees incurred are the actual API processing fees of our payment methods (eg. STRIPE) and infrastructure. We attempt to minimize these fees by batching the process of creating a transaction each month and requiring a minimum donation amount before ever performing a transaction so that the fee per donation is not self-defeating. 

If you are interested in contributing to this project please fork this repo and submit a PR.

### Some areas for improvement include:
* Scheduled job to create transactions from donations at the end of each month
* UI to CRUD charity preferences
* UI for users to view Tweets, Donations, Transactions
* Feature for users to cancel pending donations
* Email notifications upon donation
* Integration with charity APIs
* Integration with STRIPE
* Integration with Paypal
* Integration with other social media tools, eg. Facebook, Pinterest, Snapchat, etc
* Legal documentation
* Optimize SQL queries
* Optimize deployment strategy - currently using Heroku
