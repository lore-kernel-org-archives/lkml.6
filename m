Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A28C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3852146F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xHYujHc1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbfBTDiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 22:38:14 -0500
Received: from mail-eopbgr80047.outbound.protection.outlook.com ([40.107.8.47]:34992
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726312AbfBTDiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 22:38:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qC07NkczR5uU2NWzIo3+Oiz9hDOhnOSJP0Oytvn7/Y=;
 b=xHYujHc1We4sbVq1gXtR/M6RAMk7O8Jvs67mno5Yl6dzsbhyRg1qsa6A+Vg9NU4IajPj4LoRZWdOTOuYuZ9liRiy/9JfnSa+DtWkWKj3Nj2ZNgygzfyOS+jYcySd7KWeoHuzCYK/a63s5ARLfKEQmVOYYZQuTPvWZFO1MTLO65s=
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com (52.135.168.141) by
 AM6PR04MB5574.eurprd04.prod.outlook.com (20.178.94.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Wed, 20 Feb 2019 03:38:05 +0000
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08]) by AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08%5]) with mapi id 15.20.1622.020; Wed, 20 Feb 2019
 03:38:05 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
Thread-Index: AQHUyDGr6JcuNwk39kK74/kE/Vm176XnE3iAgAAGyxCAABmaAIAABhpAgADPbuA=
Date:   Wed, 20 Feb 2019 03:38:04 +0000
Message-ID: <AM6PR04MB42152D05E62753E760741160807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
References: <1550566601-11497-1-git-send-email-Anson.Huang@nxp.com>
 <20190219125211.2pg2bqxner4klcb5@pengutronix.de>
 <DB3PR0402MB3916AF3AA0283DB22DF61E2FF57C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190219144808.qqpaubjcsb4huoml@pengutronix.de>
 <DB3PR0402MB39160A56E168ED20410674D7F57C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39160A56E168ED20410674D7F57C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a11c7bb-19ad-42cf-52f9-08d696e4d2a7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5574;
