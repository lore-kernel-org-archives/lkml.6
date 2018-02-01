Return-Path: <JOLLYS@xilinx.com>
X-Google-Smtp-Source: AH8x226AgPIa5FdM8G0tPwbzlNTIgOOshNKYVY9hCtOiCBgSOW4nSvZNSCm1wCiOBIxFfBK0m1N6
ARC-Seal: i=1; a=rsa-sha256; t=1517529250; cv=none;
        d=google.com; s=arc-20160816;
        b=R4Ef8xSMZ6pgLuqc03ggUf06TnyZNB/UdKas8RYKETbnqJk4ss9da2ghdb9c/q2rJo
         M1PqW3BtfHdAkEH3pPaUjwTWaWB2r+FS55O5HYBQj/6se91uZ4N2aHqNnbDaeqDTlGal
         LzTgXaBuurNMAbai0RBmmIU08q7HWkJJ5+G9P7NRGx1kFqAwzD/faCJtDNedZRikWZTN
         S4IbbkSmj++99ukco3VpfX1m8dgcGfZWeqE7qmbfS6MsG1GTG9pvnyFqJtLnFqEUxlgI
         itRiayH7sFeiC1uftgrcxZL5gMcvNH9d2QpgyV0I+SvK37qvcgw7aB6Op/uhI/9rJDc3
         pqpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=LuwjUKXDqbjs6RLgf92NM1Kf4fFw1YzvyY5eekELUk0=;
        b=JTHUnmPxNUHQx4f4Y7mKGR2YXqjyJ7AsD03tiqU2YQFyTumMDBdsMaQ13ZnSLIdzNK
         kSB5QIyvU598PKiddDfHGXx8R8eEL8tOXs4qIftvJJ/JTuq3r7OZGpZdvAYC0b7yAruR
         boOa9br1GRiaQHqRmKKhIVTeGTrr8aE0i1bokJB0qMb27SlOAMFUfAS1i1tWnW8qzULx
         vnJiFZbz3Io/UzmH8GwKZr0khMezlgEVGu2sycpUkHeoZxjxNF/JeIyKK6fi7Yj1gz0k
         Q7FSutF6p9NjT8i37FctTdEjKcEkJmpUmJL4N3ikKro3o6cdaZKlGDEci3Agj5Mn9yjY
         YpiA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=1a4l7g8y;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.33.57 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=1a4l7g8y;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.33.57 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
From: Jolly Shah <JOLLYS@xilinx.com>
To: Mark Rutland <mark.rutland@arm.com>
CC: "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
	"mingo@kernel.org" <mingo@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "matt@codeblueprint.co.uk"
	<matt@codeblueprint.co.uk>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>, "keescook@chromium.org"
	<keescook@chromium.org>, "dmitry.torokhov@gmail.com"
	<dmitry.torokhov@gmail.com>, "michal.simek@xilinx.com"
	<michal.simek@xilinx.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Rajan Vaja <RAJANV@xilinx.com>
Subject: RE: [PATCH v3 2/4] drivers: firmware: xilinx: Add ZynqMP firmware
 driver
Thread-Topic: [PATCH v3 2/4] drivers: firmware: xilinx: Add ZynqMP firmware
 driver
Thread-Index: AQHTlWou2XFDSgiaBEabjrwcvuQZWKOOVW8AgABxHPCAAJ7JgIAA3v1w
Date: Thu, 1 Feb 2018 23:54:05 +0000
Message-ID: <DM2PR0201MB076775551226A17AC914DD6EB8FA0@DM2PR0201MB0767.namprd02.prod.outlook.com>
References: <1516836074-4149-1-git-send-email-jollys@xilinx.com>
 <1516836074-4149-3-git-send-email-jollys@xilinx.com>
 <20180131182012.oshjmvahetaizlbu@lakrids.cambridge.arm.com>
 <CY1PR0201MB0764D88D409A35B8379323B4B8FA0@CY1PR0201MB0764.namprd02.prod.outlook.com>
 <20180201103321.fftn37mgzbk6oltl@lakrids.cambridge.arm.com>
