$(function(){
  var PDFMergeBox = React.createClass({
    getInitialState: function(){
      return {file_data: null};
    },
    handleFile: function(e){
      file = e.target.files[0];
      formData = new FormData();
      formData.append("file", file, file.name);
      this.setState({file_data: formData});
    },
    uploadFile: function(e){
      current_url = window.location.toString();
      $.ajax({
        url: "/home",
        data: this.state.file_data,
        type: "POST",
        cache: false,
        processData: false,
        contentType: false
      }).done(function(data){
        var blob = new Blob([data]);
        var link = document.createElement("a");
        link.href = window.URL.createObjectURL(blob);
        link.download = new Date() + ".pdf";
        link.click();
        return
      }.bind(this));
      return false;
    },
    render: function(){
      return (
        <form ref="mergeForm" encType="multipart/form-data" onSubmit={this.uploadFile}>
          <input type="file" onChange={this.handleFile} />
          <input type="submit" name="commit" value="Merge"/>
        </form>
      );
    }
  });
  React.render(<PDFMergeBox />, document.getElementById("pdf_merge"));
})
