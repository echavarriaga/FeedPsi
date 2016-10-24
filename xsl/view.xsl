<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" indent="yes" encoding="utf-8"/>
  <xsl:param name="newsId"/>
  
  <xsl:template match="/SetOfNews">
    <xsl:apply-templates select="RSS/News[@id=$newsId]"/>
  </xsl:template>

  <xsl:template match="News">
    <h4>
      <span class="ui-icon ui-icon-closethick" onclick="$(this).parent().parent().remove()"></span>
      <span class="ui-icon ui-icon-minusthick" onclick="$(this).toggleClass('ui-icon-minusthick').toggleClass('ui-icon-plusthick'); $(this).parent().parent().find('.view-news-detail').toggle();"></span>
      <xsl:value-of select="title/text()"/>
    </h4>
    <div class="date">
      <xsl:element name="img">
        <xsl:attribute name="src"><xsl:value-of select="../@image"/></xsl:attribute>
        <xsl:attribute name="width">50</xsl:attribute>
      </xsl:element>
      <span><xsl:value-of select="pubDate/text()"/></span> 
    </div> 
    <div class="view-news-detail">
      <xsl:element name="p">
        <xsl:attribute name="id">description-<xsl:value-of select="@id"/></xsl:attribute>
        <xsl:value-of select="description/text()"/>
      </xsl:element> 
      <xsl:element name="button">
        <xsl:attribute name="id">view-<xsl:value-of select="@id"/></xsl:attribute>
        Ver...
      </xsl:element>
      <xsl:element name="button">
        <xsl:attribute name="id">hide-<xsl:value-of select="@id"/></xsl:attribute>
        Ocultar...
      </xsl:element>
      <xsl:element name="select">
        <xsl:attribute name="id">select-<xsl:value-of select="@id"/></xsl:attribute>
        <option value="none">Enviar a sección ...</option>
        <xsl:for-each select="../../Category">
          <xsl:element name="option">
            <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
            <xsl:value-of select="@name"/>  
          </xsl:element>
        </xsl:for-each>
      </xsl:element>
      <xsl:element name="iframe">
        <xsl:attribute name="id">iframe-<xsl:value-of select="@id"/></xsl:attribute>
        <xsl:attribute name="style">display:none; height:500px; width:100%;</xsl:attribute>
        <xsl:attribute name="class">ui-corner-all</xsl:attribute>
        Ver...
      </xsl:element>
    </div>  
    <script type="text/javascript">
      var desc = $("#description-<xsl:value-of select="@id"/>"),
      text = desc.html();
      if (text.indexOf("160;")>0) desc.empty().text(text.substr(0, text.indexOf("160;")-2));
      if (text.indexOf("...")>0) desc.empty().text(text.substr(0, text.indexOf("...")+3));
      if (text.indexOf("a href")>0) desc.empty().text(text.substr(0, text.indexOf("a href")-1));
      if (text.indexOf("img src")>0) desc.empty().text(text.substr(0, text.indexOf("img src")-1));
      if (text.indexOf("p>")>0) desc.empty().text(text.substr(0, text.indexOf("p>")-1));
      if (text.indexOf("iframe")>0) desc.empty().text(text.substr(0, text.indexOf("iframe")-1));
      $("#view-<xsl:value-of select="@id"/>")
        .button({ icons: { primary: "ui-icon-search" } })
        .css("font-size", ".7em")
        .click(function(){
          var iframe = $("#iframe-<xsl:value-of select="@id"/>");
          iframe.show();
          if (!iframe.attr("src"))
            iframe.attr("src", "<xsl:value-of select="link/text()"/>");
        });
      $("#hide-<xsl:value-of select="@id"/>")
        .button({ icons: { primary: "ui-icon-cancel" } })
        .css("font-size", ".7em")
        .click(function(){
          $("#iframe-<xsl:value-of select="@id"/>").hide();
        });
      $("#select-<xsl:value-of select="@id"/>")
        .addClass("ui-corner-all")
        .change(function(){
          if ($(this).val()!="none")
            rssContent.tinyViewerRSS("moveNews", "<xsl:value-of select="@id"/>", $(this).val());
        });
    </script>
  </xsl:template>

</xsl:stylesheet>
