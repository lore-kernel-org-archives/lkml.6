Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C3DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EAAB206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DnuqtQRE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfBTLVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:21:25 -0500
Received: from mail-eopbgr70052.outbound.protection.outlook.com ([40.107.7.52]:58688
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726360AbfBTLVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:21:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UAyr+uSl3Fgt4JvHNRZyObQI19VPoWVWY8s9KzQLjo=;
 b=DnuqtQRESSYdqlFbehbKDAT70nvJn/vjCJW9FAfsl6qso7lrPcotXR2DMLFSoiiCcHmdHKCZxfZBevoOE2Rmu1Wt8DlrIZqNpyoBMCnPjtK7qe/7V2CfmGfpa/ME8BmehndEhLEJM/2T8jrvaZqgTvver4fHjfwnG+C+Qh03nSU=
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com (52.135.168.141) by
 AM6PR04MB4998.eurprd04.prod.outlook.com (20.177.35.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Wed, 20 Feb 2019 11:21:19 +0000
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08]) by AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08%5]) with mapi id 15.20.1622.020; Wed, 20 Feb 2019
 11:21:19 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
CC:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] dt-bindings: imx: update scu resource id headfile
Thread-Topic: [PATCH] dt-bindings: imx: update scu resource id headfile
Thread-Index: AQHUyDGr6JcuNwk39kK74/kE/Vm176XnE3iAgAAGyxCAABmaAIAABhpAgADPbuCAAE95AIAAFTeQgAAWXoCAAAIvkA==
Date:   Wed, 20 Feb 2019 11:21:18 +0000
Message-ID: <AM6PR04MB4215D9FE015E9251425B0FFC807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
References: <1550566601-11497-1-git-send-email-Anson.Huang@nxp.com>
 <20190219125211.2pg2bqxner4klcb5@pengutronix.de>
 <DB3PR0402MB3916AF3AA0283DB22DF61E2FF57C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190219144808.qqpaubjcsb4huoml@pengutronix.de>
 <DB3PR0402MB39160A56E168ED20410674D7F57C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM6PR04MB42152D05E62753E760741160807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
 <20190220081650.cu3yzausx55jefb6@pengutronix.de>
 <AM6PR04MB4215014B734F71D409D617A5807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
 <20190220105249.u2hcvk6ut3cycvqs@pengutronix.de>
