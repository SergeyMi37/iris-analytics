Class Riches.Installer
{

XData setup
{
<Manifest>
  <Default Name="Namespace" Value="IRISAPP"/>
  <Default Name="app" Value="irisapp" />
  <Default Name="SourceDir" Value="/opt/${app}/src"/>
  
  <Namespace Name="${Namespace}" Code="${Namespace}" Data="${Namespace}" Create="yes" Ensemble="0">
    <Configuration>
      <Database Name="${Namespace}" Dir="/opt/${app}/data" Create="yes" Resource="%DB_${Namespace}"/>
    </Configuration>
    <CSPApplication Url="/csp/${app}" Directory="${cspdir}${app}" ServeFiles="1" Recurse="1" AuthenticationMethods="32"/>
    <Import File="${SourceDir}" Flags="ck" Recurse="1"/>
  </Namespace>

  <If Condition='(##class(Security.Applications).Exists("/irisapp")=0)'>
    <Log Text="Creating web application /irisapp" Level="0"/>
    <RunInstall Class="Riches.Installer" Method="CreateWebAppIRISAPP"/>
  </If>
  <If Condition='(##class(Security.Applications).Exists("/restapi")=0)'>
    <Log Text="Creating web application /restapi" Level="0"/>
    <RunInstall Class="Riches.Installer" Method="CreateWebAppREST"/>
  </If>

  <IfDef Var="Password">
    <User Username="_SYSTEM" PasswordVar="Password" Roles="%All" Enabled="true"/>
  </IfDef>
</Manifest>
}

ClassMethod CreateWebAppIRISAPP(
	pVars,
	pLogLevel,
	tInstaller) As %Status
{
	If $IsObject($Get(tInstaller)) {
		Set Namespace = tInstaller.Evaluate("${Namespace}")
		Do tInstaller.PushNS("%SYS")
	}
	Do ##class(Security.System).GetInstallationSecuritySetting(.security)
	If (security="None") {
		Set cspProperties("AutheEnabled") = $$$AutheUnauthenticated
	} Else {
		Set cspProperties("AutheEnabled") = $$$AutheCache // Password
	}
	Set cspName = "/irisapp"
	Set cspProperties("NameSpace") = $Get(Namespace,"IRISAPP")
	Set cspProperties("Enabled") = 1
	Set cspProperties("AutheEnabled") = $$$AutheUnauthenticated + $$$AutheCache
	Set cspProperties("DeepSeeEnabled") = 1
	Set cspProperties("iKnowEnabled") = 0
	Set cspProperties("Path") = "/usr/irissys/csp/irisapp/"
	Set cspProperties("ApplicationRoles") = "%DB_IRISAPP"
        Set cspProperties("Resource") = ""
        Set cspProperties("ServeFiles") = 1
 	Set tSC = ##class(Security.Applications).Create(cspName,.cspProperties)
	Do tInstaller.PopNS()
	If $$$ISERR(tSC) Throw ##class(%Installer.Exception).CreateFromStatus(tSC)
	Quit $$$OK
}

ClassMethod CreateWebAppREST(
	pVars,
	pLogLevel,
	tInstaller) As %Status
{
  Set Namespace = tInstaller.Evaluate("${Namespace}")
  Do tInstaller.PushNS("%SYS")
  Do ##class(Security.System).GetInstallationSecuritySetting(.security)
  If (security="None") {
    Set cspProperties("AutheEnabled") = $$$AutheUnauthenticated
  } Else {
    Set cspProperties("AutheEnabled") = $$$AutheCache // Password
  }
  Set cspName = "/restapi"
  Set cspProperties("NameSpace") = $Get(Namespace,"IRISAPP")
  Set cspProperties("Enabled") = 1
  Set cspProperties("DeepSeeEnabled") = 1
  Set cspProperties("iKnowEnabled") = 0
  Set cspProperties("DispatchClass") = "Riches.REST"
  Set cspProperties("ApplicationRoles") = "%DB_IRISAPP"
  Set cspProperties("Resource") = ""
  Set cspProperties("ServeFiles") = 1
  Set tSC = ##class(Security.Applications).Create(cspName,.cspProperties)
  Do tInstaller.PopNS()
  If $$$ISERR(tSC) Throw ##class(%Installer.Exception).CreateFromStatus(tSC)
  Quit $$$OK
}

ClassMethod setup(
	ByRef pVars,
	pLogLevel As %Integer = 3,
	pInstaller As %Installer.Installer,
	pLogger As %Installer.AbstractLogger) As %Status [ CodeMode = objectgenerator, Internal ]
{
  #; Let XGL document generate code for this method. 
  Quit ##class(%Installer.Manifest).%Generate(%compiledclass, %code, "setup")
}

ClassMethod InstallRiches(
	ByRef pVars,
	pLogLevel As %String = "",
	tInstaller) As %Status
{
	Set myNamespace = $Namespace
	ZN "%SYS"
	If $Get(pLogLevel) = "" Set pLogLevel = 3
	Set pVars("Password") = "abc123"
	Set tSC = ..setup(.pVars,pLogLevel)
	If (tSC '= $$$OK) {
		Write $system.Status.GetOneErrorText(tSC),!
	}
	ZN "IRISAPP"
	Do EnableDeepSee^%SYS.cspServer("/csp/irisapp/")
	Set tSC = ##class(Riches.Util).SQLGrantAccess()
	Set tSC = ##class(Riches.Util).ImportCSV()
	Kill ^TESTunit
	ZN myNamespace
	Quit tSC
}

}
