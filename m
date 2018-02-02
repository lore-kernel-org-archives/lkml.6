Return-Path: <JOLLYS@xilinx.com>
X-Google-Smtp-Source: AH8x225AuAejPnJ6tD1CAitEIjlFGpld9++N0IZCCkDJQBUooilscfgP4DkJBh44Th1ODgiSFygj
ARC-Seal: i=1; a=rsa-sha256; t=1517601010; cv=none;
        d=google.com; s=arc-20160816;
        b=wyn+HddWPTd2TKcOnvhigNymeEWsTv75HK6coq9FUIHNIzTqJQV+qrlmjkohdYHOrq
         0YBcwX+NbR0kDgjPpKGSJrRP+NjglpHIYlV5n2n8G8eBJyJu0e/SVjL63cwNyVrDBvba
         fL5SuBvSkAw0wDKoRv2SmqBkVsSThKBQ0kmKcSfSKlf2JRpH3tK1DX34vJJQ132volYH
         sK3RCpU97Aa5aMRjrsoxaonnpFBiPAp9hZEeYC5cmiXZh1uSG/GA2ArLWqevPr1Ql+QR
         xQkwKJEvF2XwS5wOB7HLX/IuoonECil1iBB5RqxhXSxFGJajWbfAUSRL5H9FPh86xrJY
         a2TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=ktKwlsxUU640nqG6GUPrQD3Ct3dcpmi0iBd3szFsUwM=;
        b=hbqK+cvpPW5eH5JQbXoeMlSQjDAFjHHlcLasvdA4iyYAMP4lsS6mea4UX8qKR9qEok
         rWci9l5PpcVa+2dzDavdsNrwxHtToPjtIAYGqShdCGRrKblOaiCp62t1ZfxYJCVexsfD
         ZhzNgwaX/5buFX70qop+Cg2bu47phT1mRZr1TMGZm0biDbtkytCaTeNGYRzMC7yNrc5C
         g9xAsQgupMpNV5K9NpUJHMIWK5eN7zCREeR8pg5nUG8Me5vCfquyoBYVUZ+hqULTKJ7Z
         g1QsXfeEsutuTwtY5ARsKAORIb714hbf2rGHtngRI+nODmssXQ1aHKXqNmmYoZXUeqyv
         NZSg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=BroRnu29;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.40.67 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=BroRnu29;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.40.67 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
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
Thread-Index: AQHTlWomdmmvreQR6kiWwxGfbK0z8aOOUOEAgAB0v5CAAJ4SAIACLkEw
Date: Fri, 2 Feb 2018 19:50:05 +0000
Message-ID: <DM2PR0201MB0767C06A1B7A47DB79723C96B8F90@DM2PR0201MB0767.namprd02.prod.outlook.com>
References: <1516836074-4149-1-git-send-email-jollys@xilinx.com>
 <1516836074-4149-2-git-send-email-jollys@xilinx.com>
 <20180131180354.mqf4gvvprdtycbn5@lakrids.cambridge.arm.com>
 <CY1PR0201MB076454E915A6E6947A39F04BB8FA0@CY1PR0201MB0764.namprd02.prod.outlook.com>
 <20180201102730.33q4xrjw3vhrgk4i@lakrids.cambridge.arm.com>
In-Reply-To: <20180201102730.33q4xrjw3vhrgk4i@lakrids.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com;
x-originating-ip: [149.199.62.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM2PR0201MB0829;7:ogHCf5/LkgyzAapXkCnGugPWTTq/dTsY2G+UAnOomLwnDZBAlYllD4Lm0LQy+CeGBHcojg/AHSWO8SFXIcbYnxq9LpUAf4OBybZ333VeYtCixHCJAt4OOCVGnqhFhQMieMgfVUe+l0wl4GlW+l8MJd0UXJBwZya9t8Re+DnkQtX6LcM9yAuPBI7zECvrHX/GBAMxZq4qSK02kgPEC+6sLmqWyK8JzD/PgN1QZUGSUqkBoXo6MHkYuttDH8Z0bT/z
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(39380400002)(366004)(376002)(396003)(51914003)(189003)(199004)(13464003)(305945005)(74316002)(229853002)(8676002)(6916009)(2950100002)(99286004)(33656002)(5660300001)(54906003)(93886005)(186003)(7416002)(7736002)(3660700001)(3280700002)(53936002)(316002)(105586002)(6436002)(81166006)(81156014)(8936002)(72206003)(2900100001)(68736007)(478600001)(39060400002)(4326008)(106356001)(9686003)(97736004)(6306002)(2906002)(66066001)(966005)(107886003)(6116002)(3846002)(55016002)(7696005)(14454004)(6506007)(26005)(5250100002)(6246003)(25786009)(86362001)(76176011)(102836004)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR0201MB0829;H:DM2PR0201MB0767.namprd02.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ad8748d2-e615-4142-175f-08d56a76288c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:DM2PR0201MB0829;
x-ms-traffictypediagnostic: DM2PR0201MB0829:
x-microsoft-antispam-prvs: <DM2PR0201MB082987A4B459FCBE1F56FC86B8F90@DM2PR0201MB0829.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(258649278758335)(192813158149592)(189271028609987);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231101)(2400082)(944501161)(3002001)(10201501046)(6055026)(6041288)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM2PR0201MB0829;BCL:0;PCL:0;RULEID:;SRVR:DM2PR0201MB0829;
x-forefront-prvs: 05715BE7FD
x-microsoft-antispam-message-info: ltYKGI8sPxtvEFGeKk4l0RpTqTphwjEoPTl5UX+8ldpnQZF7vONzraDuPqpDLPNOy9mi3VhCOlgMwjr+2Gt7qQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8748d2-e615-4142-175f-08d56a76288c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2018 19:50:05.9873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0201MB0829
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590517943929452186?=
X-GMAIL-MSGID: =?utf-8?q?1591319997350719803?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Mark,

> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland@arm.com]
> Sent: Thursday, February 01, 2018 2:28 AM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: ard.biesheuvel@linaro.org; mingo@kernel.org;
> gregkh@linuxfoundation.org; matt@codeblueprint.co.uk;
> sudeep.holla@arm.com; hkallweit1@gmail.com; keescook@chromium.org;
> dmitry.torokhov@gmail.com; michal.simek@xilinx.com; robh+dt@kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; Rajan Vaja <RAJANV@xilinx.com>
> Subject: Re: [PATCH v3 1/4] dt-bindings: firmware: Add bindings for ZynqM=
P
> firmware
>=20
> On Thu, Feb 01, 2018 at 01:04:45AM +0000, Jolly Shah wrote:
> > > > +Xilinx Zynq MPSoC Firmware Device Tree Bindings
> > > > +
> > > > +The zynqmp-firmware node describes the interface to platform firmw=
are.
> > >
> > > Is there any documentation for this that can be referred to?
> > >
> >
> > Will add more information about supported APIs in next version patch.
> > Below document describes interface APIs though it is not latest.
> > https://www.xilinx.com/support/documentation/user_guides/ug1200-eemi-a
> > pi.pdf
>=20
> Thanks for the link.
>=20
> It might be better for the compatible string to be "xlnx,zynqmp-eemi", to=
 make it
> clear which firmware interfaces are being described, assuming that this b=
eing is
> only intended to cover EEMI.
>=20
> Thanks,
> Mark.

It is interface to firmware be it ATF/PMU. EEMI is part of it.=20

Thanks,
Jolly Shah
