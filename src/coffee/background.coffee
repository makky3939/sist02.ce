checkForValidUrl = (tabId, changeInfo, tab) ->
  if tab.url.indexOf("http://ci.nii.ac.jp") > -1
    chrome.pageAction.show tabId

chrome.tabs.onUpdated.addListener checkForValidUrl