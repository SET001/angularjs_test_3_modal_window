Modal = angular.module 'TestModal', []
Modal.provider 'TestModal', () ->
  $get: ($rootScope, $http, $document, $q) ->

    settings:
      title: ''
      text: ''
      buttons: []

    load_template: (url) ->
      $http.get(url).then (response) =>
        response.data

    get_content: () ->
      if @settings.templateUrl
        @load_template @settings.templateUrl
      else
        buttons = ''
        if @settings.buttons.length > 0
          for button in @settings.buttons
            buttons += '<a class="btn btn-primary" href="">' + button.label + '</a>'
        '<div class="modal-dialog dialog-content">
          <div class="modal-header">
            <h3 class="modal-title">' + @settings.title + '</h3>
          </div>
          <div class="modal-body">' + @settings.text + '</div>
          <div class="modal-footer">' + buttons + '</div>
        </div>'
      
    close: ->
      $('#test-dialog').remove()

    open: (settings = {}) ->
      settings = angular.extend @settings, settings

      $q.when(@get_content()).then (content) =>
        dialog = angular.element '<div id="test-dialog">
          <div class="dialog-shadow"></div>'+content+'
          </div>
        </div>'
        unless @settings.templateUrl
          $(dialog).find('.modal-footer .btn').each (i, button) =>
            $(button).click =>
              @settings.buttons[i].callback.call @
              no

        scope = $rootScope.$new()
        base = $document.find 'body'
        base.append dialog
      no

    openAlert: (text, title='Atention') ->
      @open
        title: title
        text: text
        buttons: [
          label: 'ok'
          callback: ->
            @close()
        ]

    openConfirm: (text) ->
      res = $q.defer()
      @open
        text: text
        buttons: [
          label: 'yes'
          callback: ->
            res.resolve()
            @close()
        ,
          label: 'no'
          callback: ->
            res.reject()
            @close()
        ]
      res.promise