x-ms-traffictypediagnostic: AM6PR04MB5574:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM6PR04MB5574;23:YinqQICEmXMgDsVmLIas7dbzoSm5q1xSYQFmXyjhZ?=
 =?us-ascii?Q?DmcmMpzDObuXRySnIOekanLTSRcq8ejLCOnvDg03LqCI2sCv8Klm9PzEcqb1?=
 =?us-ascii?Q?re6C3Sqy35QgLgEj1BopDp/V352FHZJo0EHM+tMp43E3pRm+Klgut8iBDaTi?=
 =?us-ascii?Q?GdHPq2JndN8dt0v0r5WhhOt2EM/pDKtZ9GKanIGXgUahYtV/w9YIlv+LZUkA?=
 =?us-ascii?Q?N6XKdgs1qcKNve98jEiFGpplVtGo5r2bTN/MoXF2EQ76vIsT4OE47AeffxXc?=
 =?us-ascii?Q?Z2+p6dS1IxcMVnO+R+M4MDL//o3kzSjBaOV3rsQjnLMrXd//ISQ9GdfOyi13?=
 =?us-ascii?Q?66Z51fB2OojZaQ5+OgGT0odMjDl8f3LCUAUk6fS+zfGUlGpa9KeZ2YwyrrOS?=
 =?us-ascii?Q?KXknEossJVmACDU0hT1XG2c9fImU8jLG6IL62PNZeW40ooTdW/V4ZzvjarZT?=
 =?us-ascii?Q?dvQ4QV2w2qGT1sxuBTvZ2MSi9DHiVy2YxoYYyJa2KyAnq5tIaENuRwwljufK?=
 =?us-ascii?Q?qpzBayoRoJe2n0ovrinfRFLHa/yTKFY0xSy4N8Ibr+Ao8mWuYYUVf6Oy58pE?=
 =?us-ascii?Q?n92kScF5jxlh/wygrZTnJZL/t9M80V6a0ybnXt0i0izaZJPaYE4sx6+s07jT?=
 =?us-ascii?Q?xiWqrw/2Syxy9CzuDlqfF903bQBfieuWqz7ieq9Sh+0MdWOOp/m7B89muhtB?=
 =?us-ascii?Q?riLAE9fUhWZSTYYbE/66GzR9hqAaakTDZtYDF1ZM1tZuLUpWrnf+H/XEnyNi?=
 =?us-ascii?Q?9GVurf/xJID43he3cVsyMLCQgYPYdCOAZYC1xii4wF1Y83UIO0jh9Lzby3yC?=
 =?us-ascii?Q?ZQYfKCGV2KXVrImY92GP2kAdCdyRi2DNv0q+EViy7kGJbizisYFgfDQFKdnv?=
 =?us-ascii?Q?rzJpvtfP8thy3wCExd6Z6JcuT8BX4KKw3/fJiwMEH1EAqdI1tITAeSdgHJw2?=
 =?us-ascii?Q?91KsHYN8nlX9X4hrFhxZnXfjqOh97VgAqCRlZeWJnvjxqPeGchJMvUA995gn?=
 =?us-ascii?Q?6e/TLGMDfDVa8kUaAMfWn9Ps60o0lmSZAdCaxYEnO0tduGObfJfM4n9Ki+8I?=
 =?us-ascii?Q?srR9D6xYuypWoRv4QTkpQD9pqJMDZicZLYft+8OmSQyv3nUeh5Y/JjktBDn8?=
 =?us-ascii?Q?QixWj+IbTZgqsjHZbhqviNcQK7u0SyDXDhhEpkFfq6Z+/RuIIR2P8utzBoDw?=
 =?us-ascii?Q?LJbqzPi+NPZyVlU5S61INDeHzkymFp3o6NWxRDaM/Tidu5e4IfReNgyLIMF4?=
 =?us-ascii?Q?xx039HsNHLPfbeD/zBmqqSRN6T59Vf76e+NmvbQUADA3oxH6oOUjHuEn9AYM?=
 =?us-ascii?Q?WaUQwalhmuJ3I8iPfwxz2E8T109E2GGks/GCnvKjM4wXQKcB45zaR+9/Vjr8?=
 =?us-ascii?Q?XfdQYrkJ170wi/F7UkX7bxmfY8=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB5574B427A73F7416B1E5CBE5807D0@AM6PR04MB5574.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(346002)(376002)(396003)(189003)(199004)(52314003)(305945005)(4326008)(7736002)(68736007)(229853002)(478600001)(71190400001)(74316002)(71200400001)(966005)(110136005)(45080400002)(25786009)(5660300002)(44832011)(486006)(54906003)(316002)(476003)(14454004)(66066001)(446003)(11346002)(93886005)(105586002)(3846002)(2906002)(6116002)(7416002)(8676002)(106356001)(6436002)(102836004)(26005)(6506007)(256004)(97736004)(99286004)(7696005)(9686003)(6306002)(76176011)(186003)(86362001)(55016002)(15650500001)(53936002)(6246003)(81156014)(81166006)(8936002)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5574;H:AM6PR04MB4215.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /QTyDMmhFb48/EA2dbI9N4KvwGxnfuYGSv1UH3zaT/6/FpX3rQfYcC6jt/u5JEepMp7hrafD8CHP/5nxjPXV1/rr7AoaIXqRRLc8zbbu+VfvTz2S2EHtOh9Pa+f/f9Da33xexreDOLeBn6mRF3D02owd4lzNkNhvEZEiMwGnzyIRXpthi1DiqyXFxIsiC/qTQ8hh1GCWMaRVysdCpGLND7vpLcaI5+KGv8lZEt8p5eEXVLPgLaWMDLf1WZXJfGu5/Y4Mxq4+gQO+P+Bx9XSIu+lhLOfSrhqSqmrXIb2ewtBdAu58vYszto7dkp584i9paWPE8GMJTo8bYAV8f1CDcBo0bmA5AYevc+k7I27gIeGf95X5WTeFODXXlOGe4Ccalw+dgtSKJFOHJ+iZfUKpE1WKuPszK55RqMxU984Jldo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a11c7bb-19ad-42cf-52f9-08d696e4d2a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 03:38:04.8783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5574
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > I don't like droping some ID's (e.g. IMX_SC_R_DC_0_CAPTURE0) by mark
> > them as unused or even worse give them a other meaning. IMHO the
> > scu-api should be stable since day 1 and the ID's should only be extend=
ed.
> > Marking ID's as deprecated is much better than moving them around.
>=20
> I agree the SCU APIs should be stable since day 1 and the ID should ONLY =
be
> extended, but that is the best cases, the reality is, there are different
> SoCs/Revision, some revisions may remove the resources ID defined in
> pre-coded SCU firmware, like the IMX_SC_R_DC_0_CAPTURE0 etc., so SCU APIs
> removes them after real silicon arrived, now latest SCU firmware marks th=
em
> as UNUSED, they could be replaced by some other new resources in later ne=
w
> SoC, I am NOT sure, but if it happens, this resource ID table should be u=
pdated
> anyway, leaving the out-of-date resource ID table there will have issues,=
 since it
