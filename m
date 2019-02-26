Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E982EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A153D217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JChRC81H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfBZMGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:06:41 -0500
Received: from mail-eopbgr00057.outbound.protection.outlook.com ([40.107.0.57]:51629
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726576AbfBZMGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:06:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zc8Ql06AobFqiMbgo1afOGRQem95XHCnz7ED1GNv6Eg=;
 b=JChRC81HyG1FNKE1Vkw8GEr4gxbd171DK/eSVtJVriaqc5W/lQLMv/eBty3rg5e9k3t5UvPBo8p0SKaxokq82Z5SGuetA1tTEamejhx90JKjLEj3lL5kx1QzBI+Z5qcbvhqSLOJc5qkJ+8/QrXRf3S+4bU4m522AbUOud9BEoEs=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (52.134.31.21) by
 VI1PR04MB4991.eurprd04.prod.outlook.com (20.177.49.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Tue, 26 Feb 2019 12:06:31 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d%6]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 12:06:31 +0000
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
Subject: RE: [PATCH V4 1/2] dt-bindings: imx: remove unused resources from scu
 resource table
Thread-Topic: [PATCH V4 1/2] dt-bindings: imx: remove unused resources from
 scu resource table
Thread-Index: AQHUyyabNa6yXj+Xik+em+PrjLHzmaXx/6bAgAABHVA=
Date:   Tue, 26 Feb 2019 12:06:31 +0000
Message-ID: <VI1PR04MB422268F2EB954DA0DCF15442807B0@VI1PR04MB4222.eurprd04.prod.outlook.com>
References: <1550891655-29043-1-git-send-email-Anson.Huang@nxp.com>
 <VI1PR04MB42224740E322E5792426DAAB807B0@VI1PR04MB4222.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB42224740E322E5792426DAAB807B0@VI1PR04MB4222.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b685a3d6-b2be-45c0-242b-08d69be2d894
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4991;
x-ms-traffictypediagnostic: VI1PR04MB4991:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR04MB4991;23:rmb+6R3v675t6fxFjfK6/ala1aXg2UxCaEd4dbjua?=
 =?us-ascii?Q?O8/LTwRKrJa6B+67LS5pKQsOTBWxzuy/BCrSHO9X+HOl5zd1H9EwmNH9xGh6?=
 =?us-ascii?Q?yAQeuoChEIBKtrwFHge84Qqzb4Pwsddl9oNHUelDFIC2UNZACpgJw9M2YXJ5?=
 =?us-ascii?Q?Yg5K2pNqpXUStJE4S2N5vjJNfmugemKt/bbFRz58E13ELusQiEcv2tHRB1wC?=
 =?us-ascii?Q?AINEoPqIy9y3Ppi2dvxNW+K+fj1gF3kmiqMniZ6noIfloQspX3k6lWPE4IPn?=
 =?us-ascii?Q?2M37pSj8qHn6+QjgwOUjrO7ds3oP1Nb+9/LXliStfjU64jVvg79OLUgxVZIE?=
 =?us-ascii?Q?IJUIqVF70gEP/IL9eKRZI7UWo1bCbFzZgimHtIJa5vmnRCbz/sn/r7ww314W?=
 =?us-ascii?Q?3K9RPElRL9ZVEHemhCaDvkPN7oANrJI+FsSIO9H4a0CcbbbdtBnrnX1LRj83?=
 =?us-ascii?Q?U2Z43XEtEwfZjjsZ/EgZPlnojC8w5zG9zbTlHQ00kuAtNbZk/9fw1VqZhFO7?=
 =?us-ascii?Q?pfP7dYSUihyYlCktJJFFj1UglqKaIqKa+7X6n0BtxTr49RdHiKshAP1t6niI?=
 =?us-ascii?Q?uyTC+rryRZl+WTjPngHaLmmN6cAkNXUga0bFklKR/PSyi0T/fUHuE8gtLYbm?=
 =?us-ascii?Q?QkEm0VnVD0eI4LrAacLtFdZtSQZhULTOlNGIsQQ7oEfCiC6YiUDB9NWQfqtf?=
 =?us-ascii?Q?/PUoMF8LdPeemOMvnhKRdbmW6qKiHSQzFn1f6jm8MB9qSx5QgrjN2/WyxWrW?=
 =?us-ascii?Q?P8S+UYrpCOZ2BRWOC5S62MO+R3Bpxl0+VQoOvorOHJ0eNhTnCBmUWHXnx8Hh?=
 =?us-ascii?Q?AnMongFv4+dULldw/+FhFZ3k+k3ReRkcQU3HD1ne3OzI1FfNMRQtHKHYVcdU?=
 =?us-ascii?Q?sJmhCEjsUJBODpPf58ji2tQVCtq7OF2rUywLdbvrAfM6U0eS5Oq6/ZUAQPsf?=
 =?us-ascii?Q?+KDPTfxBxiqc2xCvPBVIdA+QoUVYtc10oIUx2Jt/HcV6vPj4HOyXKrKjG8n/?=
 =?us-ascii?Q?ynlb+0wvXNEL3SR95pJMjsU0sySQ3zjy2tQRGKEl7k5o5OjpDz/QUeH1F0zo?=
 =?us-ascii?Q?EfbTYrWW/Wt7QMO+R7s9vcDHsVZ48/zVilWz8neQLjx5xUNhOILCl5uMOjbd?=
 =?us-ascii?Q?ZXLMuLP2mv6iV13w/ejvi6r9oULvMgf2WtUh7pgt7yBZRi53RjAxTFIfhO8B?=
 =?us-ascii?Q?YTjll8nGbHVv69XjBYMjuy/IeE6mRtIhuu3kCBLkluzlRzxkTed0W6oIc1wE?=
 =?us-ascii?Q?c1KQhr0SEhYZWz56s5itYDV/Qgl324d5aGzij9jVNIZLDL34ck77U4/7yzpW?=
 =?us-ascii?Q?BHJfO3tjCdAJnxjS2AA7WuGMr34kiGUPXD87g46+l53UQLH4VfScAnCte4yg?=
 =?us-ascii?Q?DOUUGGzGZyQP6p67PQ9YiwC5uWR6oL6Pfe0Oyb5UzBgjwBskY31sTYH3AqVI?=
 =?us-ascii?Q?m577zGqnTP3W6aFSC/MNakCvINyZ2ZNgVe9BMGvS5E/iOWMgwXw9sUhvtLSd?=
 =?us-ascii?Q?ImsVDqTG8b7/g=3D=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB4991EB718421AA637EBA0979807B0@VI1PR04MB4991.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(396003)(366004)(136003)(39860400002)(346002)(376002)(189003)(199004)(97736004)(55016002)(2501003)(9686003)(14444005)(5660300002)(71200400001)(71190400001)(6246003)(74316002)(6436002)(106356001)(105586002)(4326008)(7416002)(186003)(14454004)(478600001)(53936002)(8936002)(25786009)(26005)(6116002)(3846002)(99286004)(7696005)(81156014)(81166006)(2906002)(8676002)(68736007)(256004)(102836004)(6506007)(6346003)(229853002)(93156006)(446003)(7736002)(33656002)(52536013)(2940100002)(305945005)(110136005)(86362001)(2201001)(44832011)(11346002)(76176011)(66066001)(476003)(486006)(316002)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4991;H:VI1PR04MB4222.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TjdQXtwWFCk+pieovjlYrC7C39NPSmE19nakG4SFqAAb1jvTT+rT1BGl1pt71NcqCO2CF1NQ+UV7zG9PiaxoNLxfNGlFwnNlP2uZtprkV6dZq27utKOO7UbGu9kynLe5BP9s4XGbn7Zv6iAd69kMeB9MzUmpeHy2FIfMWNWPePnyz7HfiqMKY31S8QymgZV8GRWKcyDEFF5UIfvX4pkIaEIEKVSX16d1BiQwDsHTiM25e3JJ4lvUpXNzmfd34mXHuFthqFd8BkQCbleJwvwBUndRf1cqwGHz3WzhDCgzOeoTU/aZ4jdONxyFWP6/7TLpDfSVGZ5tGexr66CkoD5Sz6yHk5eShY0irfKe4dtyeADejYNSZBT29/SkUpWveFN1vMqITYhlmb1c8W4DLhnQnGwG/CYQQ21OBMiZXjKJ7Y0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b685a3d6-b2be-45c0-242b-08d69be2d894
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 12:06:31.6734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4991
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Subject: [PATCH V4 1/2] dt-bindings: imx: remove unused resources from
> > scu resource table
> >
> > Removes below resources which were defined during pre-silicon phase
> > and the real silicons do NOT have them, they have never been used,
> > latest system controller firmware also removed them:
> >
> > 	IMX_SC_R_DC_0_CAPTURE0
> > 	IMX_SC_R_DC_0_CAPTURE1
> > 	IMX_SC_R_DC_0_INTEGRAL0
> > 	IMX_SC_R_DC_0_INTEGRAL1
> > 	IMX_SC_R_DC_0_FRAC1
> > 	IMX_SC_R_DC_1_CAPTURE0
> > 	IMX_SC_R_DC_1_CAPTURE1
> > 	IMX_SC_R_DC_1_INTEGRAL0
> > 	IMX_SC_R_DC_1_INTEGRAL1
> > 	IMX_SC_R_DC_1_FRAC1
> > 	IMX_SC_R_GPU_3_PID0
> > 	IMX_SC_R_M4_0_SIM
> > 	IMX_SC_R_M4_0_WDOG
> > 	IMX_SC_R_M4_1_SIM
> > 	IMX_SC_R_M4_1_WDOG
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>=20
> There're gaps left after removing, but I can't see it's actually a proble=
m.
> So:
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
>=20

Sorry, missed to comment that please update the patch title:
dt-bindings: firmware: imx-scu: xxxx

Regards
Dong Aisheng

> Regards
> Dong Aisheng
>=20
> > ---
> > Changes since V3:
> > 	- just remove those unused resource and no need to define UNUSED
> > resource.
> > --
> >  include/dt-bindings/firmware/imx/rsrc.h | 15 ---------------
> >  1 file changed, 15 deletions(-)
> >
> > diff --git a/include/dt-bindings/firmware/imx/rsrc.h
> > b/include/dt-bindings/firmware/imx/rsrc.h
> > index 4481f2d..d69f934 100644
> > --- a/include/dt-bindings/firmware/imx/rsrc.h
> > +++ b/include/dt-bindings/firmware/imx/rsrc.h
> > @@ -36,15 +36,10 @@
> >  #define IMX_SC_R_DC_0_BLIT1		20
> >  #define IMX_SC_R_DC_0_BLIT2		21
> >  #define IMX_SC_R_DC_0_BLIT_OUT		22
> > -#define IMX_SC_R_DC_0_CAPTURE0		23
> > -#define IMX_SC_R_DC_0_CAPTURE1		24
> >  #define IMX_SC_R_DC_0_WARP		25
> > -#define IMX_SC_R_DC_0_INTEGRAL0		26
> > -#define IMX_SC_R_DC_0_INTEGRAL1		27
> >  #define IMX_SC_R_DC_0_VIDEO0		28
> >  #define IMX_SC_R_DC_0_VIDEO1		29
> >  #define IMX_SC_R_DC_0_FRAC0		30
> > -#define IMX_SC_R_DC_0_FRAC1		31
> >  #define IMX_SC_R_DC_0			32
> >  #define IMX_SC_R_GPU_2_PID0		33
> >  #define IMX_SC_R_DC_0_PLL_0		34
> > @@ -53,17 +48,11 @@
> >  #define IMX_SC_R_DC_1_BLIT1		37
> >  #define IMX_SC_R_DC_1_BLIT2		38
> >  #define IMX_SC_R_DC_1_BLIT_OUT		39
> > -#define IMX_SC_R_DC_1_CAPTURE0		40
> > -#define IMX_SC_R_DC_1_CAPTURE1		41
> >  #define IMX_SC_R_DC_1_WARP		42
> > -#define IMX_SC_R_DC_1_INTEGRAL0		43
> > -#define IMX_SC_R_DC_1_INTEGRAL1		44
> >  #define IMX_SC_R_DC_1_VIDEO0		45
> >  #define IMX_SC_R_DC_1_VIDEO1		46
> >  #define IMX_SC_R_DC_1_FRAC0		47
> > -#define IMX_SC_R_DC_1_FRAC1		48
> >  #define IMX_SC_R_DC_1			49
> > -#define IMX_SC_R_GPU_3_PID0		50
> >  #define IMX_SC_R_DC_1_PLL_0		51
> >  #define IMX_SC_R_DC_1_PLL_1		52
> >  #define IMX_SC_R_SPI_0			53
> > @@ -303,8 +292,6 @@
> >  #define IMX_SC_R_M4_0_UART		287
> >  #define IMX_SC_R_M4_0_I2C		288
> >  #define IMX_SC_R_M4_0_INTMUX		289
> > -#define IMX_SC_R_M4_0_SIM		290
> > -#define IMX_SC_R_M4_0_WDOG		291
> >  #define IMX_SC_R_M4_0_MU_0B		292
> >  #define IMX_SC_R_M4_0_MU_0A0		293
> >  #define IMX_SC_R_M4_0_MU_0A1		294
> > @@ -323,8 +310,6 @@
> >  #define IMX_SC_R_M4_1_UART		307
> >  #define IMX_SC_R_M4_1_I2C		308
> >  #define IMX_SC_R_M4_1_INTMUX		309
> > -#define IMX_SC_R_M4_1_SIM		310
> > -#define IMX_SC_R_M4_1_WDOG		311
> >  #define IMX_SC_R_M4_1_MU_0B		312
> >  #define IMX_SC_R_M4_1_MU_0A0		313
> >  #define IMX_SC_R_M4_1_MU_0A1		314
> > --
> > 2.7.4

