Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A854DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E1E21738
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZVrOg0OL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbfBTDnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 22:43:22 -0500
Received: from mail-eopbgr70058.outbound.protection.outlook.com ([40.107.7.58]:29536
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725916AbfBTDnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 22:43:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcRzecFT1PgK94fyfYu1410JzFeCZIHA3UBnWSaglWo=;
 b=ZVrOg0OL8DAmN2T9pDHuKLua+w8lCO4wXRGgBuvC8iNHDpMlpObAlrJ0NDl21mdIT+R4G21TiLJ/yFtE8v1ITGoSxwbZQ2ywqIzJWtsGv4DO9synQq0mLBDt904u3m3Th/aOXnohV2NKILR67Pn+eepPK1w3J2Wvs9CSKqQ98FY=
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com (52.135.168.141) by
 AM6PR04MB5574.eurprd04.prod.outlook.com (20.178.94.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Wed, 20 Feb 2019 03:43:14 +0000
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08]) by AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08%5]) with mapi id 15.20.1622.020; Wed, 20 Feb 2019
 03:43:14 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] dt-bindings: imx: update scu resource id headfile
Thread-Topic: [PATCH] dt-bindings: imx: update scu resource id headfile
Thread-Index: AQHUyDGr6JcuNwk39kK74/kE/Vm176XoB/yAgAACMOCAAAEpAA==
Date:   Wed, 20 Feb 2019 03:43:14 +0000
Message-ID: <AM6PR04MB4215CDF6103C8E085802DA91807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
References: <1550566601-11497-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB421521095AEEC7530E97998A807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916C81C158BD68ECB4DA7B6F57D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916C81C158BD68ECB4DA7B6F57D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bdd633b5-59df-44e6-3a60-08d696e58b1a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5574;
x-ms-traffictypediagnostic: AM6PR04MB5574:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM6PR04MB5574;23:hPh3oBSRydjPs5lkQDJhio7t8K0zPHU+6hl1LNXio?=
 =?us-ascii?Q?w+KvYLnCl+tWmyoP8EnUsbak6A5oijYA6rTKo7mW/OrRQOZ+uPBZAuC/i9p3?=
 =?us-ascii?Q?LGNXsFkQvMOv2T0XAh16hFi6RTL853Su0IWMmj8Xvz5JIwBADttL+ZeJZksJ?=
 =?us-ascii?Q?GhRVgmE1PGlNKuOTTsk/ujAFU5NIxBGEtviVOD+Uk4q/gt/lwgMOCcQoJM92?=
 =?us-ascii?Q?vJXi7NvM1jqDPzTdZ0ZiUKfDYoi+yLmnw4DALh5tSYiBAyz3JIoYCL/Breg4?=
 =?us-ascii?Q?qvborL553l/JXJGFoIbs5KJ1Gk/1B2blH889E5KAJW5RPewxImiePuV6aSwj?=
 =?us-ascii?Q?1ohoolL3PQDctr3w/Fx+asmvMrXnfjihVKl9TYAB8DDkPnhu54U6zId5j6j9?=
 =?us-ascii?Q?Lg8XWjNOe3GWjPw0znfqaNUp3501x+HXuzzu3Tal+0tsWfR476ZwC8jOy7Tq?=
 =?us-ascii?Q?xe8k6XZCyJftuhKJBrrReHjAsULmQF24Is0I2SzT9LNGOa3rEX1TtZ0qPCh8?=
 =?us-ascii?Q?JzUwFZrPkV/xdFaqXHum3q/WNgwrPKKSB6O/95XsCjrDw4p3h+vJ0ENWGT5R?=
 =?us-ascii?Q?gKFJLtTYlTvbRjx+tmneFRYrXbP/eiDgh4NKNTSrgPg7ZVVlfx61UpSRgTXS?=
 =?us-ascii?Q?W4K2Ge1b56F6G33OkkowVmrIBC1cDXpEG2DrT+nPUix1z/6q9SX/ITlZHCUx?=
 =?us-ascii?Q?4jJZViowBVoRukfFYRp52zij2o1CnaCtkXxOznEx2MgVmLhArhiphFGqvdwS?=
 =?us-ascii?Q?hCRrNKse3/IU5ygw2jIe4D0syYKW93bT0X1IytUVkq4b+r9dpm0L9nU6ra8a?=
 =?us-ascii?Q?AiafkEi3i81Flut97K2UISt9xxNejlhAr9bHOBQM3jZd/6283Y/xthIac71j?=
 =?us-ascii?Q?sug8WiD+Y2bZoSixosBLgPKfcZPSdsY9PtN0SWbd380kFZ2ciSoN4Jgfvg8m?=
 =?us-ascii?Q?zd7rsSnp/4ZBzYBjPeEwGeTwecKXr8ugwHGLKLZjRZRC/JlkCT/PImTW013T?=
 =?us-ascii?Q?+GT+kpY+Lw22jjxOdxyIGhudlglU5eiX4huQlZpl81W59gcDIlKUrcsfXCZ+?=
 =?us-ascii?Q?2Pzjpq7lbO9t9ftrHbHGjGFZ6WOWw2PQcxXZD2/sfkTVtbR81S178fiMV1QS?=
 =?us-ascii?Q?HNJoC46nAc4sZvgdx6yE6WKyEzafN7VsQjHDYJxIAPuybniIPh/vDcjGo/H1?=
 =?us-ascii?Q?ZZoSzI6cIiUTRinVVz7uZBqr9+c+J16Y9Hy72ecZK/ZUFAqO889B4TicREGU?=
 =?us-ascii?Q?7MgEDqOoV//Zd7NfB3JqHQs86a7JqABel9yg9RPPpLKqbQlJYTI9XTuVw0xO?=
 =?us-ascii?B?Zz09?=
