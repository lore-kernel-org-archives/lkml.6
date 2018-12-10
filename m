Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DA8C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012F3205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wj2KSyeJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012F3205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbeLJHLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 02:11:25 -0500
Received: from mail-eopbgr130057.outbound.protection.outlook.com ([40.107.13.57]:52880
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726292AbeLJHLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 02:11:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkw+VQ2kzCV/S0gzxRdHxDfYF103nbCPIOZ+DCj7Bec=;
 b=Wj2KSyeJFAXOYnHLgyUCaarYaU9aul3ifoypWmUuoJzrX6BRQ+t9pRqjiqYFETZA48Y4ge2MrisdfMpsVgOejz5MqOgGmiV0d+0UZcLph68c4y1rgGVWhyani/ETd0048UZU4IpMXvktgFcZe/IQ5LQJdF6klMX/31hoXvxeq5Q=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3690.eurprd04.prod.outlook.com (52.134.70.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Mon, 10 Dec 2018 07:11:19 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 07:11:19 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V3 1/2] dt-bindings: iio: light: isl29018: update power supply
 name
Thread-Topic: [PATCH V3 1/2] dt-bindings: iio: light: isl29018: update power
 supply name
Thread-Index: AQHUkFeMq54w2saSI0m5D7dfdmdMWQ==
Date:   Mon, 10 Dec 2018 07:11:19 +0000
Message-ID: <1544425521-775-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0015.apcprd03.prod.outlook.com
 (2603:1096:202::25) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3690;6:sG9vfzht60I8Knk4APMol/6LYrtJy1TIIwhZvUVpwbH479lJwOfx3G+gLLSehPgblYK/Mo+9VCywCtHMMiBLOrWtLUG+oiQa1ytoGlmWp2YWlbUZESYNgNQI4TwjB+/BiuZuWBOp06e3or5b0Tw5U55DI929J+o4WR0U+GsLsaLdogv2BUK04KGSq+kTkwb4c/VyNGK/u6ySN3lZAxSQXyvZ7H1ORnmLvyuZLU1pLWZarDpnyd93dvZPEacyJIEQ+Yv7tHoWy3Q91V17JrE45i0psuVrxQYflA2j6I2ZLAGHofzlupWjiQiPkrD3AWVmb0pcHpAkzfuykDIULBXdaiou7qOOIb59ApiS39cCApdJvh1Sa8ChNVoHg6uB+Xog3ufqDiAxijgtlSN0n4mGD+FDLtpAVcGn9KPw1Y7bLF4NebS3LyCkXJco2kM1GFK4WTBKOZW4B020uui0go3JCQ==;5:K15iGcFX3WwC9nP6xGRxTyl4IYkXIf66nvk6WqPXwlkGY9i7LI4c6j7FEIfd90oGELk23W2Tv7uLYVzFdcjTlOG0+GEuuuB9LmKT3VwAAbZwgcLc9uJ1AkPBOrbAy0GsuI3iOSUuOT1E0VMJ+DGPnz74CfR710pCCQY5Sbxzi+I=;7:9fZqxNYrckPdssXb6S6hndo4vL/JUMHbDqPo2fS9M6KpEfLeqkaPcYxKwi0zqyB2Eh0d7YIIPqy+EmwpERjeGBkF5hqWLQeomqhfOyaBYZJEv/nV8Iv4C837E4rpLsi68OUk/QInx+TTvA6D1jGxIw==
x-ms-office365-filtering-correlation-id: b932492c-cd2b-433e-d5df-08d65e6eae89
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3690;
x-ms-traffictypediagnostic: DB3PR0402MB3690:
x-microsoft-antispam-prvs: <DB3PR0402MB3690AF4E778DAD0F259D09EDF5A50@DB3PR0402MB3690.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231472)(944501520)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3690;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3690;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(346002)(136003)(396003)(199004)(189003)(25786009)(8676002)(386003)(66066001)(316002)(86362001)(486006)(102836004)(5660300001)(15650500001)(36756003)(52116002)(68736007)(256004)(14444005)(14454004)(6506007)(2201001)(110136005)(105586002)(305945005)(71200400001)(53936002)(71190400001)(2501003)(6116002)(476003)(81156014)(81166006)(6486002)(99286004)(7736002)(4326008)(50226002)(2616005)(186003)(6436002)(26005)(97736004)(478600001)(106356001)(3846002)(2906002)(6512007)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3690;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PxcMWWFweTa9jKzKZLItM5jpvQPmxJvoWhFDpBs6cqMR7VBLYhx3diUx27iRE++BBpbcXn0IXeqALTQLDzZx8pt/cPlXDZx3uOsWkHvye7YOOTFcCAAL/3F4DfcEtIZg7rCjMVuUU4AQ9fQFGlv5WFppaQjmdBLrYu4C8oBuF0j4V7dehEbeZJt5V2ZC9yI4qmIr0WP7pt8cFT5T6mIz7N/sW1hBo69NXQdxu4XwRzlw0F5FQgEn2EKP2xDLiEu6S0sPo1d9oWGkim2Ng6AvfTB/002hbs0+xl0yfglkkJ33wC6FEuGwq0c1boXF5KNP
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b932492c-cd2b-433e-d5df-08d65e6eae89
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 07:11:19.2469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3690
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to datasheet, the isl29018 has "vddd/vdda" power
supply, and isl29023/isl29035 ONLY has "vdd" power supply,
update the power supply name with "vdd" and "vdda" according
to datasheet to cover all devices and avoid confusion.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 Documentation/devicetree/bindings/iio/light/isl29018.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/light/isl29018.txt b/Doc=
umentation/devicetree/bindings/iio/light/isl29018.txt
index b9bbde3..36f737d 100644
--- a/Documentation/devicetree/bindings/iio/light/isl29018.txt
+++ b/Documentation/devicetree/bindings/iio/light/isl29018.txt
@@ -15,7 +15,9 @@ Optional properties:
   Refer to interrupt-controller/interrupts.txt for generic interrupt clien=
t
   node bindings.
=20
-  - vcc-supply: phandle to the regulator that provides power to the sensor=
.
+  - vdd-supply: phandle to the regulator that provides vdd power to the se=
nsor.
+
+  - vdda-supply: phandle to the regulator that provides vdda power to the =
sensor.
=20
 Example:
=20
--=20
2.7.4

