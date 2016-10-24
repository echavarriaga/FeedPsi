<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  exclude-result-prefixes="msxsl"
  >

  <xsl:output method="html" indent="yes" encoding="utf-8"/>
  <xsl:param name="newsId"/>
  
  <xsl:template match="/SetOfNews">
    <xsl:apply-templates select="RSS[@id=$newsId]"/>
  </xsl:template>

  <xsl:template match="RSS">
    <xsl:element name="img">
      <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
      <xsl:attribute name="rel">#tip-<xsl:value-of select="@id"/></xsl:attribute>
      <xsl:attribute name="src"><xsl:value-of select="@image"/></xsl:attribute>
      <xsl:attribute name="width">145</xsl:attribute>
      <xsl:attribute name="alt"><xsl:value-of select="image/title/text()"/></xsl:attribute>
    </xsl:element>
    <xsl:element name="div">
      <xsl:attribute name="id">tip-<xsl:value-of select="@id"/></xsl:attribute>
      <xsl:attribute name="class">tip-menu</xsl:attribute>
      <xsl:apply-templates select="News"/>
    </xsl:element>
    <script type="text/javascript">
      $(document).ready(function () {
        $("#<xsl:value-of select="@id"/>").cluetip({
          local: true, 
          cursor: 'pointer', 
          cluetipClass: 'rounded', 
          arrows: true, 
          showTitle: false,
          sticky: true,
          mouseOutClose: true,
          closeText: 'Cerrar',
        });
      });
    </script>
  </xsl:template>

  <xsl:template match="News">
    <xsl:element name="div">
      <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
      <xsl:attribute name="class">tip-menu-item</xsl:attribute>
      <xsl:element name="a">
        <xsl:attribute name="id">link-<xsl:value-of select="@id"/></xsl:attribute>
        <xsl:attribute name="href">#</xsl:attribute>
        <xsl:value-of select="title/text()"/>
      </xsl:element>
      <script type="text/javascript">
        $("#link-<xsl:value-of select="@id"/>").click(function(){
          rssContent.tinyViewerRSS("transformViewNews", "<xsl:value-of select="@id"/>");
        });
      </script>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>
