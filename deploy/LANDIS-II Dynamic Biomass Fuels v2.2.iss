#define PackageName      "Dynamic Biomass Fuel System"
#define PackageNameLong  "Dynamic Biomass Fuel System"
#define Version          "2.2"
#define ReleaseType      "official"
#define ReleaseNumber    "2"

#define CoreVersion      "6.0"
#define CoreReleaseAbbr  ""

#include "package (Setup section) v6.0.iss"
#define ExtDir "C:\Program Files\LANDIS-II\v6\bin\extensions"
#define AppDir "C:\Program Files\LANDIS-II\v6"

[Files]
; Cohort and Succession Libraries
Source: ..\src\bin\debug\Landis.Library.BiomassCohorts-v2.dll; DestDir: {#ExtDir}; Flags: replacesameversion uninsneveruninstall
Source: ..\src\bin\debug\Landis.Library.AgeOnlyCohorts.dll; DestDir: {#ExtDir}; Flags: replacesameversion uninsneveruninstall
Source: ..\src\bin\debug\Landis.Library.Biomass-v1.dll; DestDir: {#ExtDir}; Flags: replacesameversion uninsneveruninstall
Source: ..\src\bin\debug\Landis.Library.Cohorts.dll; DestDir: {#ExtDir}; Flags: replacesameversion uninsneveruninstall

; Dynamic Fire Fuel System v1.0 plug-in 
Source: ..\src\bin\debug\Landis.Extension.BiomassFuels.dll; DestDir: {#ExtDir}; Flags: replacesameversion

Source: examples\ecoregions.gis; DestDir: {#AppDir}\examples\dynamic-biomass-fuels
Source: examples\initial-communities.gis; DestDir: {#AppDir}\examples\dynamic-biomass-fuels
Source: examples\*.txt; DestDir: {#AppDir}\examples\dynamic-biomass-fuels
Source: examples\*.bat; DestDir: {#AppDir}\examples\dynamic-biomass-fuels

#define DynFuelSys "Dynamic Biomass Fuels 2.2.txt"
Source: {#DynFuelSys}; DestDir: {#LandisPlugInDir}

[Run]
;; Run plug-in admin tool to add entries for each plug-in
#define PlugInAdminTool  CoreBinDir + "\Landis.PlugIns.Admin.exe"
Filename: {#PlugInAdminTool}; Parameters: "remove ""Dynamic Biomass Fuel System"" "; WorkingDir: {#LandisPlugInDir}
Filename: {#PlugInAdminTool}; Parameters: "add ""{#DynFuelSys}"" "; WorkingDir: {#LandisPlugInDir}

[UninstallRun]
;; Run plug-in admin tool to remove entries for each plug-in
; Filename: {#PlugInAdminTool}; Parameters: "remove ""Dynamic Biomass Fuel System"" "; WorkingDir: {#LandisPlugInDir}

[Code]
#include "package (Code section) v3.iss"

//-----------------------------------------------------------------------------

function CurrentVersion_PostUninstall(currentVersion: TInstalledVersion): Integer;
begin
    Result := 0;
end;

//-----------------------------------------------------------------------------

function InitializeSetup_FirstPhase(): Boolean;
begin
  CurrVers_PostUninstall := @CurrentVersion_PostUninstall
  Result := True
end;
