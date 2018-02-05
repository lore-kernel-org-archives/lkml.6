Return-Path: <Alexandre.Bounine@idt.com>
X-Google-Smtp-Source: AH8x224iYQEqBe4YHBYw/Sn38MJXI8Curj4Y1luh7e2suN0MtmnmZk2oYUDqTIpUaluoS00Zpdj0
ARC-Seal: i=1; a=rsa-sha256; t=1517854780; cv=none;
        d=google.com; s=arc-20160816;
        b=AOSeRDKVVfqgngaJe1nrzmlZQG6VPzZ+9hTWmsdhL2DzUvcagBf0m1pmyd8rC6qUVO
         jZW9HUm4XgfY5ej43erX4K1ApSR5AEkHtUjgDO1+DKoS+G0sy3sD1KIaJ8GlE6DuDCtx
         mvt4IC51gYCmk3Q+YA5uuBAzuUTVHjq5RRbIUGia1e97qmSNZpX2Z3kD/9SwbPiu0gt6
         JglBoXUdzfui7RUyUGxfcKQg0YCjN6hBMAzkeTHysstDRSTdKqefO+IYVbx+up/nmnMX
         NoRbI6Lx7ZqGF/YTJVQqNrNP9P7XP/be6OVJc3vmGT8tJEu637GUinGxmqWsyOt1HD06
         XQpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=Fg5PNwr7ReIUlI4ULGoP4qOq7nwh0eyPZ+euhLbgFIs=;
        b=QQgOc6iRSnLsfAy2uysYcqJajkrolEAXqgSWDy+tSQJwSaBeNEZiMcODD13+eYJc9t
         P7AH6tJqrpvQUvF5ADpDXtzpuefIEMHbVuiC2MW4sORY1OtUpn0F5giHfTtRrW9w5Dda
         tdRu62gNGv5UNuEDk07Z6Q8TVzLp8fOHwNWcURhuTu+PlqVwZ4xOTOKsVN754lT7wUuC
         NK4i0SDvLMMHwiL5qxPzveBOcGLxs3c8IuKWtIHnB5Nf+OCEG5c/u4t2URfCRrNTd8/U
         p8nn1+34ZZFQ0GctaYYXjtlZLY40t3UkVjzAYthv0RT3HgmDz/sUe4U4YwQIFbttx3+o
         9OOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alexandre.bounine@idt.com designates 157.165.5.26 as permitted sender) smtp.mailfrom=Alexandre.Bounine@idt.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alexandre.bounine@idt.com designates 157.165.5.26 as permitted sender) smtp.mailfrom=Alexandre.Bounine@idt.com
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: Aishwarya Pant <aishpant@gmail.com>,
        Matt Porter
	<mporter@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg KH
	<gregkh@linuxfoundation.org>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Julia Lawall <julia.lawall@lip6.fr>
Subject: RE: [PATCH v2] Documentation: rapidio: move sysfs interface to ABI
Thread-Topic: [PATCH v2] Documentation: rapidio: move sysfs interface to ABI
Thread-Index: AQHTkSF/crguIcEBvUqV6eBisw+Qm6OWOV3g
Date: Mon, 5 Feb 2018 18:19:32 +0000
Message-ID: <8D983423E7EDF846BB3056827B8CC5D161B46CE5@corpmail1>
References: <20180119123147.GA17446@mordor.localdomain>
In-Reply-To: <20180119123147.GA17446@mordor.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [157.165.140.50]
x-tm-as-matchedid: 150567-701625-704425-700685-700949-139010-139006-701960-7
	03523-700486-700648-106660-704410-184142-704568-704195-703005-701421-702791
	-700038-121618-704885-705178-704421-704156-702836-860275-700079-700016-7035
	29-188019-700324-708712-702131-704473-186217-711608-701253-712264-701698-70
	2037-700019-702005-702042-700555-700398-707788-709908-706561-701096-708797-
	701674-701944-701594-709275-700133-700887-705508-701305-703267-707654-70217
	1-702829-700756-707410-139504-700007-860493-186035-700023-706150-701143-700
	264-701465-701618-700918-703440-711664-704351-701005-703731-700782-709323-7
	05441-708060-148004-148133-20043-24831-42000-42003
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-TM-AS-MML: disable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590024066368713946?=
X-GMAIL-MSGID: =?utf-8?q?1591586094070128062?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Sorry for the delay.

