Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D13C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 03:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19612206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 03:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kGM6Uof3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfBWDT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 22:19:56 -0500
Received: from mail-eopbgr70050.outbound.protection.outlook.com ([40.107.7.50]:51808
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726693AbfBWDTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 22:19:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8n/CY8EpBQ7EKSLLqooCjNOPMC9N1BBkI2GVCMbXDU=;
 b=kGM6Uof33sUoSAXMnaQa1xARNxUkW2fowgf6/UVSMsG6TUTz3hRsKTrA0bUZ631PWd/jqx+JA7ojUOuE/BvZgRjFFh2KJfKbYOCYut6mKId47uygTu4hm8zmhlEjeKZCp+i1zgVsMidqEdVxUPmlxihEaMVlszNlXhjvbN/JO+M=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3659.eurprd04.prod.outlook.com (52.134.66.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Sat, 23 Feb 2019 03:19:37 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.016; Sat, 23 Feb 2019
 03:19:37 +0000
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
Subject: [PATCH V4 1/2] dt-bindings: imx: remove unused resources from scu
 resource table
Thread-Topic: [PATCH V4 1/2] dt-bindings: imx: remove unused resources from
 scu resource table
Thread-Index: AQHUyyabNa6yXj+Xik+em+PrjLHzmQ==
Date:   Sat, 23 Feb 2019 03:19:37 +0000
Message-ID: <1550891655-29043-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:202:2e::27) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5de7e9d-a5f8-4def-03d1-08d6993dbd70
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3659;
x-ms-traffictypediagnostic: DB3PR0402MB3659:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3659;23:2lz7xHHYNxIXA3G/NJuQZy1QVaRsd/LGfAdi9?=
 =?iso-8859-1?Q?qyFSCRHu4xNJmVlOM1P/4bCP2LJ0Zs8m5PvaGZFztVZmpr3yE7kvWPW0ME?=
 =?iso-8859-1?Q?B4RrUS07WXOsua/0Blj3rrVpDK/ZUovf205dUoB/E+hTtgepkcg/1iLF7l?=
 =?iso-8859-1?Q?7Tg9JorIJUh6vRTLMZD7+ql3YMyejpEDZdxirEfbM4n7ebJavPcu2jtlhW?=
 =?iso-8859-1?Q?ixAz03fwzPZptE+gCUGiZtJXUcVdUNo73nlcL74PNEVO69xXhE9mgwr3b3?=
 =?iso-8859-1?Q?9g1QlWHg9XcJB4dv2PmgCcOohQ/mKsECzFMawVoRB/AUamFJwhfOQ8q9bd?=
 =?iso-8859-1?Q?yPWhVn+2YKj57R5SZHNnp3oTo6GV5pLf41qvZn6OMiXTblVXFsqNeuPusG?=
 =?iso-8859-1?Q?4d519ivbhIa7Fq2QnerGXpNxv8/DDA3tt7mQUKR1yE8CvxdXgJZReu8i1y?=
 =?iso-8859-1?Q?Szy/CtVIIrVfApQREmpoffcJHDuW4sK2ofE8U9MkVz8qmiUTxb+gFu74NI?=
 =?iso-8859-1?Q?IXjHo4hJzszqvoGXr7sSkf6Y3SlwIKuUy0zN03ZUz5eZzzQlJoZbEQxecq?=
 =?iso-8859-1?Q?MlvarCWw4JALDKT8iE8bnzTHGkY54JboZtLF0avEUzxYrC+NNQAs6ET7dS?=
 =?iso-8859-1?Q?xMHqhD5twdxrUZBFjLp1Xo7RnjFHh1+nWS0RoCZfTAojNzv4JYJJ2lx8Fn?=
 =?iso-8859-1?Q?4U6cTphhflSAjqpdk1zEkvw8ttPZ5wWUMOCtz78BCExaZCtRraCVsSd6m9?=
 =?iso-8859-1?Q?4k2eN6kk7DKNj3MDri1PxzoCpy8bGHqyHEL/+Zyvbb+WilYkuqa17Bkc5n?=
 =?iso-8859-1?Q?zzb+B4KwVVEa1XFRSoE5f2O0TRd9j0EBtaH3UJ+Cna6l7L+48cRY2FLPea?=
 =?iso-8859-1?Q?sbkyxy/YXL2U8dHUF1tv8GmQa8AjOqP/r6wc/+5vEFQ9FUECH/mBd70iOc?=
 =?iso-8859-1?Q?57Zc29FHMRG4+/9ylCpD8yrxPFZL9kvndUALDz/0J+p8XhbxK725AL/TRW?=
 =?iso-8859-1?Q?jYZ3Pe5YRksovslu+lhLvLpxTs6BSQrpa6/Dn/3CYPH/MoWQGQNpNVJTJZ?=
 =?iso-8859-1?Q?ZOzpG/Kp6NhgnYqikTdtBfXFqo1KHpjgS4d7IY/pP1zRfZ43sXKH+3FNQl?=
 =?iso-8859-1?Q?9wMch/4Z5zcUpHPQ11MdArcq26iCq8caCBSht0PbDPftGFeSbGFfjWlLFV?=
 =?iso-8859-1?Q?C+a1f0C3jxFe7evS6MRHHLD+1t5IXizfVTQSlHe1/+GfLbJA9UIt0S8IzR?=
 =?iso-8859-1?Q?LgXmb1i73r8PAv1jqCp?=
x-microsoft-antispam-prvs: <DB3PR0402MB3659B49969FED1156B7AE34DF5780@DB3PR0402MB3659.eurprd04.prod.outlook.com>
x-forefront-prvs: 0957AD37A0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(136003)(346002)(376002)(189003)(199004)(478600001)(14454004)(36756003)(99286004)(26005)(186003)(25786009)(53936002)(7736002)(50226002)(68736007)(86362001)(386003)(2201001)(6512007)(6506007)(2906002)(66066001)(4326008)(6436002)(106356001)(476003)(5660300002)(2501003)(2616005)(8676002)(102836004)(81166006)(8936002)(97736004)(7416002)(6116002)(81156014)(256004)(71200400001)(3846002)(486006)(110136005)(316002)(105586002)(71190400001)(52116002)(305945005)(6486002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3659;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aocsHCN+1Fdxy3KWKmoi8tTVpPROUVuz7weUax2SbiKw8rxDPWB0trin51+D7wJJk4q1+1fN7bfUStz7dGugwG9dXUI8CKdbhO2CoDViX9d2UVxaV9XITbRp08yLSq3oL0sDbty7bqnG2QQsv2j5LFQH40aoiLYokKhkH182nTappql2bWJuZr7WY8h6cWyUCeNgK+pT69pr5RQmYfUpc0PSfTGbHRu4Iu1hzCAErmAC1ZlKSxQSmfs7p2y6OsVou01CEEMQ7nX88You8N6OO/Aq2aZCb9zBs4caec6xZ875YWA0Zxr5kAXvCxNVbKHegwza7TyFYIl68GCZeWQ6faGHFjOrYscUJdHFouVAsGHhKV4TZYxFZWklSV3l9uOKoh/MqpOcJ0LWE4azs1gFiQADXMHguiZADYPIGBSGQT4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5de7e9d-a5f8-4def-03d1-08d6993dbd70
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2019 03:19:33.2297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3659
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
Changes since V3:
	- just remove those unused resource and no need to define UNUSED resource.
--
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