In-Reply-To: <20180201103321.fftn37mgzbk6oltl@lakrids.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-originating-ip: [149.199.62.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM2PR0201MB1040;7:t65Ckh3ZwT29XjlbqzCPU4RmYRLGoziVViKJjI9tPKkm8lqesZVZzxKLwb3QfnlykWfRq1RUy7Kty5VFTpSBdiZLR7hSA/O9d03Q6F8xDndeCi1fE7RdMVk9zUferMVP+QG/RZSMBQ6Q90is639Wlw4QRkoqRRaaTWnSgJkGWEKwInp2DjILHNethc8mG6yqvdzyltJRqHVuVYxbsf2MDFmBHDURqOZCGNjswQfG921F3lg/iOCI33Hz/47Iz9TX
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(346002)(396003)(366004)(376002)(51914003)(189003)(199004)(37524003)(13464003)(9686003)(6916009)(81166006)(3280700002)(6306002)(99286004)(316002)(97736004)(7736002)(5250100002)(8936002)(54906003)(6436002)(105586002)(68736007)(93886005)(2906002)(229853002)(186003)(8676002)(107886003)(74316002)(106356001)(14454004)(7696005)(76176011)(26005)(478600001)(25786009)(4326008)(72206003)(6506007)(39060400002)(53546011)(66066001)(53936002)(81156014)(59450400001)(3846002)(7416002)(5660300001)(33656002)(2950100002)(305945005)(86362001)(6116002)(3660700001)(966005)(102836004)(6246003)(2900100001)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR0201MB1040;H:DM2PR0201MB0767.namprd02.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: afc314d4-eb76-4ae7-7f23-08d569cf13cb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:DM2PR0201MB1040;
x-ms-traffictypediagnostic: DM2PR0201MB1040:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com;
x-microsoft-antispam-prvs: <DM2PR0201MB104047EB2FD2C5D205E2A532B8FA0@DM2PR0201MB1040.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(258649278758335)(192813158149592);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM2PR0201MB1040;BCL:0;PCL:0;RULEID:;SRVR:DM2PR0201MB1040;
x-forefront-prvs: 0570F1F193
x-microsoft-antispam-message-info: STXs+CWN4ErCbMIGUnkh0kSOtRcCu3dhIwTY+D957I/1AWJBD9arLlXGjkKJzwfsJPmSOL4vyRv/yczEwJArbQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afc314d4-eb76-4ae7-7f23-08d569cf13cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2018 23:54:05.2480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0201MB1040
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590517939735530008?=
X-GMAIL-MSGID: =?utf-8?q?1591244750876892381?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Mark,

> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland@arm.com]
> Sent: Thursday, February 01, 2018 2:33 AM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: ard.biesheuvel@linaro.org; mingo@kernel.org;
> gregkh@linuxfoundation.org; matt@codeblueprint.co.uk;
> sudeep.holla@arm.com; hkallweit1@gmail.com; keescook@chromium.org;
> dmitry.torokhov@gmail.com; michal.simek@xilinx.com; robh+dt@kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; Rajan Vaja <RAJANV@xilinx.com>
> Subject: Re: [PATCH v3 2/4] drivers: firmware: xilinx: Add ZynqMP firmwar=
e
> driver
>=20
> On Thu, Feb 01, 2018 at 01:23:48AM +0000, Jolly Shah wrote:
> > Hi Mark,
> > Thanks for the review,
> >
> > > -----Original Message-----
> > > From: Mark Rutland [mailto:mark.rutland@arm.com]
> > > Sent: Wednesday, January 31, 2018 10:20 AM
> > > To: Jolly Shah <JOLLYS@xilinx.com>
> > > Cc: ard.biesheuvel@linaro.org; mingo@kernel.org;
> > > gregkh@linuxfoundation.org; matt@codeblueprint.co.uk;
> > > sudeep.holla@arm.com; hkallweit1@gmail.com; keescook@chromium.org;
> > > dmitry.torokhov@gmail.com; michal.simek@xilinx.com;
> > > robh+dt@kernel.org; linux-arm-kernel@lists.infradead.org;
> > > linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; Jolly Shah
> > > <JOLLYS@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>
> > > Subject: Re: [PATCH v3 2/4] drivers: firmware: xilinx: Add ZynqMP
> > > firmware driver
> > >
> > > On Wed, Jan 24, 2018 at 03:21:12PM -0800, Jolly Shah wrote:
> > > > This patch is adding communication layer with firmware.
> > > > Firmware driver provides an interface to firmware APIs.
> > > > Interface APIs can be used by any driver to communicate to
> > > > PMUFW(Platform Management Unit). All requests go through ATF.
> > >
> > > > +/**
> > > > + * zynqmp_pm_set_wakeup_source - PM call to specify the wakeup
> source
> > > > + *					while suspended
> > > > + * @target:	Node ID of the targeted PU or subsystem
> > > > + * @wakeup_node:Node ID of the wakeup peripheral
> > > > + * @enable:	Enable or disable the specified peripheral as wake
> source
> > > > + *
> > > > + * Return:	Returns status, either success or error+reason
> > > > + */
> > > > +static int zynqmp_pm_set_wakeup_source(const u32 target,
> > > > +				       const u32 wakeup_node,
> > > > +				       const u32 enable)
> > > > +{
> > > > +	return invoke_pm_fn(PM_SET_WAKEUP_SOURCE, target,
> > > > +			    wakeup_node, enable, 0, NULL); }
> > >
> > > I see many functions take a "Node ID" parameter, but these don't
> > > appear to be in any DT binding, and drivers (other than the debugfs d=
river)
> aren't using them.
> > >
> > > What's the plan for making use of these? Where are the node IDs
> > > going to come from in practice?
> > >
> > Node ids are defined in firmware.h. Node id refers to targeted
> PU/subsystem/peripheral for required action.
>=20
> Ok. What I was asking was how a node id would be associated with particul=
ar
> peripheral instances (which are presumably going to be nodes in the DT).
>=20
> e.g. if I have
>=20
> 	device@foo {
> 		compatible =3D "xlnx,some-device";
> 		reg =3D <0xf00 0x100>;
> 		...
> 	};
>=20
> ... how does the kernel know which node id(s) the device is associated wi=
th?
>=20
> I assume that those will need something like a xlnx,eemi-node-id property=
.
>=20
> [...]
>=20