Acked-by: Alexandre Bounine <alexandre.bounine@idt.com>

> -----Original Message-----
> From: Aishwarya Pant [mailto:aishpant@gmail.com]
> Sent: Friday, January 19, 2018 7:32 AM
> To: Matt Porter <mporter@kernel.crashing.org>; Bounine, Alexandre
> <Alexandre.Bounine@idt.com>; Jonathan Corbet <corbet@lwn.net>; Greg
> KH <gregkh@linuxfoundation.org>; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> Subject: [PATCH v2] Documentation: rapidio: move sysfs interface to ABI
>=20
> Right now, the description of the rapidio sysfs interfaces is in
> Documentation/rapidio/sysfs.txt. Since these are a part of the ABI, they
> should be in Documentation/ABI along with the rest.
>=20
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
> ---
> Movement of sysfs interface is not absolutely necessary but this format
> adds some metadata (like kernel version, added date) which might be
> useful in scripting and tracking changes.
>=20
> Changes in v2:
> -Fix typo typr -> typo
> -Add context around enumerating devices' destid
> -Add destid attribute to list of common attributes
> -Edit description of binary attribute config
> -Add a line in Documentation/rapidio/sysfs.txt about movement of the
>  sysfs ABI
>=20
>  Documentation/ABI/testing/sysfs-bus-rapidio   | 198
> ++++++++++++++++++++++++++
>  Documentation/ABI/testing/sysfs-class-rapidio |  55 +++++++
>  Documentation/rapidio/sysfs.txt               | 161 +-------------------=
-
>  3 files changed, 256 insertions(+), 158 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-rapidio
>  create mode 100644 Documentation/ABI/testing/sysfs-class-rapidio
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-rapidio
> b/Documentation/ABI/testing/sysfs-bus-rapidio
> new file mode 100644
> index 000000000000..13208b27dd87
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-rapidio
> @@ -0,0 +1,198 @@
> +What:		/sys/bus/rapidio/devices/nn:d:iiii
> +Description:
> +		For each RapidIO device, the RapidIO subsystem creates files
> in
> +		an individual subdirectory with the following name format of
> +		device_name "nn:d:iiii", where:
> +
> +		nn   - two-digit hexadecimal ID of RapidIO network where the
> +		       device resides
> +		d    - device type: 'e' - for endpoint or 's' - for switch
> +		iiii - four-digit device destID for endpoints, or switchID for
> +		       switches
> +
> +		For example, below is a list of device directories that
> +		represents a typical RapidIO network with one switch, one
> host,
> +		and two agent endpoints, as it is seen by the enumerating
> host
> +		(with destID =3D 1):
> +
> +		/sys/bus/rapidio/devices/00:e:0000
> +		/sys/bus/rapidio/devices/00:e:0002
> +		/sys/bus/rapidio/devices/00:s:0001
> +
> +		NOTE: An enumerating or discovering endpoint does not
> create a
> +		sysfs entry for itself, this is why an endpoint with destID=3D1 is
> +		not shown in the list.
> +
> +Attributes Common for All RapidIO Devices
> +-----------------------------------------
> +
> +What:		/sys/bus/rapidio/devices/nn:d:iiii/did
> +Date:		Nov, 2005
> +KernelVersion:	v2.6.15
> +Contact:	Matt Porter <mporter@kernel.crashing.org>,
> +		Alexandre Bounine <alexandre.bounine@idt.com>
> +Description:
> +		(RO) returns the device identifier
> +
> +What:		/sys/bus/rapidio/devices/nn:d:iiii/vid
> +Date:		Nov, 2005
> +KernelVersion:	v2.6.15
> +Contact:	Matt Porter <mporter@kernel.crashing.org>,
> +		Alexandre Bounine <alexandre.bounine@idt.com>
> +Description:
> +		(RO) returns the device vendor identifier
> +
> +What:		/sys/bus/rapidio/devices/nn:d:iiii/device_rev
> +Date:		Nov, 2005
> +KernelVersion:	v2.6.15
> +Contact:	Matt Porter <mporter@kernel.crashing.org>,
> +		Alexandre Bounine <alexandre.bounine@idt.com>
> +Description:
> +		(RO) returns the device revision level
> +
> +What:		/sys/bus/rapidio/devices/nn:d:iiii/asm_did
> +Date:		Nov, 2005
> +KernelVersion:	v2.6.15
> +Contact:	Matt Porter <mporter@kernel.crashing.org>,
> +		Alexandre Bounine <alexandre.bounine@idt.com>
> +Description:
> +		(RO) returns identifier for the assembly containing the device
> +
> +What:		/sys/bus/rapidio/devices/nn:d:iiii/asm_rev
> +Date:		Nov, 2005
> +KernelVersion:	v2.6.15
> +Contact:	Matt Porter <mporter@kernel.crashing.org>,
> +		Alexandre Bounine <alexandre.bounine@idt.com>
> +Description:
> +		(RO) returns revision level of the assembly containing the
> +		device
> +
> +What:		/sys/bus/rapidio/devices/nn:d:iiii/asm_vid
> +Date:		Nov, 2005
> +KernelVersion:	v2.6.15
> +Contact:	Matt Porter <mporter@kernel.crashing.org>,
> +		Alexandre Bounine <alexandre.bounine@idt.com>
> +Description:
> +		(RO) returns vendor identifier of the assembly containing the
> +		device
> +
> +What:		/sys/bus/rapidio/devices/nn:d:iiii/destid
> +Date:		Mar, 2011
> +KernelVersion:	v2.6.3
> +Contact:	Matt Porter <mporter@kernel.crashing.org>,
> +		Alexandre Bounine <alexandre.bounine@idt.com>
> +Description:
> +		(RO) returns device destination ID assigned by the
> enumeration
> +		routine
> +
> +What:		/sys/bus/rapidio/devices/nn:d:iiii/lprev
> +Date:		Mar, 2011
> +KernelVersion:	v2.6.39
> +Contact:	Matt Porter <mporter@kernel.crashing.org>,
> +		Alexandre Bounine <alexandre.bounine@idt.com>
> +Description:
> +		(RO) returns name of previous device (switch) on the path to
> the
> +		device that that owns this attribute
> +
> +What:		/sys/bus/rapidio/devices/nn:d:iiii/modalias
> +Date:		Jul, 2013
> +KernelVersion:	v3.11
> +Contact:	Matt Porter <mporter@kernel.crashing.org>,
> +		Alexandre Bounine <alexandre.bounine@idt.com>
> +Description:
> +		(RO) returns the device modalias
> +
> +What:		/sys/bus/rapidio/devices/nn:d:iiii/config
> +Date:		Nov, 2005
> +KernelVersion:	v2.6.15
> +Contact:	Matt Porter <mporter@kernel.crashing.org>,
> +		Alexandre Bounine <alexandre.bounine@idt.com>
> +Description:
> +		(RW) Binary attribute to read from and write to the device
> +		configuration registers using the RapidIO maintenance
> +		transactions. This attribute is similar in behaviour to the
> +		"config" attribute of PCI devices and provides an access to
> the
> +		RapidIO device registers using standard file read and write
> +		operations.
> +
> +RapidIO Switch Device Attributes
> +--------------------------------
> +
> +RapidIO switches have additional attributes in sysfs. RapidIO subsystem
> supports
> +common and device-specific sysfs attributes for switches. Because switch=
es
> are
> +integrated into the RapidIO subsystem, it offers a method to create
> +device-specific sysfs attributes by specifying a callback function that =
may be
> +set by the switch initialization routine during enumeration or discovery
> +process.
> +
> +What:		/sys/bus/rapidio/devices/nn:s:iiii/routes
> +Date:		Nov, 2005
> +KernelVersion:	v2.6.15
> +Contact:	Matt Porter <mporter@kernel.crashing.org>,
> +		Alexandre Bounine <alexandre.bounine@idt.com>
> +Description:
> +		(RO) reports switch routing information in "destID port"
> format.
> +		This attribute reports only valid routing table entries, one
> +		line for each entry.
> +
> +What:		/sys/bus/rapidio/devices/nn:s:iiii/destid
> +Date:		Mar, 2011
> +KernelVersion:	v2.6.3
> +Contact:	Matt Porter <mporter@kernel.crashing.org>,
> +		Alexandre Bounine <alexandre.bounine@idt.com>
> +Description:
> +		(RO) device destination ID of the associated device that
> defines
> +		a route to the switch
> +
> +What:		/sys/bus/rapidio/devices/nn:s:iiii/hopcount
> +Date:		Mar, 2011
> +KernelVersion:	v2.6.39
> +Contact:	Matt Porter <mporter@kernel.crashing.org>,
> +		Alexandre Bounine <alexandre.bounine@idt.com>
> +Description:
> +		(RO) number of hops on the path to the switch
> +
> +What:		/sys/bus/rapidio/devices/nn:s:iiii/lnext
> +Date:		Mar, 2011
> +KernelVersion:	v2.6.39
> +Contact:	Matt Porter <mporter@kernel.crashing.org>,
> +		Alexandre Bounine <alexandre.bounine@idt.com>
> +Description:
> +		(RO) returns names of devices linked to the switch except
> one of
> +		a device linked to the ingress port (reported as "lprev"). This
> +		is an array names with number of lines equal to number of
> ports
> +		in switch. If a switch port has no attached device, returns
> +		"null" instead of a device name.
> +
> +Device-specific Switch Attributes
> +---------------------------------
> +
> +IDT_GEN2-
> +
> +What:		/sys/bus/rapidio/devices/nn:s:iiii/errlog
> +Date:		Oct, 2010
> +KernelVersion:	v2.6.37
> +Contact:	Matt Porter <mporter@kernel.crashing.org>,
> +		Alexandre Bounine <alexandre.bounine@idt.com>
> +Description:
> +		(RO) reads contents of device error log until it is empty.
> +
> +RapidIO Bus Attributes
> +----------------------
> +
> +What:		/sys/bus/rapidio/scan
> +Date:		May, 2013
> +KernelVersion:	v3.11
> +Contact:	Matt Porter <mporter@kernel.crashing.org>,
> +		Alexandre Bounine <alexandre.bounine@idt.com>
> +Description:
> +		(WO) Allows to trigger enumeration discovery process from
> user
> +		space. To initiate an enumeration or discovery process on
> +		specific mport device, a user needs to write mport_ID (not
> +		RapidIO destination ID) into this file. The mport_ID is a
> +		sequential number (0 ...  RIO_MAX_MPORTS) assigned to the
> mport
> +		device. For example, for a machine with a single RapidIO
> +		controller, mport_ID for that controller always will be 0. To
> +		initiate RapidIO enumeration/discovery on all available
> mports a
> +		user must write '-1' (or RIO_MPORT_ANY) into this attribute
> +		file.
> diff --git a/Documentation/ABI/testing/sysfs-class-rapidio
> b/Documentation/ABI/testing/sysfs-class-rapidio
> new file mode 100644
> index 000000000000..8716beeb16c1
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-rapidio
> @@ -0,0 +1,55 @@
> +What:		/sys/class/rapidio_port
> +Description:
> +		On-chip RapidIO controllers and PCIe-to-RapidIO bridges
> +		(referenced as "Master Port" or "mport") are presented in
> sysfs
> +		as the special class of devices: "rapidio_port".
> +		The /sys/class/rapidio_port subdirectory contains individual
> +		subdirectories named as "rapidioN" where N =3D mport ID
> registered
> +		with RapidIO subsystem.
> +		NOTE: An mport ID is not a RapidIO destination ID assigned to
> a
> +		given local mport device.
> +
> +What:		/sys/class/rapidio_port/rapidioN/sys_size
> +Date:		Apr, 2014
> +KernelVersion:	v3.15
> +Contact:	Matt Porter <mporter@kernel.crashing.org>,
> +		Alexandre Bounine <alexandre.bounine@idt.com>
> +Description:
> +		(RO) reports RapidIO common transport system size:
> +		0 =3D small (8-bit destination ID, max. 256 devices),
> +		1 =3D large (16-bit destination ID, max. 65536 devices).
> +
> +What:		/sys/class/rapidio_port/rapidioN/port_destid
> +Date:		Apr, 2014
> +KernelVersion:	v3.15
> +Contact:	Matt Porter <mporter@kernel.crashing.org>,
> +		Alexandre Bounine <alexandre.bounine@idt.com>
> +Description:
> +		(RO) reports RapidIO destination ID assigned to the given
> +		RapidIO mport device. If value 0xFFFFFFFF is returned this
> means
> +		that no valid destination ID have been assigned to the mport
> +		(yet). Normally, before enumeration/discovery have been
> executed
> +		only fabric enumerating mports have a valid destination ID
> +		assigned to them using "hdid=3D..." rapidio module parameter.
> +
> +After enumeration or discovery was performed for a given mport device,
> +the corresponding subdirectory will also contain subdirectories for each
> +child RapidIO device connected to the mport.
> +
> +The example below shows mport device subdirectory with several child
> RapidIO
> +devices attached to it.
> +
> +[rio@rapidio ~]$ ls /sys/class/rapidio_port/rapidio0/ -l
> +total 0
> +drwxr-xr-x 3 root root    0 Feb 11 15:10 00:e:0001
> +drwxr-xr-x 3 root root    0 Feb 11 15:10 00:e:0004
> +drwxr-xr-x 3 root root    0 Feb 11 15:10 00:e:0007
> +drwxr-xr-x 3 root root    0 Feb 11 15:10 00:s:0002
> +drwxr-xr-x 3 root root    0 Feb 11 15:10 00:s:0003
> +drwxr-xr-x 3 root root    0 Feb 11 15:10 00:s:0005
> +lrwxrwxrwx 1 root root    0 Feb 11 15:11 device -> ../../../0000:01:00.0
> +-r--r--r-- 1 root root 4096 Feb 11 15:11 port_destid
> +drwxr-xr-x 2 root root    0 Feb 11 15:11 power
> +lrwxrwxrwx 1 root root    0 Feb 11 15:04 subsystem ->
> ../../../../../../class/rapidio_port
> +-r--r--r-- 1 root root 4096 Feb 11 15:11 sys_size
> +-rw-r--r-- 1 root root 4096 Feb 11 15:04 uevent
> diff --git a/Documentation/rapidio/sysfs.txt
> b/Documentation/rapidio/sysfs.txt
> index 47ce9a5336e1..a1adac888e6e 100644
> --- a/Documentation/rapidio/sysfs.txt
> +++ b/Documentation/rapidio/sysfs.txt
> @@ -1,158 +1,3 @@
> -                         RapidIO sysfs Files
> -
> -
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ~~~~~~~~~~~~~~~~~~~~~~
> -
> -1. RapidIO Device Subdirectories
> ---------------------------------
> -
> -For each RapidIO device, the RapidIO subsystem creates files in an indiv=
idual
> -subdirectory with the following name,
> /sys/bus/rapidio/devices/<device_name>.
> -
> -The format of device_name is "nn:d:iiii", where:
> -
> -nn - two-digit hexadecimal ID of RapidIO network where the device reside=
s
> -d  - device typr: 'e' - for endpoint or 's' - for switch
> -iiii - four-digit device destID for endpoints, or switchID for switches
> -
> -For example, below is a list of device directories that represents a typ=
ical
> -RapidIO network with one switch, one host, and two agent endpoints, as i=
t
> is
> -seen by the enumerating host (destID =3D 1):
> -
> -/sys/bus/rapidio/devices/00:e:0000
> -/sys/bus/rapidio/devices/00:e:0002
> -/sys/bus/rapidio/devices/00:s:0001
> -
> -NOTE: An enumerating or discovering endpoint does not create a sysfs ent=
ry
> for
> -itself, this is why an endpoint with destID=3D1 is not shown in the list=
.
> -
> -2. Attributes Common for All RapidIO Devices
> ---------------------------------------------
> -
> -Each device subdirectory contains the following informational read-only
> files:
> -
> -       did - returns the device identifier
> -       vid - returns the device vendor identifier
> -device_rev - returns the device revision level
> -   asm_did - returns identifier for the assembly containing the device
> -   asm_rev - returns revision level of the assembly containing the devic=
e
> -   asm_vid - returns vendor identifier of the assembly containing the de=
vice
> -   destid  - returns device destination ID assigned by the enumeration
> routine
> -             (see 4.1 for switch specific details)
> -   lprev   - returns name of previous device (switch) on the path to the=
 device
