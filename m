Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A54C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7682080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vADMVyVa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7682080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbeLNIvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:51:42 -0500
Received: from mail-eopbgr30049.outbound.protection.outlook.com ([40.107.3.49]:57322
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726494AbeLNIvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:51:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zix7hnTfRjrKmWD5LB0+x5k65XN3b581QuuIYuDhud8=;
 b=vADMVyVaNje+44qtzignOhXPx1APPkcorLYdKfE9MJ2kDsOaFLHjGbHb0R8F//o8KEcSU9usgZPWfO1Ziv8a6hUmFK3qgc7nWvj882V4kiW5RxrV883BzA8SwQnMvtZ4NZ8n7OfGFqPeec38bOUJ+lOz7Sd8NEMHzuJT9Xa+J/c=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3690.eurprd04.prod.outlook.com (52.134.70.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Fri, 14 Dec 2018 08:51:38 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 08:51:38 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 2/2] dt-bindings: nvmem: imx-ocotp: add compatible string for
 i.MX7ULP
Thread-Topic: [PATCH 2/2] dt-bindings: nvmem: imx-ocotp: add compatible string
 for i.MX7ULP
Thread-Index: AQHUk4o5GAOQ+5EfPUen2u0v9uFcPQ==
Date:   Fri, 14 Dec 2018 08:51:37 +0000
Message-ID: <1544777136-9195-2-git-send-email-Anson.Huang@nxp.com>
References: <1544777136-9195-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1544777136-9195-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0038.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::26) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3690;6:K4czChgxoO6tytv+JkVKnNd4m6aVwPNrH6RegjdrS2iJCn36aYEB9HfmBHG+MieYUTxCrkPAnzNuUPvMs15U9Jr7t5aQ0ezdMMLSGqhs6h5EFhxuvqGQaaBLGwF2ApWaFdJWeFBBmmi3mjDHKkVW7CwEy8tdbsntsyYEWmGYc82EUdcCzG5SzgVP3U2y4u3I5oGNadnA8vrdN6HqdqjGvb2srelF8/NWHY+GLGZXRGqnEtp+YxUU8CgpXamAakGTIfGE8UUygCzzLQ/mgk+eSJHxzt2/i8jfjnCqUDG/iUIN4jrmDC3LVzbor1GjHqL6PX4unDqerKxMlDrFoFPRlELVAb4jC/QT7U6X8e4pg6H84zfllkvcGQIeXgQvbyjb6g+YlysJjOl85Ebv91UbY4B7lNzW3IcguVcmVPzokVwzeAVEU1cEkt0QZv/FH5wghCncbEJOfbYEpRF3ezEkxQ==;5:hefgr02xLx9OlcH3OTPGmer6N2jXE2LQys/qzmYThpdXO34t5oEAKl9nTTAroXkoSSr6ccQ/WDP3wfVaaZrV/LS3Vg3xBccsjCC7CaGgeGoXlkw4tytVN+bJbakTfRF5U2FeuoZRKs0hqLdjIo1gcP2tpgFEGn5/G6yC/Wy1Xbw=;7:57DAwx+YUDg9MoQ8tCS7h1/2lIcT7tSWvCElKVKkrR1Gryizjw3RZLu2o9CTdOJxvMQVrgrCGd7PWUSKU8Jj+P6d9rtFJzKqUCGaBXBchuicCmOR+D2P7inSlBSvoRQU03MvJDIu2cVMoEiY5J20qg==
x-ms-office365-filtering-correlation-id: c2843f0b-cffc-4f95-bc9a-08d661a15ba8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3690;
x-ms-traffictypediagnostic: DB3PR0402MB3690:
x-microsoft-antispam-prvs: <DB3PR0402MB3690E9113FD2BDA03443D9AAF5A10@DB3PR0402MB3690.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3690;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3690;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(396003)(39860400002)(366004)(199004)(189003)(2501003)(5660300001)(97736004)(66066001)(36756003)(2201001)(71200400001)(6512007)(86362001)(3846002)(6116002)(71190400001)(53936002)(2906002)(305945005)(14454004)(99286004)(4326008)(25786009)(478600001)(6486002)(110136005)(6436002)(50226002)(256004)(8936002)(105586002)(106356001)(81166006)(486006)(316002)(8676002)(81156014)(68736007)(26005)(102836004)(6506007)(386003)(11346002)(476003)(52116002)(2616005)(446003)(7736002)(76176011)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3690;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FLFCWxobXzndmRC7Rk8DANJJxBmJCrUeoIjY3saTkTEfq+7SGIC6OAKIqdhJe3U6w+CVlLHDltol+n4atmB1h0c3g8mZGtkyR/9Mx/zfs+o+R8uRjJMmfQX/H+cl1Kz4qDN1o9iHbHhS+XUXHyw9V7rJNZw4RPkYAX6xPEpGs7WEkoBFTps9sVTBHsx4y3Jr9hIDEgw+qTUcO5i0Z6EdGabrbT17UgyhHghb8ECJzvEF+oS96BbSeKrnzQsO6zhhMmRfJnGsIhIkNdxekkNteuC/qE3UgUXX4tGSmzhM6yI2jpzgNfjjde3PA5LYxxow
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2843f0b-cffc-4f95-bc9a-08d661a15ba8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 08:51:37.9320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3690
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new compatible string for i.MX7ULP SOC.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt b/Docume=
ntation/devicetree/bindings/nvmem/imx-ocotp.txt
index 792bc5f..ff389cf 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
@@ -11,6 +11,7 @@ Required properties:
 	"fsl,imx6ul-ocotp" (i.MX6UL),
 	"fsl,imx7d-ocotp" (i.MX7D/S),
 	"fsl,imx6sll-ocotp" (i.MX6SLL),
+	"fsl,imx7ulp-ocotp" (i.MX7ULP),
 	followed by "syscon".
 - #address-cells : Should be 1
 - #size-cells : Should be 1
--=20
2.7.4

