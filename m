Return-Path: <JOLLYS@xilinx.com>
X-Google-Smtp-Source: AH8x227rGBz6Jbr5F9axOXbu48ap6/gkNuY3NseMPrBKSRBLsbnyCbluF12HjCKMY5eIhmaw8w5j
ARC-Seal: i=1; a=rsa-sha256; t=1517447090; cv=none;
        d=google.com; s=arc-20160816;
        b=EGHd1EGwBCQRF6mPMfU+1MFcmRPqgI/76gw5ZIe6+hiv+g6xhBLEvUntqZNb22MvMy
         0e63Dco4l1N0HLkTKBqYIODFIiu77O/hcyCF28YGITZpqDzm9hXGLPb3j7oISittpVg1
         GSGnx/0QZ1MbGScyMUtByDsHacvip9y6IV3a7YmZtC0cAjKdjgS+yfpOFVJXt7uDQ5ly
         EjEkpsGO0zTzLqU34u5d4HO7BsacT96eMcShK0cBz6ruJKMBEmSnXOu0aooI2OK/O51C
         HqCOqxvkg6CBCezxR2WVbogog+RpbQdZWoiFS3ej/OVHy/KT5/iDNDKgMfzTVOQqhjYE
         milg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=X5xJkEZl3WbpByjlTkHUfMaDntxHwdqvgxxxWFsb8+Y=;
        b=kZbxWftZkPXGTjbVNwM56Q47h+Npt175Dc2LEdOBoO40jNqyXgI5sa7IVfuRBuXhO4
         Fkt7fB0DCvTCk6ViZKyjwYDbhI3AQlP10Adfa7OY+8UrrwG07PaXBl1UmmhllAInxVnd
         59Cc59mPNYeUAnTHYDdgSAg0+5j5y6HGs+GU8bBwfgPi6OnIsxVIqj1wYtwHVMkggAKh
         H6ZLHz0p+gOdGBG9AD8B8DzUv5KWz/3S9y/Vo+4RSRvBv6pk8Rpz1ehIxzMJozjXbBQ0
         4UF0PTYxdoFiTsobc8WoT8WmKtLcL4Oc+4i0N3M6RWVxIsDERdX78wR6N3wMC2cY1hgY
         MQBw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=jbnodItw;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.38.63 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=jbnodItw;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.38.63 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
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
Subject: RE: [PATCH v3 1/4] dt-bindings: firmware: Add bindings for ZynqMP
 firmware
Thread-Topic: [PATCH v3 1/4] dt-bindings: firmware: Add bindings for ZynqMP
 firmware
Thread-Index: AQHTlWomdmmvreQR6kiWwxGfbK0z8aOOUOEAgAB0v5A=
Date: Thu, 1 Feb 2018 01:04:45 +0000
Message-ID: <CY1PR0201MB076454E915A6E6947A39F04BB8FA0@CY1PR0201MB0764.namprd02.prod.outlook.com>
References: <1516836074-4149-1-git-send-email-jollys@xilinx.com>
 <1516836074-4149-2-git-send-email-jollys@xilinx.com>
 <20180131180354.mqf4gvvprdtycbn5@lakrids.cambridge.arm.com>