> -             that that owns this attribute
> -  modalias - returns the device modalias
> -
> -In addition to the files listed above, each device has a binary attribut=
e file
> -that allows read/write access to the device configuration registers usin=
g
> -the RapidIO maintenance transactions:
> -
> - config - reads from and writes to the device configuration registers.
> -
> -This attribute is similar in behavior to the "config" attribute of PCI d=
evices
> -and provides an access to the RapidIO device registers using standard fi=
le
> read
> -and write operations.
> -
> -3. RapidIO Endpoint Device Attributes
> --------------------------------------
> -
> -Currently Linux RapidIO subsystem does not create any endpoint specific
> sysfs
> -attributes. It is possible that RapidIO master port drivers and endpoint
> device
> -drivers will add their device-specific sysfs attributes but such attribu=
tes are
> -outside the scope of this document.
> -
> -4. RapidIO Switch Device Attributes
> ------------------------------------
> -
> -RapidIO switches have additional attributes in sysfs. RapidIO subsystem
> supports
> -common and device-specific sysfs attributes for switches. Because switch=
es
> are
> -integrated into the RapidIO subsystem, it offers a method to create
> -device-specific sysfs attributes by specifying a callback function that =
may be
> -set by the switch initialization routine during enumeration or discovery
> process.
> -
> -4.1 Common Switch Attributes
> -
> -   routes - reports switch routing information in "destID port" format. =
This
> -            attribute reports only valid routing table entries, one line=
 for
