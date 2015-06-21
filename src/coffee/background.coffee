checkForValidUrl = (tabId, changeInfo, tab) ->
  if tab.url.match /http:\/\/ci.nii.ac.jp\/naid\/[0-9]+/
    chrome.pageAction.show tabId

chrome.tabs.onUpdated.addListener checkForValidUrl