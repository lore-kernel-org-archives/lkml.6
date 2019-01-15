Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA594C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC95220651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cCgQw5YK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbfAOKFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:05:44 -0500
Received: from mail-eopbgr130040.outbound.protection.outlook.com ([40.107.13.40]:62592
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727790AbfAOKFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:05:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnBg/3Zd/nOHZWiutsHzWXpvg1b8b3mX29x9+sBnDXY=;
 b=cCgQw5YKVz0GMGKJZNVxGBT+m2jFkOzQQV3F73d5+2mW0ulTgj3NetanjmTTafs+1j7QoNSdyqHWTetNf85xBtq+wZt6Uy4kqFFiTbefPkuZLRU3rWTKVMAhLAlgs+oTV6mXN2moSNfsZvDIXJaBusBnJ7ridN2KhxsVq3pEURk=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB5822.eurprd04.prod.outlook.com (20.178.204.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Tue, 15 Jan 2019 10:05:35 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb%4]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 10:05:35 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v7 5/5] arm64: dts: lx2160a: update fspi node
Thread-Topic: [PATCH v7 5/5] arm64: dts: lx2160a: update fspi node
Thread-Index: AQHUrLnbWH3YDSF6OUOBVDSvHgkBWw==
Date:   Tue, 15 Jan 2019 10:05:35 +0000
Message-ID: <1547546584-5254-6-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1547546584-5254-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1547546584-5254-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0123.apcprd06.prod.outlook.com
 (2603:1096:1:1d::25) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5822;6:As0kijqYpdLXyo/cdHf5tv3DukVLKJlSrelMt5fcIHXxo8so1vzga9pd7L9TSf+5Hc/A2UI6jdZGOcBjV6pLxbx5+r8YwqSM+gekE6uSeOEkC/7+yo0Vy/Gau3yjl0M4f31ksHN8IfjWH6kezA12rwjE5KHPoPToCeegDuGvT/r1Lv2vohK9g7nhybR3CPpB21Hy/IPwNcbN1DezAsXgtm3sYB+XyydpslvRBcFF6hVev9qrmXxChTkAV7hcWk8K1cJTx7QGPDWowijYBnzEcjxOE6l5ga/mmCUYxe0VmepUVPACimeh/Grfsz1gT+WwIMsplsee2DfJPu7ydeZAvBggPf9YJDLGJBvtpxzO0iQ8Zw0M9xJkrWGQXnm0VTW89+MPtJXW20oVN7BlmaRUwYBTH8n8hScKmBCrE2VnJnnwxYXn6mTYmABa2Orh4eCGc8LXHTNFmiPv0JZyYHzhmQ==;5:TBB8xsgEVQTEGXk4huBj41QUcQK5caVyFMfPbDFnsFqO1JSusOlpIk+Slo3Db1eJgX4pedZOQyYqShMPfP+uIeZsAKBL+r9lO5bPgcRH9vvC2xMpr5Vsf2cNhap/+Ijc37ShVhwCCRiYxH3jzR1jj1H6/1w6Rz5dTJ+dw+AsZ8yW/9+a6ajsLxyvLv/4Ko7LfiVJtXGhXvvCYiwAQzcriA==;7:5ul/OENiRKkVmyhobrfF4mxKmsfX/RxTZHZoa5QNASNeEN9RIZt9BBxwAkSTxSP8ewRP9XGxrn55/byg/brqOqgk45g/B2wBkDYigZWKaAzdccVBLVOVpJZF4cuCo9c0KyhqE9gjifD0RkgfVy0GRQ==
x-ms-office365-filtering-correlation-id: b6540173-c398-4d61-2c7e-08d67ad0fdeb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5822;
x-ms-traffictypediagnostic: VI1PR04MB5822:
x-microsoft-antispam-prvs: <VI1PR04MB58229BC270402356EAAE0EF799810@VI1PR04MB5822.eurprd04.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(39860400002)(136003)(376002)(189003)(199004)(36756003)(305945005)(14454004)(6512007)(81166006)(486006)(446003)(2201001)(81156014)(2501003)(4326008)(105586002)(8936002)(386003)(7736002)(86362001)(102836004)(2616005)(26005)(186003)(6506007)(54906003)(50226002)(97736004)(316002)(5660300001)(110136005)(2906002)(6116002)(8676002)(256004)(71190400001)(6486002)(7416002)(66066001)(3846002)(99286004)(6436002)(106356001)(478600001)(76176011)(55236004)(71200400001)(78486014)(11346002)(39060400002)(53936002)(52116002)(68736007)(476003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5822;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YOjbCOhrN8U/RrqNzfxvLr/Md/UmthoOdzf6T9QkdDfr0jv8mdxkxbsnvrP4Q+FHhXp8Epk4HrSiUm9A69I4r5/wryGdn1NYv2dYei+W5LgBp2SAPue8ZHWIfXXRxgYIodlvMaUGY//Zto/y0KCr2ev5AXDvUBNB9DSPrdNlvP/zAYvHOBI5YgxjSW1iG1sKY8Y806wWEYi3Z5FJtAgVADdMDKGoTMQmmsYYNNlw1FjbX/LpV68MsyI6I0pelO1eoMdO8pLAV3n1s14/Mf/KQmnLMIlfaHfwQBNvGl7i/6zujE2y9rSY1pF+e56Qzts616xLbn9IbgQpO4VlsIbMTIdk/UDr20MvEG0erDt/RYxZyKAoeTYFd9ZNnFz+OZmyQHiuoKE0wNyBxxKHAYCoOUR5cCvKS/fdOQ9kSnlRvvs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6540173-c398-4d61-2c7e-08d67ad0fdeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 10:05:29.6493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flash mt35xu512aba connected to FlexSPI controller supports
1-1-8/1-8-8 protocol.
Added flag spi-rx-bus-width and spi-tx-bus-width with values as
8 and 8 respectively for both flashes connected at CS0 and CS1.

Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v6:
- Correct S-o-b tag with full author name as 'Yogesh Narayan Gaur'.
Changes for v5:
- None
Changes for v4:
- None
Changes for v3:
- None
Changes for v2:
- None
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64=
/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 70658946fbbe..9df37b159415 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -60,6 +60,8 @@
 		m25p,fast-read;
 		spi-max-frequency =3D <50000000>;
 		reg =3D <0>;
+		spi-rx-bus-width =3D <8>;
+		spi-tx-bus-width =3D <8>;
 	};
=20
 	mt35xu512aba1: flash@1 {
@@ -69,6 +71,8 @@
 		m25p,fast-read;
 		spi-max-frequency =3D <50000000>;
 		reg =3D <1>;
+		spi-rx-bus-width =3D <8>;
+		spi-tx-bus-width =3D <8>;
 	};
 };
=20
--=20
2.17.1

