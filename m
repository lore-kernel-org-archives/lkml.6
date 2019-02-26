Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE79C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493C2217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aNUCUa8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbfBZMCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:02:48 -0500
Received: from mail-eopbgr140059.outbound.protection.outlook.com ([40.107.14.59]:12558
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726397AbfBZMCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:02:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVw2U8aqxU4gYnwrLjAHeNEuc7i/ndaEa5OeEZZk+Ng=;
 b=aNUCUa8CKhsvnhzsY8h012Uei2sJ/sIdbbDAbMpzchM9yOvoX3DDOslKWIzTnxjUphxNSCBX/BsFQowkB0Y9fU1fNRgV0g7z7qMiI0F9LckgM3xwph8I+52ltsin73KWsjpM0MXFY8otm8rrtjkTq0ZkrtRFxQPE0yvlsJS4mkA=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (52.134.31.21) by
 VI1PR04MB5775.eurprd04.prod.outlook.com (20.178.127.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Tue, 26 Feb 2019 12:02:41 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d%6]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 12:02:41 +0000
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
Thread-Index: AQHUyyabNa6yXj+Xik+em+PrjLHzmaXx/6bA
Date:   Tue, 26 Feb 2019 12:02:41 +0000
Message-ID: <VI1PR04MB42224740E322E5792426DAAB807B0@VI1PR04MB4222.eurprd04.prod.outlook.com>
References: <1550891655-29043-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550891655-29043-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9977b896-3737-4cce-08c6-08d69be24f96
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5775;
x-ms-traffictypediagnostic: VI1PR04MB5775:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR04MB5775;23:3yRjU4POZ9pNKFLgE8ctfgeuiOFFT4mYy2exZHkDa?=
 =?us-ascii?Q?QYw/MCFuAlZ8CCRwsK2g4lpiHG5secK8d+V/AmwKabPg43h5u5RofD1Bujnc?=
 =?us-ascii?Q?2rId914R47m5TyVlkUCQfWlvMvPFoBk1BiIVSI2lNKQSumGxPDjQGyyDsppS?=
 =?us-ascii?Q?EBbywB0UaxK/UkFNa8PCSAKl/aGrHJKqrKBoP3vCvdBeA4+OXt5ueIJpzrMR?=
 =?us-ascii?Q?fHoay9hxuZDHeh4iT/0RkRedoiiTbYw8BVFj8GjjAPg/ztlA8jRcKLxB3MVJ?=
 =?us-ascii?Q?DNVTiGu5z0eklg6H5Ky1Qc6hEZR631bTA5IbOl8OM5FBRgMfnGbQamP1/EX8?=
 =?us-ascii?Q?Cpbk+Uq+DSsQCW2ctG/f/dDugIabuLPiL7dSshTfHdE7b8lJt2xfK3E8n2MH?=
 =?us-ascii?Q?/ljCnxtKJSUFg0cjRzF2Za5BMsQ+Fr5vXI82f7TPlJ/qZtwObmsAiUq2VpnH?=
 =?us-ascii?Q?sNE1w9MG3Swdltf8zFgFVNRDE/ckOmk6a9RxtQJNFRMfZXsw+egQgolRby6b?=
 =?us-ascii?Q?C5WLma4xNV54SYPtIkldTxAZQFLEWXgQQH5M7dFMntuc3E22mT509X1qF46X?=
 =?us-ascii?Q?NZFHvDuwegsryJdqfvvrqU+eFWybEtGbMEdyjod1vxWHyapL0HyhDHI+Gdbi?=
 =?us-ascii?Q?VR4yFFz+eMOIOYTVAcH8Ggfvzmk2GiubGZfZWyBiXwr3/PCJdb88KQ9wmwPU?=
 =?us-ascii?Q?JraPClfYIT0FaKY9+80KGc5OGx06OZWI994k94LHD76ps020TxWAUDf/IXw/?=
 =?us-ascii?Q?LdLTaZfEpSNbJhFcL6FQlB/YefBGFrnPB//VyZWxG2wKAeEcyWBRC2Kh9CXo?=
 =?us-ascii?Q?M8UFsw27Q+zc9IOWD3ucBQPQvzdE41k+sDtfHWkvOommze4c9Y2qWL7g8Uky?=
 =?us-ascii?Q?qUd7QV9AppSf0YPhu/UfXpZlroo5yeIH8xRoUNlgNlBw0EgP1pw/GdTA5CMI?=
 =?us-ascii?Q?kyVYFCEjsBvjKbXdfWt5HiPEgKyhApN4PJ/YPV6G+pgIU4i72wVmGO1V3tmy?=
 =?us-ascii?Q?pU+i8v+XDpfoMInHEpbpi0cB1mnZfHLdlUaUlBO19DdcrvA8K2r8CURQE5Z/?=
 =?us-ascii?Q?keOs3qxTwlA0pJIftdtrCSz8RobffG8/rB4eEE9+OjH8ebifLsDj6biue6ik?=
 =?us-ascii?Q?DTuU8pIlcPb+QC1SfwCjwMND6nKiCcj6QORE3hzj4sT+YXUIRnZZuJPk3F8I?=
 =?us-ascii?Q?BKIQBD54H0eL/WDMKNZ1WreKPwbVWuK/PvhWMPFvZmvdDHjN8GHywXJq2/xH?=
 =?us-ascii?Q?lVHT7CeN1eWf8I1TSG7fOboxF0+SCmscCOV7NHaUVGpabG9sHUULxUYbE6Wt?=
 =?us-ascii?Q?bnplWRadL3g4qDmZ43ExXiV+RWnVqjlUFCRJXVevWLH?=
x-microsoft-antispam-prvs: <VI1PR04MB577574AB7F7CDA546D36D468807B0@VI1PR04MB5775.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(3846002)(4326008)(55016002)(2501003)(106356001)(6436002)(97736004)(6116002)(14454004)(44832011)(81166006)(446003)(81156014)(8676002)(11346002)(476003)(486006)(26005)(25786009)(186003)(105586002)(2906002)(316002)(102836004)(76176011)(229853002)(7416002)(7696005)(110136005)(256004)(71190400001)(71200400001)(6506007)(2201001)(53546011)(86362001)(9686003)(478600001)(6246003)(53936002)(7736002)(74316002)(5660300002)(305945005)(68736007)(33656002)(99286004)(52536013)(8936002)(66066001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5775;H:VI1PR04MB4222.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xjQblWakIoFQk+sLk5f08I2O8m156oNZphZd6dhpx8iwEr6VhXFyZirijuDWJN1QlPEvwXwbRICLZU0GFZanOIYeSPTS6ATm58NFgUosPMElZrmXenwIdi7FGJ+Awc8porhJ2tEd68EUSmADubW18c9tQZ1kUXD26hLAJ+Dx8G46aR8/l1aYf6l4bEg09ep+MKTwbWvVK60NIu+8fp34ZWuLezj23dVw6b9U1reOoPAfkrohExuQWJn4UlcN5fqYfjTw5SyjX9Slc8YKHn9BFe6iCKiImP5mpZPgqfRe1OXujlXG4BsHlY5UDcWZw1IACpt7T6PaG3aa2a6MPga84BMYtubQiin8IGhaEQr1BOBvIKfc1dtmBtzVngRgy9u1gtHOzH8G+y5R6rQnGfQaa7TMTsqmLGKp1fY7dkGYxos=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9977b896-3737-4cce-08c6-08d69be24f96
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 12:02:41.8109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5775
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Anson Huang
> Sent: Saturday, February 23, 2019 11:20 AM
> To: robh+dt@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org;
> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> ulf.hansson@linaro.org; Aisheng Dong <aisheng.dong@nxp.com>;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org
> Cc: dl-linux-imx <linux-imx@nxp.com>
> Subject: [PATCH V4 1/2] dt-bindings: imx: remove unused resources from sc=
u
> resource table
>=20
> Removes below resources which were defined during pre-silicon phase and t=
he
> real silicons do NOT have them, they have never been used, latest system
> controller firmware also removed them:
>=20
> 	IMX_SC_R_DC_0_CAPTURE0
> 	IMX_SC_R_DC_0_CAPTURE1
> 	IMX_SC_R_DC_0_INTEGRAL0
> 	IMX_SC_R_DC_0_INTEGRAL1
> 	IMX_SC_R_DC_0_FRAC1
> 	IMX_SC_R_DC_1_CAPTURE0
> 	IMX_SC_R_DC_1_CAPTURE1
> 	IMX_SC_R_DC_1_INTEGRAL0
> 	IMX_SC_R_DC_1_INTEGRAL1
> 	IMX_SC_R_DC_1_FRAC1
> 	IMX_SC_R_GPU_3_PID0
> 	IMX_SC_R_M4_0_SIM
> 	IMX_SC_R_M4_0_WDOG
> 	IMX_SC_R_M4_1_SIM
> 	IMX_SC_R_M4_1_WDOG
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

There're gaps left after removing, but I can't see it's actually a problem.
So:
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

> ---
> Changes since V3:
> 	- just remove those unused resource and no need to define UNUSED
> resource.
> --
>  include/dt-bindings/firmware/imx/rsrc.h | 15 ---------------
>  1 file changed, 15 deletions(-)
>=20
> diff --git a/include/dt-bindings/firmware/imx/rsrc.h
> b/include/dt-bindings/firmware/imx/rsrc.h
> index 4481f2d..d69f934 100644
> --- a/include/dt-bindings/firmware/imx/rsrc.h
> +++ b/include/dt-bindings/firmware/imx/rsrc.h
> @@ -36,15 +36,10 @@
>  #define IMX_SC_R_DC_0_BLIT1		20
>  #define IMX_SC_R_DC_0_BLIT2		21
>  #define IMX_SC_R_DC_0_BLIT_OUT		22
> -#define IMX_SC_R_DC_0_CAPTURE0		23
> -#define IMX_SC_R_DC_0_CAPTURE1		24
>  #define IMX_SC_R_DC_0_WARP		25
> -#define IMX_SC_R_DC_0_INTEGRAL0		26
> -#define IMX_SC_R_DC_0_INTEGRAL1		27
>  #define IMX_SC_R_DC_0_VIDEO0		28
>  #define IMX_SC_R_DC_0_VIDEO1		29
>  #define IMX_SC_R_DC_0_FRAC0		30
> -#define IMX_SC_R_DC_0_FRAC1		31
>  #define IMX_SC_R_DC_0			32
>  #define IMX_SC_R_GPU_2_PID0		33
>  #define IMX_SC_R_DC_0_PLL_0		34
> @@ -53,17 +48,11 @@
>  #define IMX_SC_R_DC_1_BLIT1		37
>  #define IMX_SC_R_DC_1_BLIT2		38
>  #define IMX_SC_R_DC_1_BLIT_OUT		39
> -#define IMX_SC_R_DC_1_CAPTURE0		40
> -#define IMX_SC_R_DC_1_CAPTURE1		41
>  #define IMX_SC_R_DC_1_WARP		42
> -#define IMX_SC_R_DC_1_INTEGRAL0		43
> -#define IMX_SC_R_DC_1_INTEGRAL1		44
>  #define IMX_SC_R_DC_1_VIDEO0		45
>  #define IMX_SC_R_DC_1_VIDEO1		46
>  #define IMX_SC_R_DC_1_FRAC0		47
> -#define IMX_SC_R_DC_1_FRAC1		48
>  #define IMX_SC_R_DC_1			49
> -#define IMX_SC_R_GPU_3_PID0		50
>  #define IMX_SC_R_DC_1_PLL_0		51
>  #define IMX_SC_R_DC_1_PLL_1		52
>  #define IMX_SC_R_SPI_0			53
> @@ -303,8 +292,6 @@
>  #define IMX_SC_R_M4_0_UART		287
>  #define IMX_SC_R_M4_0_I2C		288
>  #define IMX_SC_R_M4_0_INTMUX		289
> -#define IMX_SC_R_M4_0_SIM		290
> -#define IMX_SC_R_M4_0_WDOG		291
>  #define IMX_SC_R_M4_0_MU_0B		292
>  #define IMX_SC_R_M4_0_MU_0A0		293
>  #define IMX_SC_R_M4_0_MU_0A1		294
> @@ -323,8 +310,6 @@
>  #define IMX_SC_R_M4_1_UART		307
>  #define IMX_SC_R_M4_1_I2C		308
>  #define IMX_SC_R_M4_1_INTMUX		309
> -#define IMX_SC_R_M4_1_SIM		310
> -#define IMX_SC_R_M4_1_WDOG		311
>  #define IMX_SC_R_M4_1_MU_0B		312
>  #define IMX_SC_R_M4_1_MU_0A0		313
>  #define IMX_SC_R_M4_1_MU_0A1		314
> --
> 2.7.4

