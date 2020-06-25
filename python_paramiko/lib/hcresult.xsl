<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:hc="http://www.ibm.com">
<xsl:template match="/">
	<html>
  
	<head>
		<title>HC Report</title>
		<style type="text/css">
			body {
				color: #000000;
				font-family: 'verdana';
			}
			.title {
				background: #9acd32;
			}
			.red {
				background: #ff1111;
			}
			table, tr, td {
				font-size: 8.5pt;
			}
		</style>
	</head>
	  
	<body>
		<a name="top" />
		<h2>Health-check Report</h2>
	  
		<table>
			<xsl:for-each select="/hc:out/hc:header">
				<tr>
					<td><xsl:value-of select="@id"/></td>
					<td><xsl:value-of select="@value"/></td>
				</tr>				
			</xsl:for-each>
		</table>
		<br/>

		<table>
			<tr>
				<td colspan="2"><b>Summary:</b></td>
			</tr>
			<tr class="title">
				<th>Configuration</th>
				<th>Compliancy</th>
			</tr>
			<xsl:for-each select="/hc:out/hc:summary/hc:instance">
				<tr>
					<td><a href="#{@instanceId}"><xsl:value-of select="@instanceId"/></a></td>
					<td align="center">
	     				<xsl:choose>
	        				<xsl:when test="@hcCompliancy = 0">
								not ok
	        				</xsl:when>
	        				<xsl:otherwise>
	        					ok
	        				</xsl:otherwise>
	      				</xsl:choose>
					</td>
				</tr>				
			</xsl:for-each>
		</table>
		<br/>

		<xsl:for-each select="/hc:out/hc:instance">
		
			<a name="{@id}" />
			<table>
				<tr>
					<td colspan="3"><a href="#top">top</a></td>
				</tr>
				<tr>
					<td colspan="3"><b>Configuration file <xsl:value-of select="@id"/></b></td>
				</tr>
				<tr class="title">
					<th>Section</th>
					<th>Heading</th>
					<th>Reason</th>
				</tr>
				<xsl:for-each select="hc:rules/hc:rule">
					<tr>
	     				<xsl:choose>
	        				<xsl:when test="@result = 0">
								<td class="red"><xsl:value-of select="hc:section"/></td>
	        				</xsl:when>
	        				<xsl:otherwise>
	        					<td><xsl:value-of select="hc:section"/></td>
	        				</xsl:otherwise>
	      				</xsl:choose>
						    					
						<td><xsl:value-of select="hc:heading"/></td>
	   					<td><xsl:value-of select="hc:reason"/></td>
					</tr>
				</xsl:for-each>
			</table>
			<br/>
		</xsl:for-each>
		
	</body>

	</html>
</xsl:template>

</xsl:stylesheet>