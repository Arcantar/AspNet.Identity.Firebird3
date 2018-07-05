<?xml version="1.0" encoding="utf-8"?>
<Project DefaultTargets="Build" xmlns="http://schemas.microsoft.com/developer/msbuild/2003" ToolsVersion="4.0">
  <PropertyGroup>
    <ProductVersion>3.5</ProductVersion>
    <RootNamespace>AspNet.Identity.Firebird3</RootNamespace>
    <ProjectGuid>{b8d97c31-5470-43d6-87d8-1ffc9a7fc578}</ProjectGuid>
    <OutputType>Library</OutputType>
    <AssemblyName>AspNet.Identity.Firebird3</AssemblyName>
    <AllowGlobals>False</AllowGlobals>
    <AllowLegacyWith>False</AllowLegacyWith>
    <AllowLegacyOutParams>False</AllowLegacyOutParams>
    <AllowLegacyCreate>False</AllowLegacyCreate>
    <AllowUnsafeCode>False</AllowUnsafeCode>
    <Configuration Condition="'$(Configuration)' == ''">Release</Configuration>
    <TargetFrameworkVersion>v4.6</TargetFrameworkVersion>
    <Name>AspNet.Identity.Firebird3</Name>
    <DefaultUses />
    <StartupClass />
    <InternalAssemblyName />
    <ApplicationIcon />
    <TargetFrameworkProfile />
  </PropertyGroup>
  <PropertyGroup Condition=" '$(Configuration)' == 'Debug' ">
    <OutputPath>bin\Debug\</OutputPath>
    <DefineConstants>
    </DefineConstants>
    <GeneratePDB>True</GeneratePDB>
    <GenerateMDB>True</GenerateMDB>
    <CaptureConsoleOutput>False</CaptureConsoleOutput>
    <StartMode>Project</StartMode>
    <CpuType>anycpu</CpuType>
    <RuntimeVersion>v25</RuntimeVersion>
    <XmlDoc>False</XmlDoc>
    <XmlDocWarningLevel>WarningOnPublicMembers</XmlDocWarningLevel>
    <EnableUnmanagedDebugging>False</EnableUnmanagedDebugging>
    <WarnOnCaseMismatch>False</WarnOnCaseMismatch>
  </PropertyGroup>
  <PropertyGroup Condition=" '$(Configuration)' == 'Release' ">
    <Optimize>true</Optimize>
    <OutputPath>.\bin\Release</OutputPath>
    <GeneratePDB>False</GeneratePDB>
    <GenerateMDB>False</GenerateMDB>
    <EnableAsserts>False</EnableAsserts>
    <TreatWarningsAsErrors>False</TreatWarningsAsErrors>
    <CaptureConsoleOutput>False</CaptureConsoleOutput>
    <StartMode>Project</StartMode>
    <RegisterForComInterop>False</RegisterForComInterop>
    <CpuType>anycpu</CpuType>
    <RuntimeVersion>v25</RuntimeVersion>
    <XmlDoc>False</XmlDoc>
    <XmlDocWarningLevel>WarningOnPublicMembers</XmlDocWarningLevel>
    <EnableUnmanagedDebugging>False</EnableUnmanagedDebugging>
    <WarnOnCaseMismatch>False</WarnOnCaseMismatch>
  </PropertyGroup>
  <ItemGroup>
    <Reference Include="FirebirdSql.Data.FirebirdClient">
      <HintPath>..\..\tory\FirebirdSql.Data.FirebirdClient\bin\Debug\net452\FirebirdSql.Data.FirebirdClient.dll</HintPath>
    </Reference>
    <Reference Include="mscorlib" />
    <Reference Include="Microsoft.AspNet.Identity.Core">
      <HintPath>..\..\WebFormTest1\packages\Microsoft.AspNet.Identity.Core.2.1.0\lib\net45\Microsoft.AspNet.Identity.Core.dll</HintPath>
    </Reference>
    <Reference Include="Microsoft.AspNet.Identity.Owin">
      <HintPath>..\..\WebFormTest1\packages\Microsoft.AspNet.Identity.Owin.2.1.0\lib\net45\Microsoft.AspNet.Identity.Owin.dll</HintPath>
    </Reference>
    <Reference Include="Newtonsoft.Json">
      <HintPath>..\..\WebFormTest1\packages\Newtonsoft.Json.6.0.3\lib\netcore45\Newtonsoft.Json.dll</HintPath>
    </Reference>
    <Reference Include="System" />
    <Reference Include="System.ComponentModel.DataAnnotations" />
    <Reference Include="System.Configuration" />
    <Reference Include="System.Data" />
    <Reference Include="System.Drawing" />
    <Reference Include="System.Windows.Forms" />
    <Reference Include="System.Xml" />
    <Reference Include="System.Core">
      <RequiredTargetFramework>3.5</RequiredTargetFramework>
    </Reference>
    <Reference Include="System.Xml.Linq">
      <RequiredTargetFramework>3.5</RequiredTargetFramework>
    </Reference>
    <Reference Include="System.Data.DataSetExtensions">
      <RequiredTargetFramework>3.5</RequiredTargetFramework>
    </Reference>
  </ItemGroup>
  <ItemGroup>
    <Compile Include="FBDatabase.pas" />
    <Compile Include="FBSqlHelper.pas" />
    <Compile Include="IdentityRole.pas" />
    <Compile Include="IdentityUser.pas" />
    <Compile Include="IUserStore.pas" />
    <Compile Include="Properties\AssemblyInfo.pas" />
    <Compile Include="RoleStore.pas" />
    <Compile Include="RoleTable.pas" />
    <Compile Include="UserClaimsTable.pas" />
    <Compile Include="UserLoginsTable.pas" />
    <Compile Include="UserRoleTable.pas" />
    <Compile Include="UserStore.pas" />
    <Compile Include="UserTable.pas" />
    <EmbeddedResource Include="Properties\Resources.resx">
      <Generator>ResXFileCodeGenerator</Generator>
    </EmbeddedResource>
    <Compile Include="Properties\Resources.Designer.pas" />
    <None Include="Properties\Settings.settings">
      <Generator>SettingsSingleFileGenerator</Generator>
    </None>
    <Compile Include="Properties\Settings.Designer.pas" />
  </ItemGroup>
  <ItemGroup>
    <Folder Include="Properties\" />
  </ItemGroup>
  <ItemGroup>
    <Content Include="app.config">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Firebird3.sql">
      <SubType>Content</SubType>
    </Content>
    <Content Include="packages.config">
      <SubType>Content</SubType>
    </Content>
  </ItemGroup>
  <Import Project="$(MSBuildExtensionsPath)\RemObjects Software\Elements\RemObjects.Elements.Echoes.targets" />
  <PropertyGroup>
    <PreBuildEvent />
  </PropertyGroup>
</Project>