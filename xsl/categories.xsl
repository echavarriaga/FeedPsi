<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  exclude-result-prefixes="msxsl"
  >

  <xsl:output method="html" indent="yes" encoding="utf-8"/>

  <xsl:template match="/SetOfNews">
    <div class="ui-widget-header ui-corner-all viewrss-menu-title">Categorías</div> 
    <ul id="categories-menu-items" class="ui-helper-reset">
      <xsl:apply-templates select="Category"/>
    </ul>
    <script type="text/javascript">
      $("#categories-menu-items").sortable();
      $("#categories-menu-items").disableSelection();
    </script>
  </xsl:template>

  <xsl:template match="Category">
    <li class="viewrss-category">
      <h5 class="viewrss-category-title ui-state-hover ui-corner-all">
        <span class="ui-icon ui-icon-close" onclick="$(this).parent().parent().remove()"></span>
        <span class="ui-icon ui-icon-minus" onclick="$(this).toggleClass('ui-icon-minus').toggleClass('ui-icon-plus'); $(this).parent().parent().find('.news-content').toggle();"></span>
        <xsl:value-of select="@name"/>
      </h5>
      <div class="news-content">
        <xsl:apply-templates select="News"/>
      </div>
    </li>
  </xsl:template>
  
  <xsl:template match="News">
    <xsl:element name="div">
      <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
      <xsl:attribute name="class">tip-menu-item</xsl:attribute>
      <xsl:element name="a">
        <xsl:attribute name="id">clink-<xsl:value-of select="@id"/></xsl:attribute>
        <xsl:attribute name="href">#</xsl:attribute>
        <xsl:value-of select="title/text()"/>
      </xsl:element>
      <div class="date">
        <xsl:element name="img">
          <xsl:attribute name="src"><xsl:value-of select="@image"/></xsl:attribute>
          <xsl:attribute name="width">50</xsl:attribute>
        </xsl:element>
        <span><xsl:value-of select="pubDate/text()"/></span> 
      </div> 
      <script type="text/javascript">
        $("#clink-<xsl:value-of select="@id"/>").click(function(){
          $("#boxRSS").tinyViewerRSS("transformViewNews", "<xsl:value-of select="@id"/>");
        });
      </script>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>
