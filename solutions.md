Key Security Concepts
Let's review the following key security concepts, as they are foundational to understanding the STRIDE framework:

Authenticity: This is affected when a non-genuine user poses as a legitimate user. This can be protected with proper authentication.
Integrity: This is affected when a user maliciously tampers with data or a system.
Non-repudiation: This is affected when a change is made that cannot be associated with a known legitimate action. It is the act of denying something happened.
Confidentiality: This is affected when sensitive data is exposed. Data can be exposed while in motion on the network or at rest due to lack of or poor encryption.
Availability: This is affected by system uptime. This can happen as a result of resource starvation during a denial of service attack or lack of rate-limiting on an API.
Authorization: This is affected when the access level (permission) within a system is abused or exceeded.
The STRIDE Framework
STRIDE is a mnemonic - a systematic and intentional threat analysis framework that helps you reason about what could go wrong.

"S" represents Spoofing: This is the act of posing as someone or something for malicious intent, such as disguising the identity of a system administrator. It affects authenticity.
"T" represents Tampering: This is modifying a system for malicious intent, such as modifying system files. It affects integrity.
"R" represents Repudiation: This is the act of denying doing something, such as denying the download of data from a database. It affects non-repudiation.
"I" represents Information Disclosure: This refers to disclosing private or sensitive information, such as dumping stolen credentials on Pastebin. It affects confidentiality.
"D" represents Denial of Service: This refers to affecting the availability of a system, such as overwhelming a system with too much traffic that is not rate-limited. It affects availability.
"E" represents Elevation of Privilege: This refers to escalating your privilege to affect authorization levels.
Summary Table
Threat	Desired Security Property
Spoofing	Authenticity
Tampering	Integrity
Repudiation	Non-repudiation
Information disclosure	Confidentiality
Denial of Service	Availability
Elevation of Privilege	Authorization
