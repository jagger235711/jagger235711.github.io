# 个人简历
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
  $(document).ready(function() {
    $("#viewer").load("https://docs.google.com/gview?url=" + encodeURIComponent("https://docs.google.com/document/d/1UkzMXPBVp9eytP7Klwy8ufZYe8neQCDUfRpiSvUMjpA/view") + "&embedded=true");
    // 等待文档加载完成后调整大小
    setTimeout(function() {
      var iframe = document.getElementById("viewer");
      iframe.style.width = "100%";
      iframe.style.height = "1000px";
      document.body.style.margin = "0";
      document.body.style.overflow = "hidden";
    }, 1000);
  });
</script>
<body>
  <iframe id="viewer" src="https://docs.google.com/document/d/1UkzMXPBVp9eytP7Klwy8ufZYe8neQCDUfRpiSvUMjpA/view"></iframe>
</body>