Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07926C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6EEC20880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vU/YKAKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfBTOfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:35:08 -0500
Received: from mail-eopbgr30066.outbound.protection.outlook.com ([40.107.3.66]:58794
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbfBTOfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:35:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zp1Ncw+mkw5+0ufU0X1xy7MmWeh2ZhERDhLZN9jWt9k=;
 b=vU/YKAKN5+8HUtT+3QyHZyxPx5x3O9vr3dT1i0ZWNK/Z5Sd1v1/j4Ol/ZRTJvoYvaOvaKpOpYu6m0GgowhY7MKaAU6Ay5j/yteJwTQxIrphJrpb1l4Cnhew90d51wpzSpi/uNTYpPnZKE7aFeZOddFgMEYn5guET4czGG9fAjbs=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3900.eurprd04.prod.outlook.com (52.134.71.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Wed, 20 Feb 2019 14:35:02 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Wed, 20 Feb 2019
 14:35:02 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V3 1/2] dt-bindings: imx: remove unused resources from scu
 resource table
Thread-Topic: [PATCH V3 1/2] dt-bindings: imx: remove unused resources from
 scu resource table
Thread-Index: AQHUySl2KcBJ3pvbNEW4sCLjGjuECw==
Date:   Wed, 20 Feb 2019 14:35:02 +0000
Message-ID: <1550673029-15910-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0193.apcprd02.prod.outlook.com
 (2603:1096:201:21::29) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac26a274-2f81-4f4a-5307-08d6974098d8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3900;
x-ms-traffictypediagnostic: DB3PR0402MB3900:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3900;23:yPFWs/a8OR1E9TUQO0aLKqUwAmKHkeD1gWeCV?=
 =?iso-8859-1?Q?MkG66hGZONmXd/eK8Wr4H/mj7nqW/v+F/L4taxE8QD5hWJE/XQyLT/Y92M?=
 =?iso-8859-1?Q?Jxh4eNLjoSgJHxpoimS5ecC9uQS0cNA7xXYrlBKFnV23hsOfSOqLjNg8dy?=
 =?iso-8859-1?Q?pP2q0JtT+xcKgu8lsVBbDs8FQO+eb+oDLjAozZ/e4CkC5VXya/Iybqu5YP?=
 =?iso-8859-1?Q?METvyNt5xlmDVWcX3Ci6l/Z7JXqF0vtf8mwAp83sKgNXOK8cJN601Nchsb?=
 =?iso-8859-1?Q?f/eyuS0ELAOvQhx3e4aYjrJD8gBkX5PUP0bBepelMevhH0ff/H7v0gamdA?=
 =?iso-8859-1?Q?7IPR7dX2SYSeH87Ymh4I2tfOoedsPuW9FFNUaF8GsMR9YyGx2prZZWwDSW?=
 =?iso-8859-1?Q?eWQ0gTozSDRK+iDjsQKZy9KwiCEWKTUEtWOPDS8ZSYvqtEgSzoBZWvYsqb?=
 =?iso-8859-1?Q?3evlRcXMLzHHl/rL8/dV7EsoLOaFlLrJc6a/IzpNKb3ttVnjSbaUMfXUOD?=
 =?iso-8859-1?Q?xcURyk0+LR+EATtAeyR1cDzO2nq5ouHYronuuv8wlmOk6RtZbJ6s6c9j0E?=
 =?iso-8859-1?Q?kCBezOFCb6l2aW0ulUc9LhHV7K/IIv+LeLLlbdBZx0PL5iYerxtnmBbaC/?=
 =?iso-8859-1?Q?8wQ8bSE4f/ePCrV3iLoxm+wz8/Kn596h+yeSZVrNF26bNIV7wrpygC2V/k?=
 =?iso-8859-1?Q?T1Qj5iHHER5+G+qC1bzXZSoKaDBJN4Tx3IEDrHq7fWwdDdcnJfEPAazx84?=
 =?iso-8859-1?Q?npL04W30FNKi8YHZkgEIG7yZf/7o3UWuEl+4QsGD6TfGc6RWqFC6Uhh2x4?=
 =?iso-8859-1?Q?eiIQTwdxqWl1TXPU+gDyk6TOapCFh+H5JOGpVhALdfvtfYH+2/RHSn7pPf?=
 =?iso-8859-1?Q?rwlyOrhA/qhTszLMWzbqVhPuWTg/Vn7uZmBqMcpajvz8PG6n3RCp4fpRpJ?=
 =?iso-8859-1?Q?M3bZds0Za8PJnGG4jjO6asn5Tv6IT2YyMS3bVcT3M5buR5D89DOyP4HagD?=
 =?iso-8859-1?Q?Nmu1sVOuzX5z/79Rt7j+/0GiyaorTtJq1+3M47fAiyX4qnIc5zk/7st/0a?=
 =?iso-8859-1?Q?iavfSTFxn7GVHCVu8N3jrsvzOsZq5itdGhDbb5p3SD3T5BauG8ON0QR342?=
 =?iso-8859-1?Q?yMe12ob9EBYAg8qu9xf6nDC7uXT0WKNxTqZDTReZ2RHH+r2//AE2hoPVol?=
 =?iso-8859-1?Q?k4GCVUd2qkWV7wTOza9th5Zv2mRxlqVDmho24dnNxGv1WoH1SCAboC92XN?=
 =?iso-8859-1?Q?u/0pApC694BnR3ZPenI?=
x-microsoft-antispam-prvs: <DB3PR0402MB39002AF024D603C6B26201F5F57D0@DB3PR0402MB3900.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(366004)(376002)(346002)(189003)(199004)(478600001)(6436002)(6512007)(106356001)(81166006)(53936002)(105586002)(7736002)(2501003)(110136005)(305945005)(2201001)(97736004)(50226002)(8936002)(8676002)(81156014)(6486002)(14454004)(5660300002)(486006)(476003)(2616005)(68736007)(86362001)(3846002)(71200400001)(71190400001)(6116002)(2906002)(102836004)(256004)(36756003)(316002)(6506007)(386003)(52116002)(99286004)(4326008)(26005)(186003)(25786009)(66066001)(7416002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3900;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hKHoLd10rwzeOlyTta/ptUH38hFSi4fvwLJ5iRa3w/kLz42R6NaVQefCCAvjVT4pXsQYroEDqKJTqMaW4Kb2jUaURsrIsCusUUQTaLEwAI4kl62OJRp94SoFqXeC8GRSzAGqHSGq/enMjztXr6Tf1o7+Sxn52NrgpDMDHLzaVQ4sw6Wj5bjs4w8khccEBX9IIeZHcaroVGqnhoELv3T/12YX/baFFXP3FWlFmQwr3aMRWyktRX5ME9C4duqKievkzvswB8XppweKa/2ruQWUBdzorLlB2uvA9vf/ax0p5Yji+LZCoVdqOtvLejeLF/56OgAWCD2PXdgJnv0pQGsbN5Y724Uqy/gk11ztLWdZRvj3LyMS1VDYkDzGJqITW979lTSONUU3LuK+sU/SAbMp5QnXLLtrQu//Gyx828duWpk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac26a274-2f81-4f4a-5307-08d6974098d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 14:34:57.9470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3900
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
---
No changes since V2, just separate the patch to 2, 1 patch to remove resour=
ces and the other is to add new
resources.
---
 include/dt-bindings/firmware/imx/rsrc.h | 30 +++++++++++++++--------------=
-
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/dt-bindings/firmware/imx/rsrc.h b/include/dt-bindings/=
firmware/imx/rsrc.h
index 4481f2d..32cce37 100644
--- a/include/dt-bindings/firmware/imx/rsrc.h
+++ b/include/dt-bindings/firmware/imx/rsrc.h
@@ -36,15 +36,15 @@
 #define IMX_SC_R_DC_0_BLIT1		20
 #define IMX_SC_R_DC_0_BLIT2		21
 #define IMX_SC_R_DC_0_BLIT_OUT		22
-#define IMX_SC_R_DC_0_CAPTURE0		23
-#define IMX_SC_R_DC_0_CAPTURE1		24
+#define IMX_SC_R_UNUSED19		23
+#define IMX_SC_R_UNUSED5		24
 #define IMX_SC_R_DC_0_WARP		25
-#define IMX_SC_R_DC_0_INTEGRAL0		26
-#define IMX_SC_R_DC_0_INTEGRAL1		27
+#define IMX_SC_R_UNUSED7		26
+#define IMX_SC_R_UNUSED8		27
 #define IMX_SC_R_DC_0_VIDEO0		28
 #define IMX_SC_R_DC_0_VIDEO1		29
 #define IMX_SC_R_DC_0_FRAC0		30
-#define IMX_SC_R_DC_0_FRAC1		31
+#define IMX_SC_R_UNUSED20		31
 #define IMX_SC_R_DC_0			32
 #define IMX_SC_R_GPU_2_PID0		33
 #define IMX_SC_R_DC_0_PLL_0		34
@@ -53,17 +53,17 @@
 #define IMX_SC_R_DC_1_BLIT1		37
 #define IMX_SC_R_DC_1_BLIT2		38
 #define IMX_SC_R_DC_1_BLIT_OUT		39
-#define IMX_SC_R_DC_1_CAPTURE0		40
-#define IMX_SC_R_DC_1_CAPTURE1		41
+#define IMX_SC_R_UNUSED9		40
+#define IMX_SC_R_UNUSED10		41
 #define IMX_SC_R_DC_1_WARP		42
-#define IMX_SC_R_DC_1_INTEGRAL0		43
-#define IMX_SC_R_DC_1_INTEGRAL1		44
+#define IMX_SC_R_UNUSED11		43
+#define IMX_SC_R_UNUSED12		44
 #define IMX_SC_R_DC_1_VIDEO0		45
 #define IMX_SC_R_DC_1_VIDEO1		46
 #define IMX_SC_R_DC_1_FRAC0		47
-#define IMX_SC_R_DC_1_FRAC1		48
+#define IMX_SC_R_UNUSED13		48
 #define IMX_SC_R_DC_1			49
-#define IMX_SC_R_GPU_3_PID0		50
+#define IMX_SC_R_UNUSED14		50
 #define IMX_SC_R_DC_1_PLL_0		51
 #define IMX_SC_R_DC_1_PLL_1		52
 #define IMX_SC_R_SPI_0			53
@@ -303,8 +303,8 @@
 #define IMX_SC_R_M4_0_UART		287
 #define IMX_SC_R_M4_0_I2C		288
 #define IMX_SC_R_M4_0_INTMUX		289
-#define IMX_SC_R_M4_0_SIM		290
-#define IMX_SC_R_M4_0_WDOG		291
+#define IMX_SC_R_UNUSED15		290
+#define IMX_SC_R_UNUSED16		291
 #define IMX_SC_R_M4_0_MU_0B		292
 #define IMX_SC_R_M4_0_MU_0A0		293
 #define IMX_SC_R_M4_0_MU_0A1		294
@@ -323,8 +323,8 @@
 #define IMX_SC_R_M4_1_UART		307
 #define IMX_SC_R_M4_1_I2C		308
 #define IMX_SC_R_M4_1_INTMUX		309
-#define IMX_SC_R_M4_1_SIM		310
-#define IMX_SC_R_M4_1_WDOG		311
+#define IMX_SC_R_UNUSED17		310
+#define IMX_SC_R_UNUSED18		311
 #define IMX_SC_R_M4_1_MU_0B		312
 #define IMX_SC_R_M4_1_MU_0A0		313
 #define IMX_SC_R_M4_1_MU_0A1		314
--=20
2.7.4