> is NOT sync with SCU firmware.
>=20
> So how to resolve such issue? We hope the SCU firmware should be stable
> since day 1, but the truth is NOT, could be still some updates but NOT ve=
ry
> often. And I believe the updates will NOT break old kernel version.
>=20

Please double check with SCU firmware owner what the removed ID are used be=
fore?
Any side effect if removing them.

And please also check if the combability can be maintained via IMX_SC_RPC_V=
ERSION?

Regards
Dong Aisheng

> Anson.
>=20
> >
> > Regards,
> > Marco
> >
> > >
> > > Anson.
> > >
> > > >
> > > > Regards,
> > > > Marco
> > > >
> > > > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > > > ---
> > > > >  include/dt-bindings/firmware/imx/rsrc.h | 39
> > > > > +++++++++++++++++++--------------
> > > > >  1 file changed, 22 insertions(+), 17 deletions(-)
> > > > >
> > > > > diff --git a/include/dt-bindings/firmware/imx/rsrc.h
> > > > > b/include/dt-bindings/firmware/imx/rsrc.h
> > > > > index 4481f2d..ad747a8 100644
> > > > > --- a/include/dt-bindings/firmware/imx/rsrc.h
> > > > > +++ b/include/dt-bindings/firmware/imx/rsrc.h
> > > > > @@ -36,15 +36,15 @@
> > > > >  #define IMX_SC_R_DC_0_BLIT1		20
> > > > >  #define IMX_SC_R_DC_0_BLIT2		21
> > > > >  #define IMX_SC_R_DC_0_BLIT_OUT		22
> > > > > -#define IMX_SC_R_DC_0_CAPTURE0		23
> > > > > -#define IMX_SC_R_DC_0_CAPTURE1		24
> > > > > +#define IMX_SC_R_PERF			23
> > > > > +#define IMX_SC_R_UNUSED5		24
> > > > >  #define IMX_SC_R_DC_0_WARP		25
> > > > > -#define IMX_SC_R_DC_0_INTEGRAL0		26
> > > > > -#define IMX_SC_R_DC_0_INTEGRAL1		27
> > > > > +#define IMX_SC_R_UNUSED7		26
> > > > > +#define IMX_SC_R_UNUSED8		27
> > > > >  #define IMX_SC_R_DC_0_VIDEO0		28
> > > > >  #define IMX_SC_R_DC_0_VIDEO1		29
> > > > >  #define IMX_SC_R_DC_0_FRAC0		30
> > > > > -#define IMX_SC_R_DC_0_FRAC1		31
> > > > > +#define IMX_SC_R_UNUSED6		31
> > > > >  #define IMX_SC_R_DC_0			32
> > > > >  #define IMX_SC_R_GPU_2_PID0		33
> > > > >  #define IMX_SC_R_DC_0_PLL_0		34
> > > > > @@ -53,17 +53,17 @@
> > > > >  #define IMX_SC_R_DC_1_BLIT1		37
> > > > >  #define IMX_SC_R_DC_1_BLIT2		38
> > > > >  #define IMX_SC_R_DC_1_BLIT_OUT		39
> > > > > -#define IMX_SC_R_DC_1_CAPTURE0		40
> > > > > -#define IMX_SC_R_DC_1_CAPTURE1		41
> > > > > +#define IMX_SC_R_UNUSED9		40
> > > > > +#define IMX_SC_R_UNUSED10		41
> > > > >  #define IMX_SC_R_DC_1_WARP		42
> > > > > -#define IMX_SC_R_DC_1_INTEGRAL0		43
> > > > > -#define IMX_SC_R_DC_1_INTEGRAL1		44
> > > > > +#define IMX_SC_R_UNUSED11		43
> > > > > +#define IMX_SC_R_UNUSED12		44
> > > > >  #define IMX_SC_R_DC_1_VIDEO0		45
> > > > >  #define IMX_SC_R_DC_1_VIDEO1		46
> > > > >  #define IMX_SC_R_DC_1_FRAC0		47
> > > > > -#define IMX_SC_R_DC_1_FRAC1		48
> > > > > +#define IMX_SC_R_UNUSED13		48
> > > > >  #define IMX_SC_R_DC_1			49
> > > > > -#define IMX_SC_R_GPU_3_PID0		50
> > > > > +#define IMX_SC_R_UNUSED14		50
> > > > >  #define IMX_SC_R_DC_1_PLL_0		51
> > > > >  #define IMX_SC_R_DC_1_PLL_1		52
> > > > >  #define IMX_SC_R_SPI_0			53
> > > > > @@ -303,8 +303,8 @@
> > > > >  #define IMX_SC_R_M4_0_UART		287
> > > > >  #define IMX_SC_R_M4_0_I2C		288
> > > > >  #define IMX_SC_R_M4_0_INTMUX		289
> > > > > -#define IMX_SC_R_M4_0_SIM		290
> > > > > -#define IMX_SC_R_M4_0_WDOG		291
> > > > > +#define IMX_SC_R_UNUSED15		290
> > > > > +#define IMX_SC_R_UNUSED16		291
> > > > >  #define IMX_SC_R_M4_0_MU_0B		292
> > > > >  #define IMX_SC_R_M4_0_MU_0A0		293
> > > > >  #define IMX_SC_R_M4_0_MU_0A1		294
> > > > > @@ -323,8 +323,8 @@
> > > > >  #define IMX_SC_R_M4_1_UART		307
> > > > >  #define IMX_SC_R_M4_1_I2C		308
> > > > >  #define IMX_SC_R_M4_1_INTMUX		309
> > > > > -#define IMX_SC_R_M4_1_SIM		310
> > > > > -#define IMX_SC_R_M4_1_WDOG		311
> > > > > +#define IMX_SC_R_UNUSED17		310
> > > > > +#define IMX_SC_R_UNUSED18		311
> > > > >  #define IMX_SC_R_M4_1_MU_0B		312
> > > > >  #define IMX_SC_R_M4_1_MU_0A0		313
> > > > >  #define IMX_SC_R_M4_1_MU_0A1		314
> > > > > @@ -337,7 +337,7 @@
> > > > >  #define IMX_SC_R_IRQSTR_SCU2		321
> > > > >  #define IMX_SC_R_IRQSTR_DSP		322
> > > > >  #define IMX_SC_R_ELCDIF_PLL		323
> > > > > -#define IMX_SC_R_UNUSED6		324
> > > > > +#define IMX_SC_R_OCRAM			324
> > > > >  #define IMX_SC_R_AUDIO_PLL_0		325
> > > > >  #define IMX_SC_R_PI_0			326
> > > > >  #define IMX_SC_R_PI_0_PWM_0		327
> > > > > @@ -554,6 +554,11 @@
> > > > >  #define IMX_SC_R_VPU_MU_3		538
> > > > >  #define IMX_SC_R_VPU_ENC_1		539
> > > > >  #define IMX_SC_R_VPU			540
> > > > > -#define IMX_SC_R_LAST			541
> > > > > +#define IMX_SC_R_DMA_5_CH0		541
> > > > > +#define IMX_SC_R_DMA_5_CH1		542
> > > > > +#define IMX_SC_R_DMA_5_CH2		543
> > > > > +#define IMX_SC_R_DMA_5_CH3		544
> > > > > +#define IMX_SC_R_ATTESTATION		545
> > > > > +#define IMX_SC_R_LAST			546
> > > > >
> > > > >  #endif /* __DT_BINDINGS_RSCRC_IMX_H */
> > > > > --
> > > > > 2.7.4
> > > > >
> > > > >
> > > > >
> > > >
> > > > --
> > > > Pengutronix e.K.                           |
> |
> > > > Industrial Linux Solutions                 |
> > > >
> > https://emea01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fww
> > > >
> > w.pengutronix.de%2F&amp;data=3D02%7C01%7Canson.huang%40nxp.com%7
> > > >
> >
> Cfe709ac17a164d82c7d508d6966915fb%7C686ea1d3bc2b4c6fa92cd99c5c30
> 1
> > > >
> >
> 635%7C0%7C0%7C636861775412076730&amp;sdata=3D05ZzPf2%2BQF10JXLLs
> > > > OPqDdqTi00BWXNHxmMOsQ1z0yI%3D&amp;reserved=3D0  | Peiner Str.
> 6-8,
> > > > 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> > |
> > > > Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |
> >
> > --
> > Pengutronix e.K.                           |
> |
> > Industrial Linux Solutions                 |
> > https://emea01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fww
> > w.pengutronix.de%2F&amp;data=3D02%7C01%7Canson.huang%40nxp.com%7
> >
> Cd5d39730435e4b06549c08d696794904%7C686ea1d3bc2b4c6fa92cd99c5c
> 30
> >
> 1635%7C0%7C0%7C636861845015130502&amp;sdata=3DtQYrNl5lzIRRNVBCji6
> A
> > sPREOnIfDgdPWgAnsWyCErg%3D&amp;reserved=3D0  |
> > Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> |
> > Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |
