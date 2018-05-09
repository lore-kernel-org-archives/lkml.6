Return-Path: <elliott@hpe.com>
X-Google-Smtp-Source: AB8JxZrjCpAIXKFN4IM8FBK+O1+o+JiulQq4N2QwaX5hHqauf/MmXNRGTH+amJmwtD5ti4qZyNaM
ARC-Seal: i=1; a=rsa-sha256; t=1525881332; cv=none;
        d=google.com; s=arc-20160816;
        b=MFmVik2Dk2f8gkz6ael6S7K9hk339YUKXXViFXP1s+yeN5YJAe3KUwah4ws0NMHH3N
         zihP47UqCxv0ZJd7+2L1JeDv4Y5bzld0jC4IdGoFasv7Bat21wD0u87LQYJ4rkN66ls3
         R2wrmMi72ODRkwt602Yj5CFP4ymBqTr6PZarnxBgCNIXZwO6pkOzi650iPVleQc5VxN8
         76celIMypRhXNBwAEQYze5VjfppjxJoyTFqtDp8azJ6Ua9ugIkwd5LMnvHt+MKrAa/XA
         rYQEckkTL8zp1R2StWA1fafY2PzvyWCsRDfgNne+0NcCoH2QbqeEoztay760KBVro/Oz
         TzyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:arc-authentication-results;
        bh=cIgy/cE2reAjOw5HF9Dgo+Kb8IGVLPnDRWKCsKpcNEc=;
        b=p4De1q2hkEouYBcEswlCHzH6BtEJUIdesztxM9jH6/fHodHnco9ZeuMgZCL7dO8x9q
         T0eIL0TVtIw5fYf9uJFxqPNheXloA9MlP/OW6zNVHWr+66gdLla0qDEw+7WtgJxA6aV8
         dzoeeF66NIRZXo7bE3mrCaBqABE+p77AdyrFLQjhagz7FGZH/2vAnKKsLw/wgk/zUmU2
         kTEDyJplSR5E0WVyxbhCvTQ4hAAB5oq/ZvCndgbjHZnjij+3hT0GZPLpQ8j4hPVdnP7B
         0exRnE6t3oRqwmgeta8RiZ50/4Bshq/G7BKyuYNEgkN/1XvjiF4UnTtQiRuT9FvsmXle
         /nzw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of elliott@hpe.com designates 15.233.44.26 as permitted sender) smtp.mailfrom=elliott@hpe.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of elliott@hpe.com designates 15.233.44.26 as permitted sender) smtp.mailfrom=elliott@hpe.com
From: "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
To: Aishwarya Pant <aishpant@gmail.com>, Dan Williams
	<dan.j.williams@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Len
 Brown" <lenb@kernel.org>, "linux-nvdimm@lists.01.org"
	<linux-nvdimm@lists.01.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Greg KH
	<gregkh@linuxfoundation.org>
