﻿601,100
562,"SUBSET"
586,"zTestDim"
585,"zTestDim"
564,
565,"bvasXBJF2eB4ZXo;lCt;p3bN1H:^j6[yFsmJ<PTLIc\=n>mHDfN1DTL8;tMxF\CzkFj4UVLvMNNYhV0liMm_3ooiEUkhC>dtv_rui<Qxt540^KqXB;svyl^k@tdV`LI\Uy\fahI`\7c2<hf=a<jrnmL9vxwk?EVCAqz29RHNKUn9ryuts3Q6XJ;ArFpm6eWAhQUS_V_v"
559,1
928,0
593,
594,
595,
597,
598,
596,
800,
801,
566,0
567,","
588,"."
589,
568,""""
570,
571,All
569,0
592,0
599,1000
560,4
pDimension
pConsol
pRecursive
pDebug
561,4
2
2
1
1
590,4
pDimension,""
pConsol,""
pRecursive,0.
pDebug,0.
637,4
pDimension,Target Dimension
pConsol,Target Consolidation
pRecursive,Boolean: 1 = True (break from node down not just direct children)
pDebug,Debug Mode
577,1
vElement
578,1
2
579,1
1
580,1
0
581,1
0
582,1
VarType=32ColType=827
572,133

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 1.0.0~~##
#####################################################################################

# This process will remove all children from a specific target consolidation in the target dimension
# If recursive will also unwind all consolidations that are children of the target regardless of depth

# Note:
# - If consolidations are also used in unrelated hierarchies and recursive is selected this will result in
#   orphan consolidations in the other hierarchies


### Constants ###

cProcess = 'Bedrock.Dim.Hierarchy.Unwind.Consolidation';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.';
cHierAttr = 'Bedrock.Descendant';
cAttrVal = 'Descendant';


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pDimension : ' | pDimension );
  AsciiOutput( sDebugFile, '            pConsol    : ' | pConsol );
  AsciiOutput( sDebugFile, '            pRecursive : ' | NumberToString( pRecursive ) );

EndIf;


### Validate Parameters ###

nErrors = 0;

# Validate dimension
If( Trim( pDimension ) @= '' );
  nErrors = 1;
  sMessage = 'No dimension specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;
If( DimensionExists( pDimension ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid dimension: ' | pDimension;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

# Validate consol
If( Trim( pConsol ) @= '' );
  nErrors = 1;
  sMessage = 'No consol specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;
If( DimIx( pDimension, pConsol ) = 0 % DType( pDimension, pConsol ) @<> 'C' % ElCompN( pDimension, pConsol ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid consolidation: ' | pConsol | '. Not a C element or no children.';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;


### Set Descendent attribute value

AttrDelete( pDimension, cHierAttr );
AttrInsert( pDimension, '', cHierAttr, 'S' );

nElementIndex = 1;
nElementCount = DimSiz( pDimension );
While( nElementIndex <= nElementCount );
  sElement = DimNm( pDimension, nElementIndex );
  If( ElIsAnc( pDimension, pConsol, sElement ) = 1 );
    AttrPutS( cAttrVal, pDimension, sElement, cHierAttr );
  EndIf;
  nElementIndex = nElementIndex + 1;
End;


### Remove direct children from the target consol ###

nChildren = ElCompN( pDimension, pConsol );

While( nChildren > 0 );
  # Unwind direct children of target hierarchy only
  sChild = ElComp( pDimension, pConsol, nChildren );
  If( pDebug <= 1 );
    DimensionElementComponentDelete( pDimension, pConsol, sChild );
  EndIf;
  nChildren = nChildren - 1;
End;


### Assign data source ###

If( pRecursive = 1 & pDebug <= 1 );
  # Assign Data Source
  DataSourceType = 'SUBSET';
  DatasourceNameForServer = pDimension;
  DatasourceNameForClient = pDimension;
  DatasourceDimensionSubset = 'ALL';
Else;
  # No data source, straight to Epilog
  DataSourceType = 'NULL';
EndIf;


### End Prolog ###
573,35

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 1.0.0~~##
#####################################################################################


### Check for errors in prolog ###

If( nErrors <> 0 );
  ProcessBreak;
EndIf;


### Break all parent/child links below target consol ###

If( ElLev( pDimension, vElement ) = 0 );
  ItemSkip;
EndIf;

If( AttrS( pDimension, vElement, cHierAttr ) @= cAttrVal & DType( pDimension, vElement ) @= 'C' & ElCompN( pDimension, vElement ) > 0 );
  nChildren = ElCompN( pDimension, vElement );
  While( nChildren > 0 );
    sChild = ElComp( pDimension, vElement, nChildren );
    If( pDebug <= 1 );
      DimensionElementComponentDelete( pDimension, vElement, sChild );
    EndIf;
    nChildren = nChildren - 1;
  End;
EndIf;


### End Metadata ###
574,3

#****Begin: Generated Statements***
#****End: Generated Statements****
575,42

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 1.0.0~~##
#####################################################################################


### Remove Descendent attribute

If( nErrors = 0 & pDebug <= 1 );
  AttrDelete( pDimension, cHierAttr );
EndIf;


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Epilog.debug';

  # Log errors
  If( nErrors <> 0 );
    AsciiOutput( sDebugFile, 'Errors Occurred' );
  EndIf;

  # Log finish time
  AsciiOutput( sDebugFile, 'Process Finished: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

EndIf;


### If errors occurred terminate process with a major error status ###

If( nErrors <> 0 );
  ProcessQuit;
EndIf;


### End Epilog ###
576,CubeAction=1511DataAction=1503CubeLogChanges=0
638,1
804,0
1217,1
900,
901,
902,
903,
906,
929,
907,
908,
904,0
905,0
909,0
911,
912,
913,
914,
915,
916,
917,0
918,0
919,0
920,50000
921,""
922,""
923,0
924,""
925,""
926,""
927,""