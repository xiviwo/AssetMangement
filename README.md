# Assets Management

This system is designed to house assets of computer and track the lifecycle of assets.

##Basic Model

**User** - is class to map user logged into this system, field : name; email; administrator; timestamp. 

**Employee** - stand for employee involved in the system, who will use this asset.

**Department** -  denote this asset belongs to which department.

**Person** - base model for **User** and **Employee**, both will inherit **Person**   model.

**Assignment** -  core model to track who will use what asset during period of time.

**Result** -  to export report regarding asset usage.

**Equipment** -  record properties of asset, such as serial number, made in, made at, status, etc 

**Contact** -  provide contact information for employee or department who use this asset.

**Configuration** -  record specific configuration information relative this assets.

**Category** -  provide more detailed information how equipment categorize into .

##Specs
Powered by Ruby and Rails

##Notes
Old project, not guarantee to work under current Ruby and Rails environments,  migration under way.

