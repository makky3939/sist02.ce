chrome.tabs.getSelected null, (tab) ->
  url = new URL tab.url
  naid = url.pathname.replace /\/naid\//, ''
  # alert naid

  document.getElementById('naid').value = naid
  return