class Sist02
  class CiNii
    reference = {}

    constructor: ->
      @reference = {}

    article_reference: (naid) ->
      url = "http://ci.nii.ac.jp/naid/#{naid}.json"
      _fetch(url).then (response) ->
        @reference = _basic_information response

        @reference['volume'] = response['prism:volume'] || ''
        @reference['number'] = response['prism:number'] || ''
        @reference['start_page'] = response['prism:startingPage'] || ''
        @reference['end_page'] = response['prism:endingPage'] || ''


        # "no. #{@reference['number']},"
        result = [
          "#{@reference['authors']}."
          "#{@reference['title']}."
          "#{@reference['publicationName']}."
          "#{@reference['year']},"
          "vol. #{@reference['volume']},"
          "p. #{@reference['start_page']}-#{@reference['end_page']}."
        ]
        result.join ' '
      , (error) ->
        false

    book_reference: (ncid) ->
      url = "http://ci.nii.ac.jp/ncid/#{ncid}.json"
      _fetch(url).then (response) ->
        @reference = _basic_information response

        @reference['edition'] = response['prism:edition']
        @reference['publisher'] = response['dc:publisher'][0]

        # page
        result = [
          "#{@reference['authors']}."
          "#{@reference['title']}."
          "#{@reference['edition']},"
          "#{@reference['publisher']},"
          "#{@reference['year']}."
        ]

        result.join ' '
      , (error) ->
        false

    dissertation_reference: (naid) ->
      url = "http://ci.nii.ac.jp/naid/#{naid}.json"
      _fetch(url).then (response) ->
        @reference = _basic_information response

        result = [
          "#{@reference['authors']}."
          "#{@reference['title']}."
          "#{@reference['publisher']}."
          "#{@reference['year']},"
          "博士論文."
        ]
        result.join ' '
      , (error) ->
        false

    _fetch = (url) ->
      new Promise (resolve, reject) ->
        request = new XMLHttpRequest()
        request.open 'GET', url
        request.onload = ->
          if request.readyState == 4 && request.status == 200
            resolve JSON.parse(request.response)['@graph'][0]
          else
            reject Error 'Communication error'

        request.onerror = ->
          reject Error 'Communication error'

        request.send()

    _basic_information = (response) ->
      reference = {}
      authors = []
      reference['title'] = response['dc:title'][0]['@value']
      reference['publisher'] = response['dc:publisher'][0]['@value']

      if response['prism:publicationName']
        reference['publicationName'] =
          response['prism:publicationName'][0]['@value']
      reference['year'] = response['dc:date'].match(/\d{4}/)[0]

      for key, value of response['foaf:maker']
        authors.push value['foaf:name'][0]['@value'].replace /(\s|　|,)+/, ''
      reference['authors'] = authors.join ', '
      return reference

  cinii: ->
    return new CiNii


chrome.tabs.getSelected null, (tab) ->
  sist02 = new Sist02
  url = new URL tab.url
  title = tab.title

  switch true
    when title.indexOf('CiNii Article') > -1, title.indexOf('CiNii 論文') > -1
      naid = url.pathname.replace /\/naid\//, ''
      sist02.cinii().article_reference(naid).then (result) ->
        if result
          document.getElementById('reference').value = result
        else
          console.log result

    when title.indexOf('CiNii Books') > -1, title.indexOf('CiNii 図書') > -1
      ncid = url.pathname.replace /\/ncid\//, ''
      sist02.cinii().book_reference(ncid).then (result) ->
        if result
          document.getElementById('reference').value = result
        else
          console.log result

    when title.indexOf('CiNii Dissertations')>-1,title.indexOf('CiNii 博士論文')>-1
      naid = url.pathname.replace /\/naid\//, ''
      sist02.cinii().dissertation_reference(naid).then (result) ->
        if result
          document.getElementById('reference').value = result
        else
          console.log result

  return