Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146B9C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7BA02087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Uz28tnBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7BA02087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389694AbeKPV0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 16:26:16 -0500
Received: from mail-eopbgr50076.outbound.protection.outlook.com ([40.107.5.76]:37337
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389672AbeKPV0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 16:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l35g7HAU6fYKeI80Q3lmr1wKP16xg+1ArcGjvgooQTM=;
 b=Uz28tnBsJPMbFf0pUbblJLl6VAUX/crDVS884Qb0Fj5fabWOELiKPt0GQhw2ns6u3gZOGMWDbp9tLSotqgucs7t/BJvg1cGgSZPXOKHJ5yCVMh0aFlIC4hyHPhA/6MGGicAKgW7yE/Eg7yga8Jbs0cus9StcXMdnG2IG2FoOFzo=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB3294.eurprd04.prod.outlook.com (10.170.231.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Fri, 16 Nov 2018 11:14:15 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::297b:bb50:9b83:48e1]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::297b:bb50:9b83:48e1%4]) with mapi id 15.20.1294.045; Fri, 16 Nov 2018
 11:14:15 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v5 5/5] MAINTAINERS: add maintainers for the NXP FlexSPI
 driver
Thread-Topic: [PATCH v5 5/5] MAINTAINERS: add maintainers for the NXP FlexSPI
 driver
Thread-Index: AQHUfZ2CjxT8s8XKNkm8eYizhTTAjw==
Date:   Fri, 16 Nov 2018 11:14:14 +0000
Message-ID: <1542366701-16065-6-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1542366701-16065-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1542366701-16065-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR04CA0149.apcprd04.prod.outlook.com
 (2603:1096:3:16::33) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3294;6:9zU0e7HGsgkiryTYv/4dwTHdOHRqPrr6Z2Md2C9rxYv+hnEPr0eZEYYHeCMMjOugajRIBoSkCefTGAEBkoluBsQqQ5D6dHte0b14JYg3N6oASzu1ovPu/joc2Pt6t7OjVfu7N3zGyW+mHN6XuX4Xi58OcTRxVpubhM2VJ/LcqB0KDTozNsuE95N1inIwbAXmq0mIQHqxDG4l5d1218Fp5nIY/yi0QiK2eZYIYQBWWvziX6cckht85Ox5s4WGlbQWnN25UljBM7Iumy+qiJ/jJ9HDmdx2ZRBm6A2llpA31J73xtyl5DOFrZ6w0sqwyn7C8ntJeZaDPPGMPgAg2cfg4OEA4YRQrwmPZ03HWg4YWNY63A6d+YUNpdvZHHGzgN7uwrADTBy2hLbSR4xjHWxAj6vFbqslSMzgec3zEy3uT5/lxXoh4O9h5Y3HoJg9uMTTbl2n1dtfmobN5nKeE4TeCw==;5:odpth6+hmpiSa9jjcrmKW5G/ZAhukRL4tPx7Tnn3l0j0gnPGzq1iK5Sa8c/xKiFR7WzEEsEfMNJ2pJZamBC8vt6h9fc/CWNBMThb7QVDbKq0WzfovN8wKkH93Lw4GB9ql3wn0mXJ2SLaFKHQJR49Rg/TKa+DZ2ANwtHYLb7N4Zs=;7:1NX47FCr6LGYwjxJvvjF6yKQITjUGaxxS/x9aqwl3vE8LGlH5wOjYW6J1hnVbeYJOZhXot7k2F/17R+AV2waZ73FfKmCZ0CMKdKrEI2Bg3+FNISEUag7MmKWpMc/DilfZaEbm65mML4xmvIV7QBoGA==
x-ms-office365-filtering-correlation-id: c84880aa-7312-4129-ffb4-08d64bb4a470
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3294;
x-ms-traffictypediagnostic: VI1PR04MB3294:
x-microsoft-antispam-prvs: <VI1PR04MB3294C90C33B5584853ADDA7399DD0@VI1PR04MB3294.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(162533806227266)(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231415)(944501410)(52105112)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB3294;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3294;
x-forefront-prvs: 0858FF8026
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(396003)(39860400002)(376002)(199004)(189003)(2906002)(81166006)(8676002)(6436002)(106356001)(81156014)(6486002)(102836004)(25786009)(53936002)(4326008)(316002)(478600001)(8936002)(7416002)(6506007)(55236004)(6512007)(386003)(26005)(105586002)(186003)(54906003)(110136005)(68736007)(14454004)(99286004)(52116002)(2501003)(2900100001)(2201001)(76176011)(3846002)(6116002)(97736004)(476003)(2616005)(36756003)(78486014)(305945005)(486006)(7736002)(446003)(66066001)(256004)(71190400001)(86362001)(71200400001)(39060400002)(11346002)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3294;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LNC6MshEnMranifZHOLiybCpt0qS5Q66zgdcKxXjl52/Ba7peOQWbbMKcDEqVkA5QdUzg9KcOshy8RBWavT9gsgC6nDWvljWbAYy1w3L9TS8XiInSCsdmcDyDem4HCYCvuaz7zyg18Hg4e0GNlEt1irpVSwOGcN9yspvTI83RVl9QLpvS1pmmXo0qJXXZkEyMKGJf5gKCVWX/fRmFTbtrOwDsSqAD7/HikPLzT4AnPzfg37sMGzWLG6AWFL9chUCZf5qSi3zJWkmjZZCipy9R3sar8pwxVSw+lEHv7jUddK06UUrmT5n/BDXmE96xzuxsUwzmdw9+MhyA2trEh8pprHEe0rHQsYq/yM//fjyUNM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c84880aa-7312-4129-ffb4-08d64bb4a470
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2018 11:14:14.8672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3294
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainers for the NXP FlexSPI driver

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v5:
- Add maintainers for binding file
Changes for v4:
- None
Changes for v3:
- None
Changes for v2:
- None

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0abecc5..7076bf7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10686,6 +10686,13 @@ L:	linux-nfc@lists.01.org (moderated for non-subsc=
ribers)
 S:	Supported
 F:	drivers/nfc/nxp-nci
=20
+NXP FSPI DRIVER
+M:	Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
+L:	linux-spi@vger.kernel.org
+S:	Maintained
+F:	drivers/spi/spi-nxp-fspi.c
+F:	Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
+
 OBJTOOL
 M:	Josh Poimboeuf <jpoimboe@redhat.com>
 M:	Peter Zijlstra <peterz@infradead.org>
--=20
2.7.4

