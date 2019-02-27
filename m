Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A0EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76EA4218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ISZZC37u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbfB0Axs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 19:53:48 -0500
Received: from mail-eopbgr50043.outbound.protection.outlook.com ([40.107.5.43]:6792
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729035AbfB0Axs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 19:53:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LN1HBb6ArK5wzNqz37ecdtH3msbt9mbyUFdpavcakco=;
 b=ISZZC37u9O517WQdPoZo0c9TF30icLwb4aLzK2iBPghdsvykj0edhI2RkjXTHO67YN8kNYUQgKx9MvKRiqCysDcNDFE8vTJ9+Ofxm/1q/exLtNOfL+cT5DBpN8MRPsGfcmEX8du0CxAhqR6yg/f87InowXwlJZyDdGvCVCxuvJk=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3771.eurprd04.prod.outlook.com (52.134.67.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.20; Wed, 27 Feb 2019 00:53:04 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Wed, 27 Feb 2019
 00:53:04 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH RESEND V4 1/2] dt-bindings: firmware: imx-scu: remove unused
 resources from scu resource table
Thread-Topic: [PATCH RESEND V4 1/2] dt-bindings: firmware: imx-scu: remove
 unused resources from scu resource table
Thread-Index: AQHUzjbLosGXq4bHDEGIwgGx+GRRZw==
Date:   Wed, 27 Feb 2019 00:53:04 +0000
Message-ID: <1551228502-1535-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0183.apcprd02.prod.outlook.com
 (2603:1096:201:21::19) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46d8a5fa-e1d3-4c2d-2831-08d69c4dee27
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3771;
x-ms-traffictypediagnostic: DB3PR0402MB3771:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3771;23:j0eSACaKL0fo5Nuai+Cu1QbPTTP5AaQvvgv8v?=
 =?iso-8859-1?Q?DGukEe3FZzl0X349MDqPIiQxwpGR8G1VeoO+JIYfwNbjLH7/gy/UPZgB1z?=
 =?iso-8859-1?Q?HkWOTnuvTFbkPixAUfmhiJ2H/QFGhVE8G7oquq4n367WdYZVx4KvxSBqPE?=
 =?iso-8859-1?Q?rNla+Rd9Kjz1xnBYmiPz0dweWlt3evp9D0b920yK5OkaNGiAbDC2DZBhNe?=
 =?iso-8859-1?Q?Ji7MuOOT/8w+CtAzzbBWy97ra9pdby9S7knvX0nPv+DVFiEE4imM43z/EM?=
 =?iso-8859-1?Q?8nrElPP0qph4tXOMZjmbPnGUGrPZltf3XF8a5URDtcUCtCzu/PFPWxiyIz?=
 =?iso-8859-1?Q?7f5CUVvdwvSkf2sILMwaV5WS5Hl7B0ElYo3mJU+QHYLic4rQozLM6q2Pup?=
 =?iso-8859-1?Q?2LLdUivjo0LJaLB7J6CplX+TgWy3aEuvkQWVIoRJEluh/pg4VNgtmgahbK?=
 =?iso-8859-1?Q?N+YTOOTAfk+iqi5NzDQgqKYbbxywWbXJz9BngtdL3AVWcnPTmCraPSfts8?=
 =?iso-8859-1?Q?mkUgTtVosZ8zrGXZRIxiof2qc5EoK+o7p2JqPMD74imLhNQ2JHMxUHtDgi?=
 =?iso-8859-1?Q?F9mmIBq1D1ydHPwWEA+8mwVX7/KWIDDp6iWpEmYsofO9Dwk/UvSs72lYI1?=
 =?iso-8859-1?Q?gg6TWpQeYqglK+MunPzhZYA9TXDKSNn/V3qpCiH+PRhuGgxe1+6R075Uid?=
 =?iso-8859-1?Q?AbtRwGM3Whs2gSV1qZqD6MdHGpuj03/JkYKz0bydwIdIsOvpMBU6EjBo7J?=
 =?iso-8859-1?Q?jGZkedOVkT9Fcqamu78Wm6Nv0O5q87N8Ec9Y2NriP5whs/+wRKCwzFHmoD?=
 =?iso-8859-1?Q?rSOGZ/7JSgK2bvVcLfJNhGUcBOzKUOXDKpbGeU/l8rAnPnBDcMAzofxKGX?=
 =?iso-8859-1?Q?FZR1e1yQmQ/NWxzvIBLR+7mMJ0Pc8BL2q0rFVY+NaLA+5vJq9b2izV2ykJ?=
 =?iso-8859-1?Q?0aj9xNjLa0uEJYAcv35GuVc09SFcw08fBiRsk0z8/u4NtPf6BAcXCt38Oi?=
 =?iso-8859-1?Q?KVRavXRo4nRJ5jz2AULGu0SkzpbRRfe4W3BSbnanS3+4BDV5camCG258EG?=
 =?iso-8859-1?Q?GFx0oOTUjP7iTFRPEhask6lolQyeNeUwTOe0Al4mqKDosBXzTQI2TJ+qve?=
 =?iso-8859-1?Q?lPxdopVYpvJYAweaxbv4pIDxh1tJRVWId/tIXXMLglNRqUW2NJiN0+yZ0v?=
 =?iso-8859-1?Q?A0t8qynyAN3njrCq9ZvSpQmLC4zugEEyjI6rsqNAx9gvtlAPByzPduVPzF?=
 =?iso-8859-1?Q?xT/l7MVa/bL5tN2HKxX?=
x-microsoft-antispam-prvs: <DB3PR0402MB37715572455CE26D715023BAF5740@DB3PR0402MB3771.eurprd04.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(376002)(136003)(346002)(189003)(199004)(102836004)(316002)(110136005)(71200400001)(71190400001)(68736007)(386003)(478600001)(256004)(6506007)(6116002)(3846002)(99286004)(6436002)(6486002)(66066001)(6512007)(52116002)(2906002)(105586002)(106356001)(97736004)(7416002)(186003)(2501003)(25786009)(476003)(26005)(2616005)(486006)(53936002)(4326008)(36756003)(14454004)(5660300002)(8936002)(86362001)(305945005)(2201001)(50226002)(7736002)(81156014)(81166006)(8676002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3771;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Six/iDtzsM+RHuUpy2aco7+sbB6VTnueFkEifun6HAuIzuejxEN3M2pVisD9LSZblGVJAmsy+X4GSeQl5OyDIJWuJjlWDAeLcP0Ac0ghYB8/cBF+F3loauUXxS2zFlBSa/cY7hslJUpvUgWO/CTD+lJYY+CebZUOPukNbwEvCP37Iq8FVR2kYTICinGXVtkYUp+fvmE1ONW0yp0vNXRLnTnxaaVGeV+0+cf3kUhtMaU4TSzqXg2JscA9gNpgCP1j1ccHyDpzKelt+Hk3PUPoVyBEra53hKFa+WVsGZ96dxkD36Rouce43Ql+8CQ1jts00xeYmg2fgBCX/HAZTww9YvNcRW6tjg9buVzsmOLpabMgxCCTA0bcuAeuRbGnDNlsty0Ir5gTBIz9tZxXJtla5ii9wG+rxCWGX/DDQKKlOrc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d8a5fa-e1d3-4c2d-2831-08d69c4dee27
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 00:53:00.3705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3771
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes below resources which were defined during
pre-silicon phase and the real silicons do NOT have
them, they have never been used, latest system
controller firmware also removed them:

	IMX_SC_R_DC_0_CAPTURE0
	IMX_SC_R_DC_0_CAPTURE1
	IMX_SC_R_DC_0_INTEGRAL0
	IMX_SC_R_DC_0_INTEGRAL1
	IMX_SC_R_DC_0_FRAC1
	IMX_SC_R_DC_1_CAPTURE0
	IMX_SC_R_DC_1_CAPTURE1
	IMX_SC_R_DC_1_INTEGRAL0
	IMX_SC_R_DC_1_INTEGRAL1
	IMX_SC_R_DC_1_FRAC1
	IMX_SC_R_GPU_3_PID0
	IMX_SC_R_M4_0_SIM
	IMX_SC_R_M4_0_WDOG
	IMX_SC_R_M4_1_SIM
	IMX_SC_R_M4_1_WDOG

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 include/dt-bindings/firmware/imx/rsrc.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/include/dt-bindings/firmware/imx/rsrc.h b/include/dt-bindings/=
firmware/imx/rsrc.h
index 4481f2d..d69f934 100644
--- a/include/dt-bindings/firmware/imx/rsrc.h
+++ b/include/dt-bindings/firmware/imx/rsrc.h
@@ -36,15 +36,10 @@
 #define IMX_SC_R_DC_0_BLIT1		20
 #define IMX_SC_R_DC_0_BLIT2		21
 #define IMX_SC_R_DC_0_BLIT_OUT		22
-#define IMX_SC_R_DC_0_CAPTURE0		23
-#define IMX_SC_R_DC_0_CAPTURE1		24
 #define IMX_SC_R_DC_0_WARP		25
-#define IMX_SC_R_DC_0_INTEGRAL0		26
-#define IMX_SC_R_DC_0_INTEGRAL1		27
 #define IMX_SC_R_DC_0_VIDEO0		28
 #define IMX_SC_R_DC_0_VIDEO1		29
 #define IMX_SC_R_DC_0_FRAC0		30
-#define IMX_SC_R_DC_0_FRAC1		31
 #define IMX_SC_R_DC_0			32
 #define IMX_SC_R_GPU_2_PID0		33
 #define IMX_SC_R_DC_0_PLL_0		34
@@ -53,17 +48,11 @@
 #define IMX_SC_R_DC_1_BLIT1		37
 #define IMX_SC_R_DC_1_BLIT2		38
 #define IMX_SC_R_DC_1_BLIT_OUT		39
-#define IMX_SC_R_DC_1_CAPTURE0		40
-#define IMX_SC_R_DC_1_CAPTURE1		41
 #define IMX_SC_R_DC_1_WARP		42
-#define IMX_SC_R_DC_1_INTEGRAL0		43
-#define IMX_SC_R_DC_1_INTEGRAL1		44
 #define IMX_SC_R_DC_1_VIDEO0		45
 #define IMX_SC_R_DC_1_VIDEO1		46
 #define IMX_SC_R_DC_1_FRAC0		47
-#define IMX_SC_R_DC_1_FRAC1		48
 #define IMX_SC_R_DC_1			49
-#define IMX_SC_R_GPU_3_PID0		50
 #define IMX_SC_R_DC_1_PLL_0		51
 #define IMX_SC_R_DC_1_PLL_1		52
 #define IMX_SC_R_SPI_0			53
@@ -303,8 +292,6 @@
 #define IMX_SC_R_M4_0_UART		287
 #define IMX_SC_R_M4_0_I2C		288
 #define IMX_SC_R_M4_0_INTMUX		289
-#define IMX_SC_R_M4_0_SIM		290
-#define IMX_SC_R_M4_0_WDOG		291
 #define IMX_SC_R_M4_0_MU_0B		292
 #define IMX_SC_R_M4_0_MU_0A0		293
 #define IMX_SC_R_M4_0_MU_0A1		294
@@ -323,8 +310,6 @@
 #define IMX_SC_R_M4_1_UART		307
 #define IMX_SC_R_M4_1_I2C		308
 #define IMX_SC_R_M4_1_INTMUX		309
-#define IMX_SC_R_M4_1_SIM		310
-#define IMX_SC_R_M4_1_WDOG		311
 #define IMX_SC_R_M4_1_MU_0B		312
 #define IMX_SC_R_M4_1_MU_0A0		313
 #define IMX_SC_R_M4_1_MU_0A1		314
--=20
2.7.4

