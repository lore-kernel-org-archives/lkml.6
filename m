Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7445C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FCEB2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DT3qOYkt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FCEB2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbeLKFCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 00:02:45 -0500
Received: from mail-eopbgr150082.outbound.protection.outlook.com ([40.107.15.82]:35275
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728682AbeLKFCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 00:02:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yDivyE66yUSnoP18I4GD4cCh3mIxjSnbPK9Jr4UMF8=;
 b=DT3qOYktioO9RcgkBrTVqGvgCyhk745uvhiInj7BribPdTDznHveizeUTOFpkCSQSHbdCUZV6pz8ofkxAtdyI8TNwgX7+pO/hj3RIGoM0tW7AmO+2pyDhaPVGphxEfKNWcMKP3noH44QtLZkmN0LluT+3kc8xHugh7a55PAHjao=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3898.eurprd04.prod.outlook.com (52.134.65.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Tue, 11 Dec 2018 05:02:39 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 05:02:39 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "preid@electromag.com.au" <preid@electromag.com.au>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V5 1/2] dt-bindings: iio: light: isl29018: update power supply
 name
Thread-Topic: [PATCH V5 1/2] dt-bindings: iio: light: isl29018: update power
 supply name
Thread-Index: AQHUkQ69KKDx96mQQkC4bI4uHvTkMQ==
Date:   Tue, 11 Dec 2018 05:02:39 +0000
Message-ID: <1544504196-30277-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0028.apcprd03.prod.outlook.com
 (2603:1096:203:2f::16) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3898;6:T5La6ulW0fimKd+HIozqU54o27QxvjEx1PJtY0rJQ0HHpfjjmnXaFn2RO52cUbGzodu4pOGGz+fZ5y+ycP8wO3g93w+mWXtTI96CUcIUeYiLlos+EVVIi3ecNRDWGfDHxERP5Hp1AALV1GunGon25XuxCLUOJrZep6y2GCyvLxdHnSyHSbJW79Rdza3GTT9HNTothPDCdzei6+IjYXX9lBgeHkiJdziH43Mm9SHmE7706gm6ZCNnN/5L47pMvnP7j8wnecMCnAo+5RGbTWysPRGPXSVE6qhc08MFTZalbYHnbvgQZ3viuLryf/B9C1568OylsKyb1pY/OC6tIUe9w9avZbZ4/QIeW6ldYIanM/0ZmqMY/+dsKv0ybVO0opexZbqq1M1Hs2SvqwNfZJh4cbhPaeTaDF6vT259T8aeuYq+cbypUKGRAA2877GGBotonr2DjapNVV/C1SXSCQiAgA==;5:ADeZ7TiGn0rPYqhi2kU1kv94TU79d81wBiPyktjCF5RBbVMclWbDy3QQ+fUaZk+vNUzUpQ3pqM6ypP2vTkOZt6ruIir3QLYbQbO4gW2kL7dNQuW4wmVrpGVagFcxAeKQ/Nr8KAAiG1dyaSF9lNY9x2x21W4ZF+nAwhHJTXvgHLw=;7:45t/zANubVuA2mMYFJC9XWyAClCyQFF0L4cviiG4b39pmAT0HGazuJ2MUDcjhvohP7fihwabE4X2B3yBM/PLsXXWf94qssB8jL/6Q9Mi0g32dFBUVZFCMNr4hgRNl5mz1iLpcqf+vnthdyMBJtG06A==
x-ms-office365-filtering-correlation-id: d822bb29-515a-43db-c0d9-08d65f25df9b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3898;
x-ms-traffictypediagnostic: DB3PR0402MB3898:
x-microsoft-antispam-prvs: <DB3PR0402MB3898DBD4144685F6C328B0B4F5A60@DB3PR0402MB3898.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231472)(944501520)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3898;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3898;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(54534003)(6486002)(71190400001)(186003)(36756003)(6436002)(68736007)(3846002)(7736002)(26005)(15650500001)(66066001)(99286004)(4326008)(50226002)(25786009)(105586002)(71200400001)(256004)(14444005)(478600001)(106356001)(7416002)(6512007)(476003)(110136005)(6506007)(386003)(2906002)(2616005)(14454004)(486006)(97736004)(316002)(102836004)(2501003)(39060400002)(81156014)(86362001)(8936002)(305945005)(5660300001)(2201001)(81166006)(53936002)(8676002)(6116002)(52116002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3898;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: oBxfucTTtPcTpZQW2VrgbTk+Pw7KmZDyMPbzAzyry8nnR4beLrVVtvXaRyA4uhAUF6DhV6uBLkIGte0VBp5Y3sEJpZOWX+vBjXoEnQv6KBkpprSi1spqVB5f7vVXDeu/dsN6n+yiNF3FMvunI3o7JqttYn//STbmggpGx+e29QqllTjtsEAzSRFaKhYwAWJ8ZgT8ZCezPdM1r/kTw1Np608ikz9lGqAcWCo2ZoYC3UBLb0cBUpGeZOdFNEQwOcYQYGYrlCh3cbJfAXIl2oid8dZOR9A7f7oLvIe0mb5RjFcWuAYWoWeQIzzUJvcnGpSL
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d822bb29-515a-43db-c0d9-08d65f25df9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 05:02:39.8055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3898
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to datasheet, the isl29018 has "vddd/vdda" power
supply, the "vdda" and "vddd" MUST be shorted externally,
and isl29023/isl29035 ONLY has "vdd" power supply, so just
one regulator is needed for the driver, update the power
supply name with "vdd" according to datasheet to avoid
confusion.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
ChangeLog since V4:
	Since ONLY isl29018 has two power supplies and they are MUST shorted exter=
nally, so they can be
	treated as one power supply as well, remove "vdda" power supply and ONLY u=
pdate the "vcc" with
	"vdd" according to datasheet.
---
 Documentation/devicetree/bindings/iio/light/isl29018.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/light/isl29018.txt b/Doc=
umentation/devicetree/bindings/iio/light/isl29018.txt
index b9bbde3..c4c4e9e 100644
--- a/Documentation/devicetree/bindings/iio/light/isl29018.txt
+++ b/Documentation/devicetree/bindings/iio/light/isl29018.txt
@@ -15,7 +15,7 @@ Optional properties:
   Refer to interrupt-controller/interrupts.txt for generic interrupt clien=
t
   node bindings.
=20
-  - vcc-supply: phandle to the regulator that provides power to the sensor=
.
+  - vdd-supply: phandle to the regulator that provides power to the sensor=
.
=20
 Example:
=20
--=20
2.7.4

