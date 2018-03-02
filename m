Return-Path: <ruxandra.radulescu@nxp.com>
X-Google-Smtp-Source: AG47ELs2yZLkcOh6KN9VXDDxw2Fr6aBbM7d5z+rb4vrVPUV756Q8LHWIJI26NERqY+y6RyjPcnNG
ARC-Seal: i=1; a=rsa-sha256; t=1520009723; cv=none;
        d=google.com; s=arc-20160816;
        b=cBCch8krh7h5CcYGzmCpvu/EKXTY0/yoHSMneGHvhjJImaHJPzkJ4Ftq5tfuqOZPk+
         mkNndWR/wN07JJhA0JjSEESJGXI7wdx1MimNTUrJur+6asxbuFmu5+hztSgb05Xjro6m
         ZrQvkVoqJ/39hk2V8SdufqYuM5sNmFKl7/C3N+sRWWJTHqdiMzoMcELjY0EHdN+RoW02
         7fHkrRYHvsUHlEDbMKv55CNOrpQP6hUrIGhqN7Oo77kagP24nilnqpWOOf+tZTXc4r+x
         6cpmPaocxyHWA3IV5oGt5rlNElRzawaq3j9J/uQOaLwl+XscijYnLBr/OpmSHDkS7Epb
         LRXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=7ueKS1LVSivk4+f2XRqX0c9ZuK87U1YMG/IPh1TjjPM=;
        b=EQIljHA4U0ro76wizkjTxZfiLrvhBshYJ0rfSvzM83iF9YTsEW3jTpsGGbWrKJv7l/
         /Eo6XnNZLUegVW2KF8NdmnULTAyYoPVMtDaVbkhUNImHcfgoTyR7aKfDV1MECHpHyK1Z
         DDnS5EkVE1JR0Lpn9xt/qQe0j5TWnVtLIuT+rCc+s7KpGXlByq2akE9vtXOmovirlDSJ
         7akn9mlHjlAb+Q4QCB+BRFXt7psppr5sIgi3KAjaFk88avrxwsK3rQwHhS1b1hKC8cN3
         wbrTvb8KmQDMdCmvQ2bMNxyr6fs8DuPuXtWAVWkgZ9iPiKv/I8Hbdk0jTDkz/DmQWk8b
         nspQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=CahJLB9m;
       spf=pass (google.com: domain of ruxandra.radulescu@nxp.com designates 40.107.0.85 as permitted sender) smtp.mailfrom=ruxandra.radulescu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=CahJLB9m;
       spf=pass (google.com: domain of ruxandra.radulescu@nxp.com designates 40.107.0.85 as permitted sender) smtp.mailfrom=ruxandra.radulescu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Ruxandra Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, Roy Pledge
	<roy.pledge@nxp.com>, Bogdan Purcareata <bogdan.purcareata@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Laurentiu
 Tudor <laurentiu.tudor@nxp.com>
Subject: RE: [PATCH 4/4] staging: fsl-dpaa2/eth: allow the driver to compile
 multi-arch
Thread-Topic: [PATCH 4/4] staging: fsl-dpaa2/eth: allow the driver to compile
 multi-arch
Thread-Index: AQHTrx7XedFN7IpNUkidtTwKr4312KO7l10AgAGYKVA=
Date: Fri, 2 Mar 2018 16:55:19 +0000
Message-ID: <HE1PR0402MB2700E628AEAF92158041F96694C50@HE1PR0402MB2700.eurprd04.prod.outlook.com>
References: <20180226162807.20649-1-ruxandra.radulescu@nxp.com>
 <20180226162807.20649-5-ruxandra.radulescu@nxp.com>
 <20180301163152.GA2675@kroah.com>
In-Reply-To: <20180301163152.GA2675@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0402MB3499;7:0kBQO58AoD7lv6LOpd1hAlZyyK6iofQclCDEhZxTUMUq5OtJnpcMHwW8WjxvQAaXZHS3pjNzp5tntuWsmkTr7ss3WNZQLE87HDifC2QJGoo5pNaNnwFhW4WX3e/6Zar7iejAf6wj3dLMU160hUw96kDPONHfT0DjJikgTR0paHLk+AIkyKxdeeRS7xqhRx13gtOfD6/9SAloNJGoySL+X6aj5MbjWTmDGD77EVFPLZIn1g0hG0JwL8UyEVKYcoAA
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(39380400002)(396003)(39860400002)(346002)(366004)(13464003)(189003)(199004)(2906002)(66066001)(4326008)(3846002)(55016002)(9686003)(6116002)(2900100001)(6916009)(229853002)(2950100002)(86362001)(5250100002)(33656002)(3660700001)(25786009)(6246003)(68736007)(14454004)(7696005)(99286004)(74316002)(102836004)(7736002)(53546011)(6506007)(53936002)(305945005)(478600001)(5660300001)(8936002)(81166006)(81156014)(105586002)(316002)(8676002)(186003)(26005)(54906003)(3280700002)(6436002)(97736004)(76176011)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0402MB3499;H:HE1PR0402MB2700.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 42983eb1-4827-405e-ac60-08d5805e615d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:HE1PR0402MB3499;
x-ms-traffictypediagnostic: HE1PR0402MB3499:
x-microsoft-antispam-prvs: <HE1PR0402MB3499F88F111D35FC8A7DCAEF94C50@HE1PR0402MB3499.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501241)(52105095)(10201501046)(93006095)(93001095)(6055026)(6041288)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR0402MB3499;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0402MB3499;
x-forefront-prvs: 05991796DF
x-microsoft-antispam-message-info: tRVkqpVb6m9U9+y4qVC2rvBqtxiv4JQEhGiemHo/S9ffSp+HFJO1hyTOPLWquGBsD9Tw+7iGgtKy6AYWqMWQyvR1ttsz0hQUS2MB1FmshFO/gykhLyCnQ9M2RuIA/hBTTnEzgrOUIj/0mFI+u9YBNLH2Y2yWhiH2nehfoy8FqDw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42983eb1-4827-405e-ac60-08d5805e615d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2018 16:55:19.0353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3499
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593481642628756060?=
X-GMAIL-MSGID: =?utf-8?q?1593845716495044530?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

-----Original Message-----
From: Greg KH [mailto:gregkh@linuxfoundation.org]=20
Sent: Thursday, March 1, 2018 6:32 PM
To: Ruxandra Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
Cc: devel@driverdev.osuosl.org; Roy Pledge <roy.pledge@nxp.com>; Bogdan Pur=
careata <bogdan.purcareata@nxp.com>; linux-kernel@vger.kernel.org; Laurenti=
u Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH 4/4] staging: fsl-dpaa2/eth: allow the driver to compil=
e multi-arch

On Mon, Feb 26, 2018 at 10:28:07AM -0600, Ioana Radulescu wrote:
> Drop dependency on ARCH_LAYERSCAPE (which in turn depends on ARM64),=20
> thus allowing this driver to compile on all architectures supported by=20
> the fsl-mc bus driver.
>=20
> This was compile tested on:
>  - powerpc (corenet_basic_defconfig, ppc64_defconfig)
>  - x86 (i386_defconfig, x86_64_defconfig, needs CONFIG_OF)
>  - arm64 (defconfig)

Seems you need to compile it on more things, based on the kbuild warnings :=
(

Yes I do, sorry for the slip :(

I've added allmodconfig and the sparse endianness flag to my list of tests.
Will send a v2 early next week.

Thanks,
Ioana
