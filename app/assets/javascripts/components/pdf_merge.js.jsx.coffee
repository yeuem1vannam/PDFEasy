$ ->
  PDFMergeBox = React.createClass
    getInitialState: ->
      return {file_data: null}

    handleFile: (e)->
      file = e.target.files[0]
      formData = new FormData()
      formData.append("file", file, file.name)
      @setState({file_data: formData})
      return

    uploadFile: (e)->
      $.ajax
        url: "/home"
        data: @state.file_data
        type: "POST"
        cache: false
        processData: false
        contentType: false
      .done (data)->
        blob = new Blob([data])
        link = document.createElement("a")
        link.href = window.URL.createObjectURL(blob)
        link.download = new Date() + ".pdf"
        link.click()
      e.stopPropagation()
      e.preventDefault()
      return

    render: ->
      `<form ref="mergeForm" encType="multipart/form-data" onSubmit={this.uploadFile}>
        <input type="file" onChange={this.handleFile} />
        <input type="submit" name="commit" value="Merge"/>
      </form>`

  React.render `<PDFMergeBox />`, document.getElementById("pdf_merge")