This demo app allow load your wallets and transactions from mock server - https://www.mockachino.com/spaces/4851c32b-ab3d-4f and display in the app. Also you can tap on transaction cell and see details of this transaction.

IMPORTANT THINGS:
- I used MVVM architecture in the app with custom dependency injection and event handling system. You can find it in "Core" folder in the project. There are two modules: one for main list called - List and one for detail view called - Detail.
- This projects doesn't use any dependencies managers like cocoapods or SPM. ALl Code was written with native instruments.
- Now i delayed responses from server for 2 seconds(For posibility to see loading state), if you want to change it use - URLSession+Extension.swift file.
- Please use this link to manipulate mock data - https://www.mockachino.com/spaces/4851c32b-ab3d-4f. For example if you want see error in the app you can change "HTTP Response Status Code" to 400.
- Minimum ios version is 13.0
- I make system of two not depending on each other requests in the app. So if one request will be broken another one will be loaded. So it is allow to user see data of one of request and load again another. But sometimes it is ok to use depending requests, so for this goal i would use combine this zip technique.
- I left comments to some parts of code for more comfortable reading.

If you have any questions feel free to ask me:
* telegram - @egor_dev
* email - egorkze@gmail.com
* skype - egorkze
