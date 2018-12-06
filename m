Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38539C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C054C20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hgMfSeWL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C054C20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbeLFTWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:22:20 -0500
Received: from mail-eopbgr30077.outbound.protection.outlook.com ([40.107.3.77]:57808
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725921AbeLFTWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:22:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70Z61OcWT61YbMWScrvDh9Yye/Y4iKWpsjotu/WzN7E=;
 b=hgMfSeWLnaJTLXCZ/29SzLT76jY4c1KfU8j3xXpFiqHn5jgqY8kQS4Joyq3u8DfJR33panr8aO3qkH5G5eeER7v5gjb73/S2yjLt7d9pge2BAgN11u63vGidFNYLh7bU+t1uIwOCH7jtKaryzRKxX3Ybr/aWC6NdnPcn7PXNE1A=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB4510.eurprd04.prod.outlook.com (20.177.54.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Thu, 6 Dec 2018 19:22:16 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::f80a:77f3:7cbf:62b5]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::f80a:77f3:7cbf:62b5%2]) with mapi id 15.20.1404.021; Thu, 6 Dec 2018
 19:22:16 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        =?iso-8859-1?Q?Lothar_Wa=DFmann?= <LW@KARO-electronics.de>
CC:     Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: [PATCH] ARM: dts: imx6ul: Remove extra space between node name and {
Thread-Topic: [PATCH] ARM: dts: imx6ul: Remove extra space between node name
 and {
Thread-Index: AQHUjZj/ABFHnE4na0mgvV1RGXlBXQ==
Date:   Thu, 6 Dec 2018 19:22:16 +0000
Message-ID: <58cf0fc7b3e0037344de3a02ecc3b210abfbfc28.1544123990.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: AM5PR0402CA0016.eurprd04.prod.outlook.com
 (2603:10a6:203:90::26) To VI1PR04MB5533.eurprd04.prod.outlook.com
 (2603:10a6:803:d2::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4510;6:E8JOLNg+fjV1j7CtoO5B2mrcrBTC9r2JYFrrMyLQ1VXIk3/BOdcCyocQPc4oWs+4okXCtWuIKRz55hylJnMgFvqDzVZ0PLVLiU9r7LvHzfLJkdDcOy4saQNA9M8O9vFChDYAXO31WOV/QLK/MZ/wXuvSzm4OvLQAxaxGg1x8xt0XhpsoGcgMHK4AJnkeiDX3KXPJa2Tnwva6G+Uobr1fR1RAvpT5nK5QanGlx5qWPDlzuhJIwsXrN29cRSiLSyytoopR3S1pYjdxz28XfymdSj9sy0P075PzHbrE+Zue0Q+x5WmmXEu1O+k7K7/CrUghbcO4TaP6i4v8qdxg5KdQGmoYpWbDYH0JHXKqgouIPQlHNhFaEzmNFCE2dCLacijBmdoDc9lEXqZdjYKKkqTzds01QkBAgMsB82k5P5hlqR1/WOSTYfyEfjqlEWAn/Vpqn6aXS7xH18TdkA9knoshDw==;5:+TSHRRoRo11rXYU+Sx7FxUmjeCjGTQW4rlLpGxvk5qIlTM7Z6md1Dg+qnvI/Zia6Mcf94I1bNoW361REug3bTjzWuL7PSUS0eozEJ9ojWhP95MFyBEHHFtU53m14YEf+u3vGA9DFXwkBKOji2qn5uKsJWpbyjsPiUeRK0I0MvQc=;7:vIlMaIahn/xQQ0AEMbTMCSFHXcYsL3oO+Bdf2QfRzPuZEcsvHu5XWddzMk6isyqgQXzd+sWo7Blj8qbIewEyNafPAOHBv0oBxDt1JJPv/7ShfNUn714rB3hzxwOHyRfwKqOmShyzq1N5Cxm3VI2DCw==
x-ms-office365-filtering-correlation-id: 78ea8875-9988-4d62-bb62-08d65bb02195
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4510;
x-ms-traffictypediagnostic: VI1PR04MB4510:
x-microsoft-antispam-prvs: <VI1PR04MB451095B317ADC72C932E833BEEA90@VI1PR04MB4510.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4510;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4510;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(376002)(396003)(366004)(199004)(189003)(102836004)(44832011)(316002)(99286004)(4326008)(25786009)(97736004)(486006)(2616005)(14454004)(71190400001)(86362001)(71200400001)(118296001)(52116002)(68736007)(5660300001)(6436002)(2906002)(386003)(6506007)(26005)(476003)(66066001)(8676002)(8936002)(36756003)(6512007)(81166006)(81156014)(186003)(6486002)(256004)(3846002)(54906003)(6116002)(478600001)(110136005)(7736002)(53936002)(14444005)(106356001)(305945005)(50226002)(105586002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4510;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5rqfKVEoQeP9+6h8SDknhsawRTtT/ox/daHqr0/gTw0giAGBWIs7lSKrjejNZCf4xDpx+fAsyz/aA9qkQl8RwBvw32RpEo6eDYvaENvLCx+kiA3TCL2oJqAcrZPgfinYyoSbHBN7AbUgJnYcxbOHZRFs6QiO5sHDi942VR1Qp/9+PmRY19f5dVZM3tAvT2MlIPVn7d51RcDMx56RSHAcUd2XXtvCjsy6iltN66Ng1RbzbnxyjJHwfk9asnDN8wpBB2ASz5SqoDQKfG814r6jQJPZeaL1tJN36UQ47WMkDmYadRzNXwMAtZmR6QYyzYdfkRAkj9zS1epDlH3rifcLThEYLENRyLLJQ3zmI3/vN6s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ea8875-9988-4d62-bb62-08d65bb02195
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 19:22:16.0490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4510
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 7d1cd2978664 ("ARM: dts: imx6ul: add gpmi support")

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/boot/dts/imx6ul.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 083d3446c41d..93ca2405ac8c 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -183,11 +183,11 @@
 			#dma-cells =3D <1>;
 			dma-channels =3D <4>;
 			clocks =3D <&clks IMX6UL_CLK_APBHDMA>;
 		};
=20
-		gpmi: gpmi-nand@1806000         {
+		gpmi: gpmi-nand@1806000 {
 			compatible =3D "fsl,imx6q-gpmi-nand";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
 			reg =3D <0x01806000 0x2000>, <0x01808000 0x2000>;
 			reg-names =3D "gpmi-nand", "bch";
--=20
2.17.1

