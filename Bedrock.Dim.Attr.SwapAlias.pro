﻿601,100
562,"NULL"
586,"Bedrock.Temp"
585,"Bedrock.Temp"
564,
565,"pG3zIUg;tEz@qwavaFy78bXr9@=vcZ5D>r[r=JroOdsu<7n`0ts2sAxCX2cF0czCaD`OG_rw;HjpTHw:WRe[mTdtG]@7E[CDi:z;0NysuxzWqk_j@r]UHVseQf<pg]>9<sX6>eIgn`PuTuHEbkC6QS6auG`7yqYiex[x5OXxHCm>J2U7\@Ai`PRLs]c[9ZVa[ZUF`ox_"
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
560,3
pDimension
pAlias
pDebug
561,3
2
2
1
590,3
pDimension,""
pAlias,""
pDebug,0.
637,3
pDimension,Dimension
pAlias,Alias
pDebug,Debug Mode
577,0
578,0
579,0
580,0
581,0
582,0
572,91

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 1.0.0~~##
#####################################################################################

### Constants ###

cProcess = 'Bedrock.Dim.Attr.SwapAlias';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.';
cCubeAttr = '}ElementAttributes_' | pDimension;


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pDimension : ' | pDimension );
  AsciiOutput( sDebugFile, '            pAlias     : ' | pAlias );

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
  ItemReject( sMessage );
EndIf;
If( DimensionExists( pDimension ) = 0 );
  nErrors = 1;
  sMessage = 'Dimension: ' | pDimension | ' does not exist';
 If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;

# Validate alias
If( Trim( pAlias ) @= '' );
  nErrors = 1;
  sMessage = 'No alias specified';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;
If( DimIx( cCubeAttr, pAlias ) = 0 );
  nErrors = 1;
  sMessage = 'Alias: ' | pAlias | ' does not exist in dimension: ' | pDimension;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;
sElementType = DType( cCubeAttr, pAlias );
If( sElementType @<> 'AA' );
  nErrors = 1;
  sMessage = 'Attribute: ' | pAlias | ' is not a valid alias';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  ItemReject( sMessage );
EndIf;


### Swap Dimension ###

If( pDebug <= 1 );
  SwapAliasWithPrincipalName( pDimension, pAlias, 0);
EndIf;


### End Prolog ###
573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,6

#****Begin: Generated Statements***
#****End: Generated Statements****



575,35

#****Begin: Generated Statements***
#****End: Generated Statements****

#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 1.0.0~~##
#####################################################################################


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
918,1
919,0
920,50000
921,""
922,""
923,0
924,""
925,""
926,""
927,""