> -            each entry.
> -   destid - device destination ID that defines a route to the switch
> - hopcount - number of hops on the path to the switch
> -    lnext - returns names of devices linked to the switch except one of =
a
> device
> -            linked to the ingress port (reported as "lprev"). This is an=
 array
> -            names with number of lines equal to number of ports in switc=
h. If
> -            a switch port has no attached device, returns "null" instead=
 of
> -            a device name.
> -
> -4.2 Device-specific Switch Attributes
> -
> -Device-specific switch attributes are listed for each RapidIO switch dri=
ver
> -that exports additional attributes.
> -
> -IDT_GEN2:
> - errlog - reads contents of device error log until it is empty.
> -
> -
> -5. RapidIO Bus Attributes
> --------------------------
> -
> -RapidIO bus subdirectory /sys/bus/rapidio implements the following bus-
> specific
> -attribute:
> -
> -  scan - allows to trigger enumeration discovery process from user space=
.
> This
> -	 is a write-only attribute. To initiate an enumeration or discovery
> -	 process on specific mport device, a user needs to write mport_ID
> (not
> -	 RapidIO destination ID) into this file. The mport_ID is a sequential
> -	 number (0 ... RIO_MAX_MPORTS) assigned to the mport device.
> -	 For example, for a machine with a single RapidIO controller,
> mport_ID
> -	 for that controller always will be 0.
> -	 To initiate RapidIO enumeration/discovery on all available mports
> -	 a user must write '-1' (or RIO_MPORT_ANY) into this attribute file.
> -
> -
> -6. RapidIO Bus Controllers/Ports
> ---------------------------------
> -
> -On-chip RapidIO controllers and PCIe-to-RapidIO bridges (referenced as
> -"Master Port" or "mport") are presented in sysfs as the special class of
> -devices: "rapidio_port".
> -
> -The /sys/class/rapidio_port subdirectory contains individual subdirector=
ies
> -named as "rapidioN" where N =3D mport ID registered with RapidIO
> subsystem.
> -
> -NOTE: An mport ID is not a RapidIO destination ID assigned to a given lo=
cal
> -mport device.
> -
> -Each mport device subdirectory in addition to standard entries contains =
the
> -following device-specific attributes:
> -
> -   port_destid - reports RapidIO destination ID assigned to the given Ra=
pidIO
> -                 mport device. If value 0xFFFFFFFF is returned this mean=
s that
> -                 no valid destination ID have been assigned to the mport=
 (yet).