In-Reply-To: <20190220105249.u2hcvk6ut3cycvqs@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee65365b-4f46-4992-0b82-08d697258934
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4998;
x-ms-traffictypediagnostic: AM6PR04MB4998:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM6PR04MB4998;23:iKLWrvrr7q5duslbiaiahz4EOgTgxesEReS/ty9+W?=
 =?us-ascii?Q?qD058TTzjxsX+685/A525MKSacMZOV2SbKXDZoCk05IN/G1OXI6w7iAw1KD4?=
 =?us-ascii?Q?7Sk9bhFa5GQt18AJQ9ANEsThHl+Z5cXytBMDbLqXPFKekuS3LAN1Yn4nXCO5?=
 =?us-ascii?Q?B+2m2GUV3FTEnGoFZ7pSubbnAJg6+zil+3rztxFUkzIq2O209tgiFyOErZ/9?=
 =?us-ascii?Q?J+9Er0H/a+ewXYP84Ia/3eFldKlTDYubGG9cmVWZrSEZNdvyU2i0Y64tWMZw?=
 =?us-ascii?Q?dhtg1Pcj4TYuaWqD52RLXM54aMOVn+3qTXN/s2R3RrNDAIFHKiEzKfd/PKhD?=
 =?us-ascii?Q?haM9N12gFo+fdFcgGHGMYFu/bJBXAXniy6HH5dKRbvELVwchwdmoMkdbnbhZ?=
 =?us-ascii?Q?P0hL4jcwZN6kk2lMn0i8ynJzDFymIJ2qNbrq8Fh/YzSZfvXf1njKuVVylaDb?=
 =?us-ascii?Q?GYwXMVjG9KVjo1S20yxzJTwzXHEUXNEDDgx9RJ2jPnX1o+e7+Vwf6ekQBYEi?=
 =?us-ascii?Q?Y34kxj72OxTzizaPyD9rQa7sNzjJLQVW0+atDRsUAndAJls0Q77R3c56RO8+?=
 =?us-ascii?Q?tu+OHX+zIl7GZVJqrzBNyOAEpbonhuGhTcow9+CHE4rTwUsyteh2KICaB4c8?=
 =?us-ascii?Q?0TeMIPvnzNX7nmUVgrjmrqCrH5JfmQAJ6htKEXwll/1VKwHPKfTNeBD5oKV9?=
 =?us-ascii?Q?B8akp2jtBjBQJKGPNW8pSzD9YTKOIuWcWlKjYpWVMnkYrRynjVwzAT4C3Wui?=
 =?us-ascii?Q?m4j0UtZCAs/V7dBLCcF95dnUyHuBaikbyg8FWZcLGsbCtvYf+NJ+3WgVr45N?=
 =?us-ascii?Q?xCnoWssgqeRNJdt12Xp4NtdZoP7m9YV9QPqiTZ6hzKNuU8GqMvX9vqOkcbiF?=
 =?us-ascii?Q?DKfPrs32XEwYkB98TL/4Ay42s0/OKUtwyKfWwfDw9OGbpzN3fXQuGcuo/pdW?=
 =?us-ascii?Q?WhnfxHd45130t0dMdxJkC+a4NJQ3J+hQQf9O+lKFJ/NPhoTaYrZtfjhNknqQ?=
 =?us-ascii?Q?n+nYPzWbXG9mD7rkaJN1+fE7AgXbaibp58SzrkFBj1kyyPdBqruv/PoTDfwk?=
 =?us-ascii?Q?gAEww4ls9B5eDn6f9/1GjFeC3K8Pns0RlbZ2LnXoKLRZTC2H4Kih5aCr+w7S?=
 =?us-ascii?Q?lWsokrDBb7OnLXVeDfn6gW09wo9wWItT/B134BphMnyVl1x1XF6Th+NEFn6g?=
 =?us-ascii?Q?1hGMi43QYks33QpCAvOewr92j1YecP2OD2WLanup5A3RnbMxYIsBR89A3bB8?=
 =?us-ascii?Q?MxPyILL20+eIYu8lkgSjKSca6K3dtSj1EkBQD9xSUT6BNaaCSamEhS0aCAso?=
 =?us-ascii?Q?/VeKIklFIq+H37WrYSwo/6RV7HTDhFOqb5Ata7Q3221K9E1C8qwCECUgPm0f?=
 =?us-ascii?Q?VBRUQC1Yvu/Q86MOw8AtpZy9nU=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB49982F3687FE012C8BFCD877807D0@AM6PR04MB4998.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(366004)(136003)(396003)(199004)(189003)(52314003)(6506007)(74316002)(6116002)(53546011)(102836004)(93886005)(3846002)(7696005)(6246003)(4326008)(25786009)(316002)(8676002)(26005)(6436002)(8936002)(5660300002)(81166006)(186003)(97736004)(53936002)(99286004)(55016002)(54906003)(305945005)(2906002)(229853002)(7416002)(76176011)(9686003)(7736002)(81156014)(6916009)(86362001)(15650500001)(6306002)(14454004)(45080400002)(966005)(476003)(33656002)(11346002)(486006)(44832011)(105586002)(68736007)(66066001)(446003)(478600001)(106356001)(256004)(71190400001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4998;H:AM6PR04MB4215.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5A3VY4AxcqEB8xT/m7G3JCxfQFC9c0gaSqjLHGKUSq0P9TCy4YsUK4l8KcV8NzithvG3TGYoO3coR9Vs0LOsJ1/zansFfEcJOCesQQpgUgi/RAgb7M05Dz4rSnmBM9SwwpjldYysj4tJE4u9Uao4DSGGF0Jh7q90XZzJ8El8MqlIXSRvLKMhfv8BvxpMx8y2jtRpO9OuvrIZtls5vB+ZY87Uf1nfngZMzYaNdkfu7zdLLoZIpC3ksm76XmgUuxefwt567J30vvuzQx8fCUYyYheRpDUwSs9NpxV5EscNpG3xL5xYWtG10+WowUcvwEHbst2sVt9FsO5D6Pzb8IQ4wknVAldI/90fE9wofgUkNLC0J9ewhBGDbe6HWYUV0KdKeMUAWbC+KCT0FXhZ8LZBJQPbUfg6xG+pWHcrRZKv7/w=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee65365b-4f46-4992-0b82-08d697258934
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 11:21:18.9626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4998
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

> From: Marco Felsch [mailto:m.felsch@pengutronix.de]
> Sent: Wednesday, February 20, 2019 6:53 PM
>=20
> Hi Aisheng,
>=20
> On 19-02-20 09:49, Aisheng Dong wrote:
> > > From: Marco Felsch [mailto:m.felsch@pengutronix.de]
> > > Sent: Wednesday, February 20, 2019 4:17 PM On 19-02-20 03:38,
> > > Aisheng Dong wrote:
> > > > [...]
> > > >
> > > > > > I don't like droping some ID's (e.g. IMX_SC_R_DC_0_CAPTURE0)
> > > > > > by mark them as unused or even worse give them a other
> > > > > > meaning. IMHO the scu-api should be stable since day 1 and the
> > > > > > ID's should only be
> > > extended.
> > > > > > Marking ID's as deprecated is much better than moving them arou=
nd.
> > > > >
> > > > > I agree the SCU APIs should be stable since day 1 and the ID
> > > > > should ONLY be extended, but that is the best cases, the reality
> > > > > is, there are different SoCs/Revision, some revisions may remove
> > > > > the resources ID defined in pre-coded SCU firmware, like the
> > > > > IMX_SC_R_DC_0_CAPTURE0 etc., so SCU APIs removes them after real
> > > > > silicon arrived, now latest SCU firmware marks them as UNUSED,
> > > > > they could be replaced by some other new resources in later new
> > > > > SoC, I am NOT sure, but if it happens, this resource ID table
> > > > > should be updated anyway, leaving the out-of-date resource ID
> > > > > table there will have
> > > issues, since it is NOT sync with SCU firmware.
> > > > >
> > > > > So how to resolve such issue? We hope the SCU firmware should be
> > > > > stable since day 1, but the truth is NOT, could be still some
> > > > > updates but NOT very often. And I believe the updates will NOT
> > > > > break old
> > > kernel version.
> > >
> > > Hi Anson,
> > >
> > > Please don't mix the dt-bindings and the kernel related stuff.
> > > Unfortunately the bindings are within the kernel repo which in fact
> > > is great for us kernel developer but the bindings are also used in
> > > other projects such as barebox or other kernels (don't know the BSD
> > > guys). So you can't ensure that your change will break something. Ple=
ase
> keep that in mind.
> > >
> > > IMHO solving that issue should be done by the scu firmware. I tought
> > > the scu is a cortex-m4 with a bunch of embedded flash and ram (I
> > > don't know that much about the scu since it is closed/black-boxed).
> > > Why do you don't use a translation table within the scu? As I said
> > > earlier I don't like the redefinition of ID's since they are now part=
 of the
> dt-bindings.
> > > The bindings can store up to 32bit values which is a large number ;)
> > > IMHO wasting some ID's in favour of stability is a better solution.
> > >
> >
> > As far as I know, those remove resource IDs are pre-defined and has
> > never been used and won't be used anymore by SC firmware. (Anson can
> > double check it) So I think it's safe to remove them or mark them as
> deprecated.
>=20
> I think marking them as deprecated by a commentar is better than redefini=
ng
> bits to be unused. As I said the bindings not only linux related they are=
 used in
