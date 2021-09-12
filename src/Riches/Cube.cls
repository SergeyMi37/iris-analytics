/// 
Class Riches.Cube Extends %DeepSee.CubeDefinition [ DependsOn = Riches.Transact, ProcedureBlock ]
{

/// Cube definition from Architect.
XData Cube [ XMLNamespace = "http://www.intersystems.com/deepsee" ]
{
<cube xmlns="http://www.intersystems.com/deepsee" name="iris4money" displayName="iris-for-money" disabled="false" abstract="false" sourceClass="Riches.Transact" namedFactNums="true" countMeasureName="%COUNT" bucketSize="8" bitmapChunkInMemory="false" precompute="0" disableListingGroups="false" enableSqlRestrict="false">
  <dimension name="CategoryD" disabled="false" hasAll="false" allCaption="All Nickname" allDisplayName="Nickname" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="Category" disabled="false" sourceProperty="Category.Nickname" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="4">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="MerchantD" disabled="false" hasAll="false" allCaption="All Nickname" allDisplayName="Nickname" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="Merchant" disabled="false" sourceProperty="Merchant.Nickname" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="5">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="TranDateD" disabled="false" hasAll="false" allCaption="All TranDateD" allDisplayName="TranDateD" sourceProperty="TranDate" type="time" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="Year" disabled="false" timeFunction="Year" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="2">
      </level>
      <level name="Month Year" disabled="false" timeFunction="MonthYear" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="3">
      </level>
    </hierarchy>
  </dimension>
  <measure name="AmountCredit" disabled="false" sourceProperty="AmountCredit" aggregate="SUM" type="number" hidden="false" searchable="false" factNumber="1">
  </measure>
  <measure name="AmountDebit" disabled="false" sourceProperty="AmountDebit" aggregate="SUM" type="number" hidden="false" searchable="false" factNumber="2">
  </measure>
</cube>
}

Parameter DOMAIN;

}