In-Reply-To: <20180131180354.mqf4gvvprdtycbn5@lakrids.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com;
x-originating-ip: [149.199.62.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR0201MB1529;7:zj03cgMW63KUkeFrP+nBBeX2ANLWMYpA4BzKla4Z67Tiw4yefV3oZ3qQ4zoZW6RIO24l5OE1zYySQtHvSY2dkctwlyiWNubpmdwnsNmRtMrl+RmvICYcFKSef6hrl/m0hYHuU+21AxW8fT7sSvyJGWy1BVc6AnU/mvfpZAgWzoPPipfrTea1MHNto5q3w89hpPhlPeO+WVlzidYroey/dC9mTwlxmLuEtxCuj9+CIUH5nSQFY919/756NR/A1/rR
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(39380400002)(366004)(346002)(376002)(51914003)(189003)(199004)(13464003)(8676002)(81156014)(3660700001)(81166006)(478600001)(26005)(53546011)(6506007)(6436002)(102836004)(105586002)(229853002)(2900100001)(966005)(8936002)(99286004)(77096007)(86362001)(3280700002)(7416002)(97736004)(7696005)(14454004)(76176011)(72206003)(4326008)(6116002)(33656002)(9686003)(107886003)(2906002)(53936002)(25786009)(39060400002)(3846002)(6916009)(54906003)(6246003)(106356001)(55016002)(74316002)(316002)(7736002)(5660300001)(66066001)(68736007)(6306002)(305945005)(186003)(2950100002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0201MB1529;H:CY1PR0201MB0764.namprd02.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 907e81cc-55eb-42ef-6e58-08d5690fc8c1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:CY1PR0201MB1529;
x-ms-traffictypediagnostic: CY1PR0201MB1529:
x-microsoft-antispam-prvs: <CY1PR0201MB15295375762EBF96ED79E3A2B8FA0@CY1PR0201MB1529.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(258649278758335)(192813158149592)(189271028609987);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(3231101)(2400082)(944501161)(3002001)(93006095)(93001095)(6055026)(6041288)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:CY1PR0201MB1529;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0201MB1529;
x-forefront-prvs: 0570F1F193
x-microsoft-antispam-message-info: nvCtzf5YiFHXSk48+0j104SPONki01WjHUS5kbMQrVouDkF5oUB6HCwVljunBAv2fD7A0cJHL34P4Ebe60+T5A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 907e81cc-55eb-42ef-6e58-08d5690fc8c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2018 01:04:45.3214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0201MB1529
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590517943929452186?=
X-GMAIL-MSGID: =?utf-8?q?1591158600424916213?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Mark,
Thanks for the review,

> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland@arm.com]
> Sent: Wednesday, January 31, 2018 10:04 AM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: ard.biesheuvel@linaro.org; mingo@kernel.org;
> gregkh@linuxfoundation.org; matt@codeblueprint.co.uk;
> sudeep.holla@arm.com; hkallweit1@gmail.com; keescook@chromium.org;
> dmitry.torokhov@gmail.com; michal.simek@xilinx.com; robh+dt@kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; Jolly Shah <JOLLYS@xilinx.com>; Rajan Vaja
> <RAJANV@xilinx.com>
> Subject: Re: [PATCH v3 1/4] dt-bindings: firmware: Add bindings for ZynqM=
P
> firmware
>=20
> On Wed, Jan 24, 2018 at 03:21:11PM -0800, Jolly Shah wrote:
> > Add documentation to describe Xilinx ZynqMP firmware driver bindings.
> > Firmware driver provides an interface to firmware APIs. Interface APIs
> > can be used by any driver to communicate to PMUFW (Platform Management
> > Unit).
> >
> > Signed-off-by: Jolly Shah <jollys@xilinx.com>
> > Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> > ---
> >  .../bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt    | 16
> ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware
> > .txt
> >
> > diff --git
> > a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmwa
> > re.txt
> > b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmwa
> > re.txt
> > new file mode 100644
> > index 0000000..a7aaf56
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-fi
> > +++ rmware.txt
> > @@ -0,0 +1,16 @@
> > +Xilinx Zynq MPSoC Firmware Device Tree Bindings
> > +
> > +The zynqmp-firmware node describes the interface to platform firmware.
>=20
> Is there any documentation for this that can be referred to?
>

Will add more information about supported APIs in next version patch.
Below document describes interface APIs though it is not latest.  =20
https://www.xilinx.com/support/documentation/user_guides/ug1200-eemi-api.pd=
f


> > +
> > +Required properties:
> > + - compatible:	Must contain:  "xlnx,zynqmp-firmware"
> > + - method:	The method of calling the PM-API firmware layer.
> > +		Permitted values are:
> > +		 - "smc" : To be used in configurations without a hypervisor
> > +		 - "hvc" : To be used when hypervisor is present
>=20
> Please specify what exactly these mean. I assume these follow the SMCCC.
> If so, this can be:
>=20
> - method: The method of calling the PM-API firmware layer.
>           Permitted values are:
> 	  - "smc" : SMC #0, following the SMCCC
> 	  - "hvc" : HVC #0, following the SMCCC
>=20
> Otherwise, this looks ok to me.
>=20

Yes it follows SMCCC.=20

> Thanks,
> Mark.
>=20
> > +
> > +Examples:
> > +	zynqmp_firmware: zynqmp-firmware {
> > +		compatible =3D "xlnx,zynqmp-firmware";
> > +		method =3D "smc";
> > +	};
> > --
> > 2.7.4
> >