ZynqMP Power domain driver has node-ids defines under pd-id properties.(RFC=
 patch below)
https://patchwork.kernel.org/patch/10150683/

Individual driver can have phandle to it.
For example,
power-domains {
                pd_xx: pd_xx {
                        #power-domain-cells =3D <0x0>;
                        pd-id =3D <0x7>;
                };
                pd_yy: pd_yy {
                        #power-domain-cells =3D <0x0>;
                        pd-id =3D <0xf>;
                };
        };

device: dev@ffe00000 {
		compatible =3D "dev";
		reg =3D <0x0 0xFFE00000 0x0 0x20000>;
		pd-handle =3D <&pd_xx>;
};


> > > > +/**
> > > > + * zynqmp_pm_pinctrl_request - Request Pin from firmware
> > > > + * @pin:	Pin number to request
> > > > + *
> > >
> > > No DT binding for the pinctrl bits?
> > >
> > > [...]
> > It doesn't require any bindings. Calling drivers will have DT binding f=
or pins they
> use.
>=20
> For those drivers to be able to refer to the EEMI FW as a pin controller,=
 we'll
> need a pinctrl node in the DT (and hence a binding).
>=20

This is just an interface driver. There is a separate pinctrl and clock dri=
ver who will use these APIs to communicate with PMU(Platform Management Uni=
t). Those driver has required DT nodes and bindings to use these APIs.
For example, Clock driver bindings are mentioned below:
https://patchwork.kernel.org/patch/10150703/


> > > > +/**
> > > > + * zynqmp_pm_clock_enable - Enable the clock for given id
> > > > + * @clock_id:	ID of the clock to be enabled
> > > > + *
> > >
> > > Likewise for the clocks?
> > >
> > It doesn't require bindings too.
>=20
> As with pinctrl, for drivers to be able to refer to these clocks, we'll n=
eed a clock
> node in the DT (and hence a binding).
>=20
> Thanks,
> Mark.
