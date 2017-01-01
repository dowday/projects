<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
xmlns="http://www.opengis.net/citygml/1.0"
xmlns:city="http://www.opengis.net/citygml/1.0"
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:trans="http://www.opengis.net/citygml/transportation/1.0" xmlns:wtr="http://www.opengis.net/citygml/waterbody/1.0" xmlns:gml="http://www.opengis.net/gml" xmlns:smil20lang="http://www.w3.org/2001/SMIL20/Language" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:grp="http://www.opengis.net/citygml/cityobjectgroup/1.0" xmlns:luse="http://www.opengis.net/citygml/landuse/1.0" xmlns:frn="http://www.opengis.net/citygml/cityfurniture/1.0" xmlns:app="http://www.opengis.net/citygml/appearance/1.0" xmlns:tex="http://www.opengis.net/citygml/texturedsurface/1.0" xmlns:smil20="http://www.w3.org/2001/SMIL20/" xmlns:xAL="urn:oasis:names:tc:ciq:xsdschema:xAL:2.0" xmlns:bldg="http://www.opengis.net/citygml/building/1.0" xmlns:dem="http://www.opengis.net/citygml/relief/1.0" xmlns:veg="http://www.opengis.net/citygml/vegetation/1.0" xmlns:gen="http://www.opengis.net/citygml/generics/1.0" xsi:schemaLocation="http://www.opengis.net/citygml/landuse/1.0 http://schemas.opengis.net/citygml/landuse/1.0/landUse.xsd http://www.opengis.net/citygml/cityfurniture/1.0 http://schemas.opengis.net/citygml/cityfurniture/1.0/cityFurniture.xsd http://www.opengis.net/citygml/appearance/1.0 http://schemas.opengis.net/citygml/appearance/1.0/appearance.xsd http://www.opengis.net/citygml/texturedsurface/1.0 http://schemas.opengis.net/citygml/texturedsurface/1.0/texturedSurface.xsd http://www.opengis.net/citygml/transportation/1.0 http://schemas.opengis.net/citygml/transportation/1.0/transportation.xsd http://www.opengis.net/citygml/waterbody/1.0 http://schemas.opengis.net/citygml/waterbody/1.0/waterBody.xsd http://www.opengis.net/citygml/building/1.0 http://schemas.opengis.net/citygml/building/1.0/building.xsd http://www.opengis.net/citygml/relief/1.0 http://schemas.opengis.net/citygml/relief/1.0/relief.xsd http://www.opengis.net/citygml/vegetation/1.0 http://schemas.opengis.net/citygml/vegetation/1.0/vegetation.xsd http://www.opengis.net/citygml/cityobjectgroup/1.0 http://schemas.opengis.net/citygml/cityobjectgroup/1.0/cityObjectGroup.xsd http://www.opengis.net/citygml/generics/1.0 http://schemas.opengis.net/citygml/generics/1.0/generics.xsd"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
>
      <!-- copy everything as-is unless overridden -->
  <!--<xsl:template match="@*|node()">-->
    <!--<xsl:copy><xsl:apply-templates select="@*|node()" /></xsl:copy>-->
  <!--</xsl:template>-->

  <!-- ignore jobs *not* named dummy, apart from the first one -->
  <!--<xsl:template match="bldg:Building [not(@gml:id = 'GUID_10QgzD6xjEs83YOepxBvOB')][position() &gt; 1]" />-->
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
<!--    (contains(Haus-3, 'Haus-3'))    -->

    <xsl:template match="city:CityModel">
        <!--    ↓ building Ground floor -->
        <xsl:for-each select="city:cityObjectMember/bldg:Building/bldg:boundedBy/bldg:GroundSurface/bldg:lod3MultiSurface/gml:MultiSurface/gml:surfaceMember/gml:Polygon/gml:exterior/gml:LinearRing">

            <xsl:variable name="vpoint" select="gml:posList"/>
            <xsl:variable name="nbelt" select="string-length(normalize-space(gml:posList))-string-length(translate(normalize-space(gml:posList),' ','')) +1"/>
            <xsl:variable name="sqnbelt" select="$nbelt div 3 - 1"/>
			<shape>
				<IndexedFaceSet>
                    <xsl:attribute name = "solid" ><xsl:value-of select = "false()"/></xsl:attribute>
                <xsl:attribute name="coordindex">
                    <xsl:value-of select="0 to ($sqnbelt)" separator=" "/>
                </xsl:attribute>
                    <Coordinate>
                        <xsl:attribute name= "point" ><xsl:value-of select = "$vpoint" /></xsl:attribute>
                    </Coordinate>

				</IndexedFaceSet>
				<Appearance>
						 <Material diffuseColor="210 75 75"></Material>
                    <!-- #D24B4B-->
				</Appearance>
			</shape>
        </xsl:for-each>

            <!--↓ Building bounded by wall surface-->
        <xsl:for-each select="city:cityObjectMember/bldg:Building/bldg:boundedBy/bldg:WallSurface/bldg:lod3MultiSurface/gml:MultiSurface/gml:surfaceMember/gml:Polygon/gml:exterior/gml:LinearRing">
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
                             <Material diffuseColor="209 159 136"></Material>
                        <!--#D19F88-->
                    </Appearance>
                </shape>
            </xsl:for-each>

            <!--↓ building bounded by Wall surface bounded by the opening  Door-->
        <xsl:for-each select="city:cityObjectMember/bldg:Building/bldg:boundedBy/bldg:WallSurface/bldg:opening/bldg:Door/bldg:lod3MultiSurface/gml:MultiSurface/gml:surfaceMember/gml:Polygon/gml:exterior/gml:LinearRing">
                <shape>
                    <IndexedFaceSet>
                        <xsl:variable name="vpoint" select="gml:posList"/>
                        <xsl:variable name="nbelt" select="string-length(normalize-space(gml:posList)) - string-length(translate(normalize-space(gml:posList),' ','')) +1"/>
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
                             <Material diffuseColor="102 51 0"></Material>
                    </Appearance>
                </shape>
            </xsl:for-each>

            <!--↓ Building bounded by Wall surface bounded by the opening  Window-->
        <xsl:for-each select="city:cityObjectMember/bldg:Building/bldg:boundedBy/bldg:WallSurface/bldg:opening/bldg:Window/bldg:lod3MultiSurface/gml:MultiSurface/gml:surfaceMember/gml:Polygon/gml:exterior/gml:LinearRing">
                <shape>
                    <IndexedFaceSet>
                        <xsl:variable name="vpoint" select="gml:posList"/>
                        <xsl:variable name="nbelt" select="string-length(normalize-space(gml:posList)) - string-length(translate(normalize-space(gml:posList),' ','')) +1"/>
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
                             <Material diffuseColor="255 255 204"></Material>
                        <!-- #EFE3DA-->
                    </Appearance>
                </shape>

        </xsl:for-each>

            <!--↓ building bounded by roof surface-->
        <xsl:for-each select="city:cityObjectMember/bldg:Building/bldg:boundedBy/bldg:RoofSurface/bldg:lod3MultiSurface/bldg:lod3MultiSurface/gml:surfaceMember/gml:Polygon/gml:exterior/gml:LinearRing">
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
                             <Material diffuseColor="255 0 0"></Material>
                        <!-- #D24B4B-->
                    </Appearance>
                </shape>
            </xsl:for-each>

            <!--↓ building outer building installation-->
        <xsl:for-each select="city:cityObjectMember/bldg:Building/bldg:outerBuildingInstallation/bldg:BuildingInstallation/bldg:lod4Geometry/gml:MultiSurface/gml:surfaceMember/gml:Polygon/gml:exterior/gml:LinearRing">
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
						 <Material diffuseColor="210 75 75"></Material>
				</Appearance>
			</shape>
    </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>