<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  exclude-result-prefixes="msxsl"
  >

  <xsl:output method="html" indent="yes" encoding="utf-8"/>

  <xsl:template match="/SetOfNews">
    <header class="viewrss-header">
      <img style="float:left;" src="images/top.png" />
    </header>
    
    <section class="viewrss-main">
      <table style="width:100%">
        <tr>
          <td class="viewrss-menu">
            <div class="ui-widget-header ui-corner-all viewrss-menu-title">Fuentes RSS</div>
            <ul id="viewrss-menu-items" class="viewrss-menu-items ui-helper-reset ui-helper-clearfix">
              <xsl:apply-templates select="RSS"/>
            </ul>
            <script type="text/javascript">
              $("#viewrss-menu-items").sortable();
              $("#viewrss-menu-items").disableSelection();
            </script>
          </td>
          <td class="viewrss-view-news">
            <div class="ui-state-default ui-corner-all viewrss-menu-title">
              <span class="ui-icon ui-icon-circle-triangle-e" onclick="$(this).toggleClass('ui-icon-circle-triangle-e').toggleClass('ui-icon-circle-triangle-w'); $('.viewrss-categories').toggle();"></span>
              Últimas Noticas
            </div>
            <section class="viewrss-content-view-news"></section>
          </td>
          <td class="viewrss-categories"></td>
        </tr>
      </table> 
    </section>
    <footer class="viewrss-footer"></footer>
  </xsl:template>

  <xsl:template match="RSS">
    <li class="ui-widget-content ui-corner-tr">
      <h5 class="ui-state-hover ui-corner-all">
        <xsl:value-of select="@name"/>
      </h5>
      <xsl:element name="div">
        <xsl:attribute name="id">menu-<xsl:value-of select="@id"/></xsl:attribute>  
        <xsl:attribute name="class">news-content</xsl:attribute>
        <img src="images/wait.png" />
      </xsl:element>
    </li>
  </xsl:template>

</xsl:stylesheet>
