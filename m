Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE86C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 03:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F423F20645
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 03:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pc2BG8br"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F423F20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbeLKDYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 22:24:11 -0500
Received: from mail-eopbgr140053.outbound.protection.outlook.com ([40.107.14.53]:53529
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728584AbeLKDYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 22:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkw+VQ2kzCV/S0gzxRdHxDfYF103nbCPIOZ+DCj7Bec=;
 b=Pc2BG8brssWqTHUFt2U8bV+vZZalqFTC8OWL6wqAM0pJpnNTKodg+0IrKa2BgVgPGuf1oJ0wZZeH4oysoMhb1n1KwV3ELJ5tnaEZFdPR2okyI8eSEXj3R38REytV8IjvxJ1VNkNYZpP6Iea7s2AXpC9d0urUn5XksugeeWYbECk=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3786.eurprd04.prod.outlook.com (52.134.71.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Tue, 11 Dec 2018 03:24:06 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 03:24:06 +0000
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
Subject: [PATCH V4 1/2] dt-bindings: iio: light: isl29018: update power supply
 name
Thread-Topic: [PATCH V4 1/2] dt-bindings: iio: light: isl29018: update power
 supply name
Thread-Index: AQHUkQD4MSDhDZC7ZkypeO9dPwUjuA==
Date:   Tue, 11 Dec 2018 03:24:06 +0000
Message-ID: <1544498291-2716-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0067.apcprd04.prod.outlook.com
 (2603:1096:202:15::11) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3786;6:H1zXtSiJFeuP2lwphQPR+pqZ0IdMYg3ZrvZsJZvbNSpULNtKSasqm0+4Wp6NP5czumaV3r8qHA2HVAMtoCMkqmQkJ7vZCIoZh7UISXqI/DFGre0pTVCRm6bnyuofQg05NRxy7wzuV7xnRzXQi6m2qHjkroKKHHJ7TTdlWux6pGxd+81ABZS45kduIOpakoB9HGK8uztorRXQXderfu2427yzcToTwr0DIm1bkvd5Xmfd5r1YjD5LOH5eSaY03EKPojNeXSyhU9rM+QU/TM42hFx45jdCBYcr3H8qIfPrzZ0lKps2NuUo/jJtXEM6VhQGEb7gHt/JU+l7Xs8kFbXGcjUA//yPdykpWrl4Dmdlygl4GKl5sgHe5RsVFQIZW5OQ2b1PCoS0KRPYcNBOf6jit9fhGtJHS1zyvp5MjxSHmf3Gw2Wz9rDVYUHTo+FVq44LdmT4fzkSvvrDuOpnf/57hw==;5:i1PUAviETzUhSVWmVh33vpouBmPFLTmG5vhvueXagZe+gxwPT7e4DDv4HOd3INPqlbsd+UXLqnWJX4jH4wLvVKEytHAQvzaXNjo0ol34ZCsqlQk6Nv31gbM2c8uLDNxZ8Zd2OJ06yNzRlOprOZQ5JJl2R9Vs/1D40zpQINVIQvA=;7:GPUBpiFTZ7jO3cNHNct2SgHSF2FLbFMgbqEASi1ZT2T1bsN0BkFC2I7RiLL2GlwUKFc43EXIo7NFlMWokDn10XjH71azO/d+n3gWvAazEB8ZgoPuT8akI06Pu2Ul3GZgZz+51XRB/OopPM8Pv4YnEg==
x-ms-office365-filtering-correlation-id: 15876912-68fe-42c0-5d59-08d65f181b09
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3786;
x-ms-traffictypediagnostic: DB3PR0402MB3786:
x-microsoft-antispam-prvs: <DB3PR0402MB3786E5324EE72E94602FC2C3F5A60@DB3PR0402MB3786.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231455)(999002)(944501520)(52105112)(10201501046)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3786;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3786;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(136003)(346002)(39860400002)(189003)(199004)(478600001)(2501003)(6486002)(14454004)(305945005)(97736004)(3846002)(6512007)(2201001)(5660300001)(86362001)(7416002)(4326008)(2616005)(39060400002)(36756003)(71200400001)(7736002)(71190400001)(6116002)(316002)(186003)(476003)(2906002)(8676002)(386003)(106356001)(25786009)(105586002)(26005)(66066001)(50226002)(102836004)(6506007)(110136005)(81156014)(52116002)(6436002)(99286004)(14444005)(256004)(486006)(53936002)(8936002)(81166006)(15650500001)(68736007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3786;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4cd2r4+nC4ai8Z5EG9sOD1tkMX5x7gpM590ILJyVCY9ZBUOwiDGjgYsPQ/XPdy7lrsmEarg5yKLt6P/izI7/prAxLE6SRQLdZ2xApngzRkq8WW/Jw9cggYRI6xgAF0PTv4/3J/dndIlHjgONsrfk0i/ijy5W3KWhRH+XCA/WPhVUf7S2+scAO53NYapLhbnhb3KIiElXYiPsURZzJsyJERXaAgGYvO1R6l/Oeq0Wd6skz//UJGbhCTiUU2dW+3S3a6ldBXQK4THEeegSNhWCKYjamSIQyDXBvYJPfFWBCmLo5AKF2nJ8QXUVe95zGwMd
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15876912-68fe-42c0-5d59-08d65f181b09
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 03:24:06.3911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3786
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

