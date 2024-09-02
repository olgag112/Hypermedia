<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html" />

<xsl:template match = "hobby">

    <html>
        <head>
            <link rel="stylesheet" type="text/css" href="project.css"/>
        </head>
        <body>
            <h2> favourite art periods </h2>
         

            <xsl:variable name="number">                                        
                <xsl:for-each select="museums/most_visited">
                    <xsl:sort select="visitors_per_year" data-type="number" order="descending"/>
                    <xsl:if test="position()=1">                                                        
                        <xsl:value-of select='format-number(visitors_per_year, "###,###,###")'/>           
                        <xsl:text> in </xsl:text>
                        <xsl:value-of select="name"/>
                    </xsl:if>
                </xsl:for-each>
            </xsl:variable>

            <xsl:call-template name="artperiods"/>
            <br/>

            <xsl:apply-templates select="media/*/*"/>             
            <br/>

             <h2>quotes</h2>
                  
            <xsl:apply-templates select="quotes/*"/>
            <br/>

            <h2>most expensive art pieces:</h2>
            <br/>
            <xsl:apply-templates select="artists/artist">     
                <xsl:sort select="most_expensive/price" data-type="number" order="descending"/>
            </xsl:apply-templates>

            <br/>


            <h2>most visited museums in the world:</h2>
            <br/>
            
            <xsl:apply-templates select="museums/most_visited">   
                
            </xsl:apply-templates>
            <br/>

            <h2>number of visitors per year in the most visited art museum and its name: <xsl:value-of select="$number"/> </h2>
             <br/>

             <h2>my favourite artists:</h2>
             <xsl:apply-templates select="artists"/>
             <br/>
             <br/>

             <h2>definitions</h2>
             <xsl:apply-templates select="theory/painting/@theory"/>
             <br/>
           

             <h2>artmedia</h2>
             <xsl:apply-templates select="theory/artmedia/*"/>

             <h2>representatives of given art periods:</h2>
             <xsl:apply-templates select="artists/artist/name"/>
             
        </body>
    </html>

</xsl:template>



<xsl:template name="artperiods">       
    <table border="1">      
            <tr>
               <th> name </th>
               <th> duration </th>
               <th> main theme </th>
               <th> main artist </th>
               <th> main trends </th>
            </tr>
         <xsl:apply-templates select="artperiods/artperiod"/>           
    </table>
</xsl:template>


<xsl:template match="artperiod">              
    <tr>
        <td><xsl:value-of select="name"/></td>
        <td><xsl:value-of select="duration"/></td>
        <td><xsl:value-of select="maintheme"/></td>
        <td><xsl:value-of select="mainartist"/></td>
        <td><xsl:value-of select="maintrends"/></td>    
    </tr>
</xsl:template>



<xsl:template match="media/*/*">       
    <xsl:if test="name()='image'">              
        <xsl:element name="image">
            <xsl:attribute name="src">
                <xsl:value-of select="@source"/>
            </xsl:attribute>
        </xsl:element>
    </xsl:if>
    <br/>
    <xsl:if test="name()='link'">
        <li>
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="@source"/>
            </xsl:attribute>
                <xsl:value-of select="."/>
        </xsl:element>
        </li>
    </xsl:if>
</xsl:template>


<xsl:template match="quotes/*">           
        index of quote:
     <xsl:number count="*"/>                       
        <br/>
     <xsl:value-of select="current()"/>       
        <br/>
</xsl:template>


<xsl:template match="artist">      
    <p>
    <xsl:value-of select="position()"/>
        <xsl:text>. </xsl:text>
    <xsl:value-of select='format-number(most_expensive/price, "$#")'/>       
            <xsl:text>, </xsl:text>
    <xsl:value-of select="most_expensive/name"/>
        <br/>
    <xsl:text>(original index:</xsl:text>
    <xsl:number format="I"/>)                        
         <br/>
    </p>
</xsl:template>


<xsl:template match="most_visited">        
    <xsl:variable name="year" select="year_of_founding"/> 
    <p>
        <xsl:value-of select="concat(name, ', ', city,', established in ')"/>       
        <xsl:value-of select="$year"/>
        
    </p>
</xsl:template>


<xsl:template match="artists">         

    <xsl:variable name="fav_artists">              
        <xsl:value-of select="artist[1]/name"/>         
        <xsl:value-of select="artist[last()]/name"/>        
    </xsl:variable>

    <xsl:value-of select="$fav_artists"/>
</xsl:template>


<xsl:template match="@theory">           
   <div>
        <div class="def">
        <xsl:value-of select="../type[1]/name"/> </div>      
        <br/>
        <xsl:value-of select="../type[1]/def"/>         
   </div>
</xsl:template>


<xsl:template match="artmedia/*">          
    <xsl:choose>
        <xsl:when test="name()='trad'">         
            <div class="red">
                <xsl:value-of select="."/>
            </div>
        </xsl:when>
        <xsl:when test="name()='modern'">
            <div class="blue">
                <xsl:value-of select="."/>
            </div>
        </xsl:when>
    </xsl:choose>
</xsl:template>


<xsl:template match="name">         
   
    <xsl:variable name="year" select="../birth_year"/>
    
    <xsl:if test="$year &lt; 1500">
        <xsl:value-of select="/hobby/artperiods/artperiod[1]/name"/>
    </xsl:if>

    <xsl:if test="$year > 1500 and $year &lt; 1845">
        <xsl:value-of select="/hobby/artperiods/artperiod[2]/name"/>
    </xsl:if>

    <xsl:if test="$year > 1845">
        <xsl:value-of select="/hobby/artperiods/artperiod[3]/name"/>
    </xsl:if>
    <xsl:text> - </xsl:text>
     <xsl:value-of select="."/>
    <br/>
</xsl:template>


</xsl:stylesheet>
        