x-microsoft-antispam-prvs: <AM6PR04MB55747E3B0FA8E97E7760D15C807D0@AM6PR04MB5574.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(346002)(376002)(396003)(189003)(199004)(305945005)(4326008)(7736002)(68736007)(229853002)(478600001)(71190400001)(74316002)(71200400001)(110136005)(25786009)(5660300002)(44832011)(486006)(316002)(476003)(14454004)(66066001)(446003)(11346002)(105586002)(3846002)(2906002)(6116002)(7416002)(8676002)(106356001)(6436002)(102836004)(26005)(6506007)(256004)(97736004)(99286004)(2201001)(7696005)(9686003)(76176011)(186003)(86362001)(55016002)(2501003)(53936002)(6246003)(81156014)(81166006)(8936002)(33656002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5574;H:AM6PR04MB4215.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5bMhYbbGL9wyEn+yonmGOq1BpAv7KJ+A4IFxGpgpPsx6tckqy2KffaPyaIbDOGQr8svz3mlxBgmvpRKWrR1UzBh+cPBFcgP4N5IHUOXvpBpnciWS2TnHXEZpe8fSlgIVwtx2Wy6vv5T6vCksHUB1L012fhhg9nO5UCHdjrAWdcADiSZ4Qzo2yhJGRZptnQFP+zj1iuHCbkVH6mC6DK6wFwUHpk4EIgQ3T77AD/RKmGWVtC6IlWxu/aHGXuyY9kNRaqktwSNlcJ3Axu19I0uHaN+L/CdrSchRiAYCE0LoCqIwiXO6tI0L9BMuMymd7UdnTblDmzNQcjBQe5F2ZzeaKmy995zeQZHhabi5Ui2mT8NvGBLjYrJ+QOEutYX9j1T8zlfIx4T+QPZJRQQGiMgNp0xW6pfw2s1Z3oJIrQGOleA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd633b5-59df-44e6-3a60-08d696e58b1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 03:43:14.4262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5574
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > You need at least explain what changes made like what new features adde=
d?
> > What removed? Side affect if any?
>=20
> No new features added, looks like SCFW just remove some unused resources.
> No side-effect, as they are NOT used by anyone.
>=20

That seems not true.
I see some new IDs added.
e.g. IMX_SC_R_PERF, IMX_SC_R_OCRAM

Regards
Dong Aisheng

> Anson.
>=20
> >
> > Regards
> > Dong Aisheng
> >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > >  include/dt-bindings/firmware/imx/rsrc.h | 39
> > > +++++++++++++++++++--------------
> > >  1 file changed, 22 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/include/dt-bindings/firmware/imx/rsrc.h
> > > b/include/dt-bindings/firmware/imx/rsrc.h
> > > index 4481f2d..ad747a8 100644
> > > --- a/include/dt-bindings/firmware/imx/rsrc.h
> > > +++ b/include/dt-bindings/firmware/imx/rsrc.h
> > > @@ -36,15 +36,15 @@
> > >  #define IMX_SC_R_DC_0_BLIT1		20
> > >  #define IMX_SC_R_DC_0_BLIT2		21
> > >  #define IMX_SC_R_DC_0_BLIT_OUT		22
> > > -#define IMX_SC_R_DC_0_CAPTURE0		23
> > > -#define IMX_SC_R_DC_0_CAPTURE1		24
> > > +#define IMX_SC_R_PERF			23
> > > +#define IMX_SC_R_UNUSED5		24
> > >  #define IMX_SC_R_DC_0_WARP		25
> > > -#define IMX_SC_R_DC_0_INTEGRAL0		26
> > > -#define IMX_SC_R_DC_0_INTEGRAL1		27
> > > +#define IMX_SC_R_UNUSED7		26
> > > +#define IMX_SC_R_UNUSED8		27
> > >  #define IMX_SC_R_DC_0_VIDEO0		28
> > >  #define IMX_SC_R_DC_0_VIDEO1		29
> > >  #define IMX_SC_R_DC_0_FRAC0		30
> > > -#define IMX_SC_R_DC_0_FRAC1		31
> > > +#define IMX_SC_R_UNUSED6		31
> > >  #define IMX_SC_R_DC_0			32
> > >  #define IMX_SC_R_GPU_2_PID0		33
> > >  #define IMX_SC_R_DC_0_PLL_0		34
> > > @@ -53,17 +53,17 @@
> > >  #define IMX_SC_R_DC_1_BLIT1		37
> > >  #define IMX_SC_R_DC_1_BLIT2		38
> > >  #define IMX_SC_R_DC_1_BLIT_OUT		39
> > > -#define IMX_SC_R_DC_1_CAPTURE0		40
> > > -#define IMX_SC_R_DC_1_CAPTURE1		41
> > > +#define IMX_SC_R_UNUSED9		40
> > > +#define IMX_SC_R_UNUSED10		41
> > >  #define IMX_SC_R_DC_1_WARP		42
> > > -#define IMX_SC_R_DC_1_INTEGRAL0		43
> > > -#define IMX_SC_R_DC_1_INTEGRAL1		44
> > > +#define IMX_SC_R_UNUSED11		43
> > > +#define IMX_SC_R_UNUSED12		44
> > >  #define IMX_SC_R_DC_1_VIDEO0		45
> > >  #define IMX_SC_R_DC_1_VIDEO1		46
> > >  #define IMX_SC_R_DC_1_FRAC0		47
> > > -#define IMX_SC_R_DC_1_FRAC1		48
> > > +#define IMX_SC_R_UNUSED13		48
> > >  #define IMX_SC_R_DC_1			49
> > > -#define IMX_SC_R_GPU_3_PID0		50
> > > +#define IMX_SC_R_UNUSED14		50
> > >  #define IMX_SC_R_DC_1_PLL_0		51
> > >  #define IMX_SC_R_DC_1_PLL_1		52
> > >  #define IMX_SC_R_SPI_0			53
> > > @@ -303,8 +303,8 @@
> > >  #define IMX_SC_R_M4_0_UART		287
> > >  #define IMX_SC_R_M4_0_I2C		288
> > >  #define IMX_SC_R_M4_0_INTMUX		289
> > > -#define IMX_SC_R_M4_0_SIM		290
> > > -#define IMX_SC_R_M4_0_WDOG		291
> > > +#define IMX_SC_R_UNUSED15		290
> > > +#define IMX_SC_R_UNUSED16		291
> > >  #define IMX_SC_R_M4_0_MU_0B		292
> > >  #define IMX_SC_R_M4_0_MU_0A0		293
> > >  #define IMX_SC_R_M4_0_MU_0A1		294
> > > @@ -323,8 +323,8 @@
> > >  #define IMX_SC_R_M4_1_UART		307
> > >  #define IMX_SC_R_M4_1_I2C		308
> > >  #define IMX_SC_R_M4_1_INTMUX		309
> > > -#define IMX_SC_R_M4_1_SIM		310
> > > -#define IMX_SC_R_M4_1_WDOG		311
> > > +#define IMX_SC_R_UNUSED17		310
> > > +#define IMX_SC_R_UNUSED18		311
> > >  #define IMX_SC_R_M4_1_MU_0B		312
> > >  #define IMX_SC_R_M4_1_MU_0A0		313
> > >  #define IMX_SC_R_M4_1_MU_0A1		314
> > > @@ -337,7 +337,7 @@
> > >  #define IMX_SC_R_IRQSTR_SCU2		321
> > >  #define IMX_SC_R_IRQSTR_DSP		322
> > >  #define IMX_SC_R_ELCDIF_PLL		323
> > > -#define IMX_SC_R_UNUSED6		324
> > > +#define IMX_SC_R_OCRAM			324
> > >  #define IMX_SC_R_AUDIO_PLL_0		325
> > >  #define IMX_SC_R_PI_0			326
> > >  #define IMX_SC_R_PI_0_PWM_0		327
> > > @@ -554,6 +554,11 @@
> > >  #define IMX_SC_R_VPU_MU_3		538
> > >  #define IMX_SC_R_VPU_ENC_1		539
> > >  #define IMX_SC_R_VPU			540
> > > -#define IMX_SC_R_LAST			541
> > > +#define IMX_SC_R_DMA_5_CH0		541
> > > +#define IMX_SC_R_DMA_5_CH1		542
> > > +#define IMX_SC_R_DMA_5_CH2		543
> > > +#define IMX_SC_R_DMA_5_CH3		544
> > > +#define IMX_SC_R_ATTESTATION		545
> > > +#define IMX_SC_R_LAST			546
> > >
> > >  #endif /* __DT_BINDINGS_RSCRC_IMX_H */
> > > --
> > > 2.7.4

