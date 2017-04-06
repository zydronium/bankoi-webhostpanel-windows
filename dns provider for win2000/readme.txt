To install the dns provider,
1. Copy dnsschema.mof and dnsprov.dll to <winntdir>\system32\wbem.
2. Run "mofcomp dnsschema.mof" to register the class information.
2. Run "regsvr32 dnsprov.dll" to register the dll.

