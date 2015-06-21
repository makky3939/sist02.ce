checkForValidUrl = (tabId, changeInfo, tab) ->
  if tab.url.match /http:\/\/ci.nii.ac.jp\/(naid|ncid)\/[0-9A-Z]+/
    chrome.pageAction.show tabId

chrome.tabs.onUpdated.addListener checkForValidUrl