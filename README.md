# Admin-Execute:

</br>

![Compiler](https://github.com/user-attachments/assets/a916143d-3f1b-4e1f-b1e0-1067ef9e0401) ![10 Seattle](https://github.com/user-attachments/assets/c70b7f21-688a-4239-87c9-9a03a8ff25ab) ![10 1 Berlin](https://github.com/user-attachments/assets/bdcd48fc-9f09-4830-b82e-d38c20492362) ![10 2 Tokyo](https://github.com/user-attachments/assets/5bdb9f86-7f44-4f7e-aed2-dd08de170bd5) ![10 3 Rio](https://github.com/user-attachments/assets/e7d09817-54b6-4d71-a373-22ee179cd49c)  ![10 4 Sydney](https://github.com/user-attachments/assets/e75342ca-1e24-4a7e-8fe3-ce22f307d881) ![11 Alexandria](https://github.com/user-attachments/assets/64f150d0-286a-4edd-acab-9f77f92d68ad) ![12 Athens](https://github.com/user-attachments/assets/59700807-6abf-4e6d-9439-5dc70fc0ceca)  
![Components](https://github.com/user-attachments/assets/d6a7a7a4-f10e-4df1-9c4f-b4a1a8db7f0e) ![None](https://github.com/user-attachments/assets/30ebe930-c928-4aaf-a8e1-5f68ec1ff349)  
![Discription](https://github.com/user-attachments/assets/4a778202-1072-463a-bfa3-842226e300af) ![Admin Execute](https://github.com/user-attachments/assets/893c9b19-6069-4a3e-bcf0-96067a3cab9e)  
![Last Update](https://github.com/user-attachments/assets/e1d05f21-2a01-4ecf-94f3-b7bdff4d44dd) ![122025](https://github.com/user-attachments/assets/2123510b-f411-4624-a2fc-695ffb3c4b70)  
![License](https://github.com/user-attachments/assets/ff71a38b-8813-4a79-8774-09a2f3893b48) ![Freeware](https://github.com/user-attachments/assets/1fea2bbf-b296-4152-badd-e1cdae115c43)  

</br>

"Run as Administrator" in computing (like on Windows) means launching an application with elevated system privileges, allowing it to perform tasks normally restricted to system administrators, such as changing system settings, installing software, or accessing protected files, often triggered by a User Account Control (UAC) prompt, while on Wikipedia, "administrator" refers to experienced editors with special tools (delete, block, protect pages) elected by the community, not technical system admins. The term bridges two concepts: granting elevated rights to software (Windows) and granting advanced editorial powers.

</br>

![admin$](https://github.com/user-attachments/assets/7e4aa6b9-dfa1-441c-94bd-f88d4e9dae54)

</br>

When programs are written that need to access sensitive areas of Windows, the user requires the necessary permissions. These include the registry, system settings, network, firewall, etc. However, if the user is restricted and lacks these permissions, the programs will fail and error messages such as the following will appear:

</br>

![admin privilegs required](https://github.com/user-attachments/assets/2aa2f7be-eb4c-4079-8abc-4276854fee40)

</br>

This problem can be circumvented by granting the program the necessary permissions upon execution. Afterward, the user's access rights are irrelevant; the program has full access to all Windows system functions, regardless of how restricted the user account is.

Windows even identifies such programs by displaying an additional icon in the form of a shield that looks something like this..

</br>

![AdminExe](https://github.com/user-attachments/assets/4518d72a-48c6-4307-accb-b1295e279669)

</br>

# How can I build such programs?
Here is a guide for building programs that run with full rights.

### Step 1:
* Create a new folder and save an empty project in this folder.

### Step 2:
* Copy ```brcc32.exe``` from your Delphi folder into your project.
* The file is generally located in the "```..\bin\..```" folder of Borland or Embarcadero.
* If the file isn't there, you'll need to find it, as it's required.

### Step 3:
* Next, create a new resource file named ```admin.rc```.
* Copy the following line into this file and save it.
```pascal
1 24 "admin.manifest"
```

### Step 4:
* Now create a new file named ```admin.manifest```, and copy the following code into it.

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<assembly xmlns="urn:schemas-microsoft-com:asm.v1" manifestVersion="1.0">
  <assemblyIdentity version="1.0.0.0" processorArchitecture="*" name="MyAppAssemblyNameHere" type="win32"/>
  <description>My App Description</description>
  <!-- uncomment this to enable ComCtl v6 Visual Styles...
  <dependency>
    <dependentAssembly>
      <assemblyIdentity type="win32" name="Microsoft.Windows.Common-Controls" version="6.0.0.0" processorArchitecture="*" publicKeyToken="6595b64144ccf1df" language="*"/>
    </dependentAssembly>
  </dependency>
  -->
  <trustInfo xmlns="urn:schemas-microsoft-com:asm.v2">
    <security>
      <requestedPrivileges>
        <requestedExecutionLevel level="requireAdministrator" uiAccess="false"/>
      </requestedPrivileges>
    </security>
  </trustInfo>
</assembly>
```

Save file.  
This removes the user lock and privileges the program.

### Step 5:
Now you need to drag and drop the ```admin.rc``` file onto ```brcc32.exe``` to create the ```admin.res``` resource file for Delphi.