CC: Julia Lawall <julia.lawall@lip6.fr>
Subject: RE: [PATCH v2] acpi: nfit: document sysfs interface
Thread-Topic: [PATCH v2] acpi: nfit: document sysfs interface
Thread-Index: AQHTrKWMEm54VYSfZkK2YKx2iNdV1KQn8pbA
Date: Wed, 9 May 2018 15:54:55 +0000
Message-ID: <AT5PR8401MB116920E461A2489D1DA52CB6AB990@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <20180223125448.GA16909@mordor.localdomain>
In-Reply-To: <20180223125448.GA16909@mordor.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=elliott@hpe.com;
x-originating-ip: [15.211.195.7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0627;7:DNIVX7aTrIYANHKyaCb6Skzxlq4rXy1C1mB+DBUNjwb3NP63ZOXPMx38WMqC+mN/Lti6j/DXvvQ78JmMHXx7qdrUtIdQMypyhajVs61KIxG3XK6BAJblaAlg5M2dMy0nry/C8fZu/0rtWN9tvWavpzVvxPs/304ZVZBkAm5NQ2DChSc861nVHl43KnAzMwDHr+GNt6M7KTBUigFNwhcgx9wdAEcpyHOtRsWeGSNTbM8RwSqkAX/NSy+degnbkSOM
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0627;
x-ms-traffictypediagnostic: AT5PR8401MB0627:
x-microsoft-antispam-prvs: <AT5PR8401MB0627215000AC8CF862E4F60AAB990@AT5PR8401MB0627.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(166708455590820)(9452136761055)(85827821059158)(162533806227266)(176295241369792)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:AT5PR8401MB0627;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0627;
x-forefront-prvs: 0667289FF8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(376002)(39380400002)(366004)(40224003)(20264003)(50944005)(13464003)(189003)(199004)(106356001)(81166006)(2501003)(5250100002)(8676002)(81156014)(14454004)(7416002)(6436002)(8936002)(305945005)(33656002)(105586002)(3660700001)(3280700002)(446003)(229853002)(74316002)(486006)(476003)(68736007)(66066001)(11346002)(53546011)(966005)(6506007)(110136005)(5660300001)(102836004)(2201001)(7696005)(76176011)(478600001)(53366004)(4326008)(97736004)(53376002)(59450400001)(39060400002)(186003)(2906002)(316002)(26005)(6306002)(6246003)(25786009)(86362001)(55016002)(53936002)(575784001)(9686003)(3846002)(7736002)(6116002)(99286004)(2900100001);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0627;H:AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: yA1zoUTWVXI5zOrAZkiA780Ei3eJfayP7iBgJI91t7V0q4v10uN3PUozy/4aWA/vdQNH2ltYhPA+0FqRTTs3T74V0ZBOI9Vg8T5aL9lNx3eWvxrs4UD7+sJkGIethcsRFduea03AI4hiqiEOMnHRX0wu/ac6BUWuS1q7eXHPvGS0vmBr0tX/J+CG//+dyJ6u
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 7419905a-8528-4105-09c8-08d5b5c5358a
X-MS-Exchange-CrossTenant-Network-Message-Id: 7419905a-8528-4105-09c8-08d5b5c5358a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2018 15:54:55.3136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0627
X-OriginatorOrg: hpe.com
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593196408980037383?=
X-GMAIL-MSGID: =?utf-8?q?1600002544040016008?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: Linux-nvdimm [mailto:linux-nvdimm-bounces@lists.01.org] On Behalf O=
f
> Aishwarya Pant
> Sent: Friday, February 23, 2018 6:55 AM
> To: Dan Williams <dan.j.williams@intel.com>; Rafael J. Wysocki
> <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>; linux-
> nvdimm@lists.01.org; linux-acpi@vger.kernel.org; linux-
> kernel@vger.kernel.org; Jonathan Corbet <corbet@lwn.net>; Greg KH
> <gregkh@linuxfoundation.org>
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> Subject: [PATCH v2] acpi: nfit: document sysfs interface
>=20
> This is an attempt to document the nfit sysfs interface. The
> descriptions have been collected from git commit logs and the ACPI
> specification 6.2.
>=20
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
> ---
> Changes in v2:
> - Add descriptions for range_index and ecc_unit_size
> - Edit various descriptions as suggested
>=20
>  Documentation/ABI/testing/sysfs-bus-nfit | 233
> +++++++++++++++++++++++++++++++
>  1 file changed, 233 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-nfit
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-nfit
> b/Documentation/ABI/testing/sysfs-bus-nfit
> new file mode 100644
> index 000000000000..619eb8ca0f99
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-nfit
> @@ -0,0 +1,233 @@
> +For all of the nmem device attributes under nfit/*, see the 'NVDIMM
> Firmware
> +Interface Table (NFIT)' section in the ACPI specification
> +(http://www.uefi.org/specifications) for more details.
> +
> +What:		/sys/bus/nd/devices/nmemX/nfit/serial
> +Date:		Jun, 2015
> +KernelVersion:	v4.2
> +Contact:	linux-nvdimm@lists.01.org
> +Description:
> +		(RO) Serial number of the NVDIMM (non-volatile dual in-line
> +		memory module), assigned by the module vendor.

The endianness should be indicated.=20

After some churn, I think it is always presented as big-endian now
(originally printed using the CPU's native endianness).

> +
> +What:		/sys/bus/nd/devices/nmemX/nfit/handle
> +Date:		Apr, 2015
> +KernelVersion:	v4.2
> +Contact:	linux-nvdimm@lists.01.org
> +Description:
> +		(RO) The address (given by the _ADR object) of the device on
> its
> +		parent bus of the NVDIMM device containing the NVDIMM region.
> +
> +
> +What:		/sys/bus/nd/devices/nmemX/nfit/device
> +Date:		Apr, 2015
> +KernelVersion:	v4.1
> +Contact:	linux-nvdimm@lists.01.org
> +Description:
> +		(RO) Device id for the NVDIMM, assigned by the module vendor.

Since "device" is confusing (a problem with the ACPI field name), this shou=
ld=20
state that it is the "Identifier for the NVDIMM", i.e., the module itself,
not some device on the module.

> +
> +What:		/sys/bus/nd/devices/nmemX/nfit/rev_id
> +Date:		Jun, 2015
> +KernelVersion:	v4.2
> +Contact:	linux-nvdimm@lists.01.org
> +Description:
> +		(RO) Revision of the NVDIMM, assigned by the module vendor.
> +
> +
> +What:		/sys/bus/nd/devices/nmemX/nfit/phys_id
> +Date:		Apr, 2015
> +KernelVersion:	v4.2
> +Contact:	linux-nvdimm@lists.01.org
> +Description:
> +		(RO) Handle (i.e., instance number) for the SMBIOS (system
> +		management BIOS) Memory Device structure describing the NVDIMM
> +		containing the NVDIMM region.

Perhaps mention "dmidecode" as a tool to see the SMBIOS structures?

> +
> +What:		/sys/bus/nd/devices/nmemX/nfit/flags
> +Date:		Jun, 2015
> +KernelVersion:	v4.2
> +Contact:	linux-nvdimm@lists.01.org
> +Description:
> +		(RO) The flags in the NFIT memory device sub-structure
> indicate
> +		the state of the data on the nvdimm relative to its energy
> +		source or last "flush to persistence".

Capitalize nvdimm.

The bits in this field are more varied than that description, though,
and you can't predict what future standards will toss into this field.
A more generic description might be better.

> +
> +		The attribute is a translation of the 'NVDIMM State Flags'
> field
> +		in section 5.2.25.3 'NVDIMM Region Mapping' Structure of the
> +		ACPI specification 6.2.
> +
> +		The health states are "save_fail", "restore_fail", "flush_fail",
> +		"not_armed", "smart_event", "map_fail" and "smart_notify".
> +
> +
> +What:		/sys/bus/nd/devices/nmemX/nfit/format
> +What:		/sys/bus/nd/devices/nmemX/nfit/format1
> +What:		/sys/bus/nd/devices/nmemX/nfit/formats
> +Date:		Apr, 2016
> +KernelVersion:	v4.7
> +Contact:	linux-nvdimm@lists.01.org
> +Description:
> +		(RO) The interface codes indicate support for persistent
> memory
> +		mapped directly into system physical address space and / or a
> +		block aperture access mechanism to the NVDIMM media.
> +		The 'formats' attribute displays the number of supported
> +		interfaces.
> +
> +		This layout is compatible with existing libndctl binaries that
> +		only expect one code per-dimm as they will ignore
> +		nmemX/nfit/formats and nmemX/nfit/formatN.
> +
> +
> +What:		/sys/bus/nd/devices/nmemX/nfit/vendor
> +Date:		Apr, 2016
> +KernelVersion:	v4.7
> +Contact:	linux-nvdimm@lists.01.org
> +Description:
> +		(RO) Vendor id of the NVDIMM.

Clarify that this is a JEDEC manufacturer ID code from JEP106, not an ident=
ifier
assigned by the PCI SIG, IEEE, or other organization.

Clarify that it uses the two-byte format defined in JESD21C Page 4.1.2 (the=
 SPD
standard), and that it includes the parity bit.

Suggestion:
"Identifier indicating the vendor of the NVDIMM. This is a JEDEC manufactur=
er
ID code assigned in JEP106 and expressed in the two-byte format defined in
JESD21C for Serial Presence Data (SPD)."


> +
> +
> +What:		/sys/bus/nd/devices/nmemX/nfit/dsm_mask
> +Date:		May, 2016
> +KernelVersion:	v4.7
> +Contact:	linux-nvdimm@lists.01.org
> +Description:
> +		(RO) The bitmask indicates the supported device specific
> control
> +		functions relative to the NVDIMM command family supported by
> the
> +		device

What is the endianness of this bitmask?

> +
> +What:		/sys/bus/nd/devices/nmemX/nfit/family
> +Date:		Apr, 2016
> +KernelVersion:	v4.7
> +Contact:	linux-nvdimm@lists.01.org
> +Description:
> +		(RO) Displays the NVDIMM family command sets. Values
> +		0, 1, 2 and 3 correspond to NVDIMM_FAMILY_INTEL,
> +		NVDIMM_FAMILY_HPE1, NVDIMM_FAMILY_HPE2 and NVDIMM_FAMILY_MSFT
> +		respectively.
> +
> +		See the specifications for these command families here:
> +		http://pmem.io/documents/NVDIMM_DSM_Interface-V1.6.pdf
> +		https://github.com/HewlettPackard/hpe-
> nvm/blob/master/Documentation/
> +		https://msdn.microsoft.com/library/windows/hardware/mt604741"
> +
> +
> +What:		/sys/bus/nd/devices/nmemX/nfit/id
> +Date:		Apr, 2016
> +KernelVersion:	v4.7
> +Contact:	linux-nvdimm@lists.01.org
> +Description:
> +		(RO) ACPI specification 6.2 section 5.2.25.9, defines an
> +		identifier for an NVDIMM, which refelects the id attribute.

reflects is spelled wrong.

As time goes by, it might be hard to find a specific old revision of
the specification, and the section numbers will probably have changed.
Refer to the section name ("NVDIMM Representation Format") and provide
other clues.

Suggestion:

An identifier for the NVDIMM using the NVDIMM Representation Format
specified by ACPI.

If the manufacturing location and manufacturing date fields are valid,
this includes the contents of SPD bytes 320 to 328:
      printf format: %02x%02x-%02x-%02x%02x-%02x%02x%02x%02x
	contents:
		JEDEC manufacturer ID byte 0 (including the parity bit)
		JEDEC manufacturer ID byte 1
		manufacturing location
		manufacturing date byte 0: year=20
		manufacturing date byte 1: week
		serial number byte 0
		serial number byte 1
		serial number byte 2
		serial number byte 3

If the manufacturing location and manufacturing date fields are not valid,
those are omitted:
      printf format: %02x%02x-%02x%02x%02x%02x
	contents:
		JEDEC manufacturer ID byte 0 (including the parity bit)
		JEDEC manufacturer ID byte 1
		serial number byte 0
		serial number byte 1
		serial number byte 2
		serial number byte 3


> +
> +What:		/sys/bus/nd/devices/nmemX/nfit/subsystem_vendor
> +Date:		Apr, 2016
> +KernelVersion:	v4.7
> +Contact:	linux-nvdimm@lists.01.org
> +Description:
> +		(RO) Sub-system vendor id of the NVDIMM non-volatile memory
> +		subsystem controller.

Use
"Vendor of the NVDIMM non-volatile memory subsystem controller. This is a
JEDEC manufacturer ID code assigned in JEP106 and expressed in the two-byte
format defined in JESD21C for Serial Presence Data (SPD)."

> +
> +What:		/sys/bus/nd/devices/nmemX/nfit/subsystem_rev_id
> +Date:		Apr, 2016
> +KernelVersion:	v4.7
> +Contact:	linux-nvdimm@lists.01.org
> +Description:
> +		(RO) Sub-system revision id of the NVDIMM non-volatile memory
> subsystem
> +		controller, assigned by the non-volatile memory subsystem
> +		controller vendor.

Use
"Revision of the NVDIMM non-volatile memory subsystem controller, ...".

> +
> +What:		/sys/bus/nd/devices/nmemX/nfit/subsystem_device
> +Date:		Apr, 2016
> +KernelVersion:	v4.7
> +Contact:	linux-nvdimm@lists.01.org
> +Description:
> +		(RO) Sub-system device id for the NVDIMM non-volatile memory
> +		subsystem controller, assigned by the non-volatile memory
> +		subsystem controller vendor.

Use
"Identifier for the NVDIMM non-volatile memory subsystem controller, ...".

The "device" and "subsystem" terms can cause confusion because they are
backwards from PCI:
    NVDIMM: the module contains the subsystem
    PCI card: the subsystem contains the device

ACPI uses "Device ID" for a module ID, adding to the confusion.

The best we can do is to overlook the poorly chosen field names and
ensure the definitions of their content is clear.


> +
> +What:		/sys/bus/nd/devices/ndbusX/nfit/revision
> +Date:		Jun, 2015
> +KernelVersion:	v4.2
> +Contact:	linux-nvdimm@lists.01.org
> +Description:
> +		(RO) ACPI NFIT table revision number.
> +
> +
> +What:		/sys/bus/nd/devices/ndbusX/nfit/scrub
> +Date:		Sep, 2016
> +KernelVersion:	v4.9
> +Contact:	linux-nvdimm@lists.01.org
> +Description:
> +		(RW) This shows the number of full Address Range Scrubs (ARS)
> +		that have been completed since driver load time. Userspace can
> +		wait on this using select/poll etc. A '+' at the end indicates
> +		an ARS is in progress
> +
> +		Writing a value of 1 triggers an ARS scan.
> +
> +
> +What:		/sys/bus/nd/devices/ndbusX/nfit/hw_error_scrub
> +Date:		Sep, 2016
> +KernelVersion:	v4.9
> +Contact:	linux-nvdimm@lists.01.org
> +Description:
> +		(RW) Provides a way to toggle the behavior between just adding
> +		the address (cache line) where the MCE happened to the poison
> +		list and doing a full scrub. The former (selective insertion
> of
> +		the address) is done unconditionally.
> +
> +		This attribute can have the following values written to it:
> +
> +		'0': Switch to the default mode where an exception will only
> +		insert the address of the memory error into the poison and
> +		badblocks lists.
> +		'1': Enable a full scrub to happen if an exception for a
> memory
> +		error is received.
> +
> +
> +What:		/sys/bus/nd/devices/ndbusX/nfit/dsm_mask
> +Date:		Jun, 2017
> +KernelVersion:	v4.13
> +Contact:	linux-nvdimm@lists.01.org
> +Description:
> +		(RO) The bitmask indicates the supported bus specific control
> +		functions. See the section named 'NVDIMM Root Device _DSMs' in
> +		the ACPI specification.

What is the endianness of this bitmask?

> +
> +What:		/sys/bus/nd/devices/regionX/nfit/range_index
> +Date:		Jun, 2015
> +KernelVersion:	v4.2
> +Contact:	linux-nvdimm@lists.01.org
> +Description:
> +		(RO) A unique number provided by the BIOS to identify an
> address
> +		range. Used by NVDIMM Region Mapping Structure to uniquely
> refer
> +		to this structure. Value of 0 is reserved and not used as an
> +		index.
> +
> +
> +What:		/sys/bus/nd/devices/regionX/nfit/ecc_unit_size
> +Date:		Aug, 2017
> +KernelVersion:	v4.14
> +Contact:	linux-nvdimm@lists.01.org
> +Description:
> +		(RO) Size of a write request to a DIMM that will not incur a
> +		read-modify-write cycle at the memory controller.
> +
> +		When the nfit driver initializes it runs an ARS (Address Range
> +		Scrub) operation across every pmem range. Part of that process
> +		involves determining the ARS capabilities of a given address
> +		range. One of the capabilities that is reported is the 'Clear
> +		Uncorrectable Error Range Length Unit Size' (see: ACPI 6.2
> +		section 9.20.7.4 Function Index 1 - Query ARS Capabilities).
> +		This property indicates the boundary at which the NVDIMM may
> +		need to perform read-modify-write cycles to maintain ECC
> (Error
> +		Correcting Code) blocks.
> --
> 2.16.2
>=20
> _______________________________________________
> Linux-nvdimm mailing list
> Linux-nvdimm@lists.01.org
> https://lists.01.org/mailman/listinfo/linux-nvdimm
