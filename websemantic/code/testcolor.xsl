<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
xmlns="http://www.opengis.net/citygml/1.0"
xmlns:city="http://www.opengis.net/citygml/1.0"
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:trans="http://www.opengis.net/citygml/transportation/1.0" xmlns:wtr="http://www.opengis.net/citygml/waterbody/1.0" xmlns:gml="http://www.opengis.net/gml" xmlns:smil20lang="http://www.w3.org/2001/SMIL20/Language" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:grp="http://www.opengis.net/citygml/cityobjectgroup/1.0" xmlns:luse="http://www.opengis.net/citygml/landuse/1.0" xmlns:frn="http://www.opengis.net/citygml/cityfurniture/1.0" xmlns:app="http://www.opengis.net/citygml/appearance/1.0" xmlns:tex="http://www.opengis.net/citygml/texturedsurface/1.0" xmlns:smil20="http://www.w3.org/2001/SMIL20/" xmlns:xAL="urn:oasis:names:tc:ciq:xsdschema:xAL:2.0" xmlns:bldg="http://www.opengis.net/citygml/building/1.0" xmlns:dem="http://www.opengis.net/citygml/relief/1.0" xmlns:veg="http://www.opengis.net/citygml/vegetation/1.0" xmlns:gen="http://www.opengis.net/citygml/generics/1.0" xsi:schemaLocation="http://www.opengis.net/citygml/landuse/1.0 http://schemas.opengis.net/citygml/landuse/1.0/landUse.xsd http://www.opengis.net/citygml/cityfurniture/1.0 http://schemas.opengis.net/citygml/cityfurniture/1.0/cityFurniture.xsd http://www.opengis.net/citygml/appearance/1.0 http://schemas.opengis.net/citygml/appearance/1.0/appearance.xsd http://www.opengis.net/citygml/texturedsurface/1.0 http://schemas.opengis.net/citygml/texturedsurface/1.0/texturedSurface.xsd http://www.opengis.net/citygml/transportation/1.0 http://schemas.opengis.net/citygml/transportation/1.0/transportation.xsd http://www.opengis.net/citygml/waterbody/1.0 http://schemas.opengis.net/citygml/waterbody/1.0/waterBody.xsd http://www.opengis.net/citygml/building/1.0 http://schemas.opengis.net/citygml/building/1.0/building.xsd http://www.opengis.net/citygml/relief/1.0 http://schemas.opengis.net/citygml/relief/1.0/relief.xsd http://www.opengis.net/citygml/vegetation/1.0 http://schemas.opengis.net/citygml/vegetation/1.0/vegetation.xsd http://www.opengis.net/citygml/cityobjectgroup/1.0 http://schemas.opengis.net/citygml/cityobjectgroup/1.0/cityObjectGroup.xsd http://www.opengis.net/citygml/generics/1.0 http://schemas.opengis.net/citygml/generics/1.0/generics.xsd"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
>

<xsl:output method="html"/>

<xsl:template match="/">
<html>
  <head> <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1" />
         <title>My 3D page</title>
         <link rel="stylesheet" type="text/css"
              href="./x3dom.css">
         </link>
   <script
     type="text/javascript"
     src="./x3dom.js"/>

  </head>

<body>
  <x3d width="1600px" height="900px">
   <scene dopickpass="true" pickmode="idBuf" bboxsize="-1,-1,-1"  bboxcenter="0,0,0" render="true">

   <transform translation="-400 -400 -8">
      <xsl:apply-templates />

	</transform>
   </scene>
  </x3d>
</body>
</html>
</xsl:template>

<xsl:template match="text()">  <!-- text nodes are ignored -->
</xsl:template>

<!-- OTHER TEMPLATES -->

<xsl:template match="city:CityModel">  <!-- text nodes are ignored -->
    <!--    ↓ Water Body    -->
		<xsl:for-each select="city:cityObjectMember/wtr:WaterBody/wtr:boundedBy/wtr:WaterSurface/wtr:lod3Surface/gml:CompositeSurface/gml:surfaceMember/gml:Polygon/gml:exterior/gml:LinearRing">
			<shape>
				<IndexedFaceSet>
					<xsl:variable name="vpoint" select="gml:posList"/>
					<xsl:variable name="nbelt" select="string-length(normalize-space(gml:posList))- string-length(translate(normalize-space(gml:posList),' ','')) +1"/>
					<xsl:variable name="sqnbelt" select="$nbelt div 3 - 1"/>

                <xsl:attribute name = "solid" ><xsl:value-of select = "false()"/></xsl:attribute>
                <xsl:attribute name="coordindex">
                    <xsl:value-of select="0 to ($sqnbelt)" separator=" "/>
                </xsl:attribute>

                    <Coordinate>
                        <xsl:attribute name= "point" ><xsl:value-of select = "$vpoint" /></xsl:attribute>
                    </Coordinate>

				</IndexedFaceSet>
				<Appearance>
						 <Material diffuseColor="#00CCFF"></Material>
				</Appearance>
			</shape>
		</xsl:for-each>
    <!--    ↓ Plant cover  -->
        <xsl:for-each select="city:cityObjectMember/veg:PlantCover/veg:lod3MultiSurface/gml:MultiSurface/gml:surfaceMember/gml:Polygon/gml:exterior/gml:LinearRing">
            <shape>
                <IndexedFaceSet>
                    <xsl:variable name="vpoint" select="gml:posList"/>
                    <xsl:variable name="nbelt" select="string-length(normalize-space(gml:posList))
                    - string-length(translate(normalize-space(gml:posList),' ','')) +1"/>
                    <xsl:variable name="sqnbelt" select="$nbelt div 3 - 1"/>

                <xsl:attribute name = "solid" ><xsl:value-of select = "false()"/></xsl:attribute>
                <xsl:attribute name="coordindex">
                    <xsl:value-of select="0 to ($sqnbelt)" separator=" "/>
                </xsl:attribute>

                    <Coordinate>
                        <xsl:attribute name= "point" ><xsl:value-of select = "$vpoint" /></xsl:attribute>
                    </Coordinate>

                </IndexedFaceSet>
                <Appearance>
                         <Material diffuseColor="#006600"></Material>
                </Appearance>
            </shape>
        </xsl:for-each>
</xsl:template>

</xsl:stylesheet>