> -                 Normally, before enumeration/discovery have been execut=
ed only
> -                 fabric enumerating mports have a valid destination ID a=
ssigned
> -                 to them using "hdid=3D..." rapidio module parameter.
> -      sys_size - reports RapidIO common transport system size:
> -                   0 =3D small (8-bit destination ID, max. 256 devices),
> -                   1 =3D large (16-bit destination ID, max. 65536 device=
s).
> -
> -After enumeration or discovery was performed for a given mport device,
> -the corresponding subdirectory will also contain subdirectories for each
> -child RapidIO device connected to the mport. Naming conventions for
> RapidIO
> -devices are described in Section 1 above.
> -
> -The example below shows mport device subdirectory with several child
> RapidIO
> -devices attached to it.
> -
> -[rio@rapidio ~]$ ls /sys/class/rapidio_port/rapidio0/ -l
> -total 0
> -drwxr-xr-x 3 root root    0 Feb 11 15:10 00:e:0001
> -drwxr-xr-x 3 root root    0 Feb 11 15:10 00:e:0004
> -drwxr-xr-x 3 root root    0 Feb 11 15:10 00:e:0007
> -drwxr-xr-x 3 root root    0 Feb 11 15:10 00:s:0002
> -drwxr-xr-x 3 root root    0 Feb 11 15:10 00:s:0003
> -drwxr-xr-x 3 root root    0 Feb 11 15:10 00:s:0005
> -lrwxrwxrwx 1 root root    0 Feb 11 15:11 device -> ../../../0000:01:00.0
> --r--r--r-- 1 root root 4096 Feb 11 15:11 port_destid
> -drwxr-xr-x 2 root root    0 Feb 11 15:11 power
> -lrwxrwxrwx 1 root root    0 Feb 11 15:04 subsystem ->
> ../../../../../../class/rapidio_port
> --r--r--r-- 1 root root 4096 Feb 11 15:11 sys_size
> --rw-r--r-- 1 root root 4096 Feb 11 15:04 uevent
> +The RapidIO sysfs files have moved to:
> +Documentation/ABI/testing/sysfs-bus-rapidio and
> +Documentation/ABI/testing/sysfs-class-rapidio
> --
> 2.16.0
