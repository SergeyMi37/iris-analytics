/// 
Class Riches.BI.Cube Extends %DeepSee.CubeDefinition [ DependsOn = Riches.Transact, ProcedureBlock ]
{

/// Cube definition from Architect.
XData Cube [ XMLNamespace = "http://www.intersystems.com/deepsee" ]
{
<cube xmlns="http://www.intersystems.com/deepsee" name="Riches" displayName="Riches" disabled="false" abstract="false" sourceClass="Riches.Transact" namedFactNums="true" countMeasureName="%COUNT" bucketSize="8" bitmapChunkInMemory="false" precompute="0" disableListingGroups="false" enableSqlRestrict="false">
</cube>
}

Parameter DOMAIN;

}