> other projects too.
>=20

For other projects, the result is same because SC firmware does not support=
 those
Resource IDs.

> >
> > Personally I may prefer to remove them as they never worked to avoid
> > confusing, especially at this early stage for mx8.
>=20
> So why they are there if they never worked? Wouldn't it a better approach=
 to
> start with a basic and working ID file and extend this rather than adding=
 id's
> because maybe the will work..=20

Ideally yes, but may be hard in reality.

SC firmware code usually is developed quite early before silicon comes.
But the real chip may changes, e.g. removed or added something.

AFAIK those resource IDs removed have never worked in SC firmware,
and they're likely to come out of pre-silicon definition. But chip changes
later.

> Sorry but this seems wrong to me too.
> I know the approach from driver development, adding a driver specific *_r=
eg.h
> file and later figuring out that those bits won't work as aspected. As I =
said this
> will be driver and only linux related so we can change them as many times=
 as
> we want. But in your case we are talking about dt-bindings and this appro=
ach
> won't work.

I would agree with you if those resource IDs have worked before.
But they never worked.
Should we keep a thing never worked in device tree just because
It makes us look like keeping compatibility?

If that, I'd rather removing them to avoid confusing in the future. Life is=
 long, right?
I don't want people to bother with those unmeaning things anymore when they
look at it.

Regards
Dong Aisheng

>=20
> Regards,
> Marco
>=20
> >
> > Regards
> > Dong Aisheng
> >
>=20
> --
> Pengutronix e.K.                           |
> |
> Industrial Linux Solutions                 |
> https://emea01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.
> pengutronix.de%2F&amp;data=3D02%7C01%7Caisheng.dong%40nxp.com%7C7e
> 39985c9866476290b608d697219367%7C686ea1d3bc2b4c6fa92cd99c5c301
> 635%7C0%7C0%7C636862567803869154&amp;sdata=3D2kFu%2BC7Eh%2BYYrT
> azzrKSHalHfZpdoiEw4RrxcSAMCQg%3D&amp;reserved=3D0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |
